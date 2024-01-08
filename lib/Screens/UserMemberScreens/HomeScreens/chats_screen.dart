import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import '../../../Constants/theme_data.dart';
import '../../../generated/l10n.dart';
import '../../../module/chat_lib/src/firebase_chat_core.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.room,
    required this.otherUserID,
    required this.token,
  });

  final types.Room room;
  final String otherUserID;
  final String token;
  // final String name;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isAttachmentUploading = false;

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(S.of(context).photo),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(S.of(context).file),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(S.of(context).cancel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      _setAttachmentUploading(true);
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialFile(
          mimeType: lookupMimeType(filePath),
          name: name,
          size: result.files.single.size,
          uri: uri,
        );

        FirebaseChatCore.instance.sendMessage(message, widget.room.id);
        firebase.sendNotification(
            widget.token, 'New Attachment', message.toString(), {});
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
        );
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handleMessageLongPress(BuildContext _, types.Message message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Provider.of<ThemeProvider>(context).currentTheme.cardColor,
          content: Text('Do you want to delete this message?',
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .displayMedium),
          actions: [
            TextButton(
              onPressed: () {
                firebase.deleteMessage(widget.room.id, message.id);
                Navigator.pop(context);
              },
              child: Text('Delete',
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .displayMedium),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel',
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .displayMedium),
            ),
          ],
        );
      },
    );
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
    firebase.increaseChatCount(widget.room.id, widget.otherUserID);
    FirebaseFirestore.instance
        .collection("rooms")
        .doc(widget.room.id)
        .get()
        .then((value) {
      bool active = value.get("metadata.${widget.otherUserID}-active");
      active
          ? print(active)
          : firebase.sendNotification(widget.token, 'New message',
              'You have received a new message', {});
    });
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  @override
  void initState() {
    super.initState();
    firebase.updateSeenMessages(
        widget.room.id.toString(), credentialController.id.toString());
    firebase.updateActiveChats(
        roomId: widget.room.id.toString(),
        userId: credentialController.id.toString(),
        status: true);
  }

  @override
  void dispose() {
    super.dispose();
    firebase.updateActiveChats(
        roomId: widget.room.id.toString(),
        userId: credentialController.id.toString(),
        status: false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios),
              color: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .iconTheme
                  .color,
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(S.of(context).chat,
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .displayLarge),
          backgroundColor: Colors.transparent,
        ),
        body: StreamBuilder<types.Room>(
          initialData: widget.room,
          stream: FirebaseChatCore.instance.room(widget.room.id),
          builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.messages(snapshot.data!),
            builder: (context, snapshot) => Chat(
              isAttachmentUploading: _isAttachmentUploading,
              theme: DefaultChatTheme(
                backgroundColor: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .scaffoldBackgroundColor,
                primaryColor: primaryColor,
                attachmentButtonIcon: const Icon(
                  Icons.add_circle,
                  color: primaryColor,
                  size: 35,
                ),
                attachmentButtonMargin: const EdgeInsets.all(0),
                secondaryColor: circleClr,
                messageBorderRadius: 20,
                inputBorderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10), bottom: Radius.circular(10)),
                inputMargin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                inputTextDecoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    isCollapsed: false),
                inputTextStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                inputPadding: const EdgeInsets.all(10),
                inputBackgroundColor: const Color(0XFFFE6D0B).withOpacity(0.30),
                inputContainerDecoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent)),
                messageInsetsHorizontal: 15,
                messageInsetsVertical: 5,
                inputTextColor:
                    Provider.of<ThemeProvider>(context).currentTheme.focusColor,
              ),
              messages: snapshot.data ?? [],
              onAttachmentPressed: _handleAttachmentPressed,
              onMessageTap: _handleMessageTap,
              onMessageDoubleTap: _handleMessageLongPress,
              onMessageLongPress: _handleMessageLongPress,
              onPreviewDataFetched: _handlePreviewDataFetched,
              onSendPressed: _handleSendPressed,
              user: types.User(
                id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
              ),
            ),
          ),
        ),
      );
}

// import 'package:flutter/material.dart';
//
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
