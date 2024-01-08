import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Controllers/firebase_controller.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/chats_screen.dart';
import '../../../Constants/theme_data.dart';
import '../../../Controllers/notifications_controller.dart';
import '../../../generated/l10n.dart';
import '../../../module/chat_lib/src/firebase_chat_core.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChatHomeScreenState();
}

class ChatHomeScreenState extends State<ChatHomeScreen> {
  final FirebaseController _firebaseController = Get.put(FirebaseController());
  List userGallaryNetwork = [
    'https://helios-i.mashable.com/imagery/articles/03zG40XkMr40hQ1X98NEPfk/hero-image.fill.size_1200x1200.v1623374548.jpg',
    'https://media.vogue.co.uk/photos/5d54ba84ea07410008b990d9/2:3/w_2560%2Cc_limit/original',
    'https://media.gq-magazine.co.uk/photos/5d13981841f50e08bf8c45dc/master/pass/image.jpg'
  ];

  String? firebaseId;

  getId() {
    FirebaseAuth auth = FirebaseAuth.instance;
    firebaseId = auth.currentUser!.uid;
  }

  @override
  void initState() {
    super.initState();
    getId();
    FCM().setNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        elevation: 0,
        title: Text(
          S.of(context).chats,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .displayLarge,
        ),
        backgroundColor: Provider.of<ThemeProvider>(context)
            .currentTheme
            .scaffoldBackgroundColor,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: firebase.getChatHomePage(context),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> chat) {
                  if (chat.hasData) {
                    return chat.data!.size > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: chat.data!.size,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot data = chat.data!.docs[index];

                              getOtherId() {
                                List id = data.get("userIds");
                                id.remove(firebaseId);
                                print(id.first);
                                return id.first;
                              }

                              return StreamBuilder<DocumentSnapshot>(
                                  stream: firebase
                                      .getSingleUserDetails(getOtherId()),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      return StreamBuilder<Room>(
                                          stream: FirebaseChatCore.instance
                                              .room(chat.data!.docs[index].id),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<Room> roomId) {
                                            if (roomId.hasData) {
                                              return Card(
                                                color:
                                                    Provider.of<ThemeProvider>(
                                                            context)
                                                        .currentTheme
                                                        .cardColor,
                                                child: ListTile(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatScreen(
                                                          room: roomId.data!,
                                                          otherUserID: snapshot
                                                                  .data!
                                                                  .get(
                                                                      'metadata')[
                                                              'user_id'],
                                                          token: snapshot.data!
                                                                  .get(
                                                                      'metadata')[
                                                              'token'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Text(
                                                        "${snapshot.data!.get("firstName")}"[
                                                                0]
                                                            .toUpperCase()),
                                                  ),
                                                  title: Text(
                                                    "${snapshot.data!.get("firstName")}"
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Provider.of<
                                                                ThemeProvider>(
                                                            context)
                                                        .currentTheme
                                                        .textTheme
                                                        .displayMedium,
                                                  ),
                                                  trailing: data.get(
                                                              "metadata.${credentialController.id.toString()}") ==
                                                          '0'
                                                      ? const SizedBox()
                                                      : Text(
                                                          "${data.get("metadata.${credentialController.id.toString()}")}",
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                  // trailing: IconButton(
                                                  //   onPressed: () {
                                                  //     _firebaseController
                                                  //         .deleteChat(
                                                  //             context, roomId);
                                                  //   },
                                                  //   icon: const Icon(
                                                  //       Icons.delete, color: Colors.red,),
                                                  // ),
                                                  // subtitle: Text(
                                                  //     "${snapshot.data!.get("firstName")}"
                                                  //         .toString(),
                                                  //     style: const TextStyle(
                                                  //         fontWeight:
                                                  //         FontWeight
                                                  //             .w600),),
                                                ),
                                              );
                                            } else if (roomId.hasError) {
                                              return const Icon(
                                                  Icons.error_outline);
                                            } else {
                                              return Container();
                                            }
                                          });
                                    } else if (snapshot.hasError) {
                                      return const Icon(Icons.error_outline);
                                    } else {
                                      return Container();
                                    }
                                  });
                            },
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * .7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: Text(S.of(context).noConversation)),
                                // Text(S.of(context).noMessageInChat)
                              ],
                            ));
                  } else if (chat.hasError) {
                    return const Icon(Icons.error_outline);
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
