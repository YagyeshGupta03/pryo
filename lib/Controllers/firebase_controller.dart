import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/chats_screen.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/homeScreen.dart';
import 'package:pryo_app/module/chat_lib/src/firebase_chat_core.dart';
import '../Constants/theme_data.dart';
import '../generated/l10n.dart';
import 'package:http/http.dart' as http;


class FirebaseController extends GetxController {
  Logger _l = Logger();

  createFirebaseUser(emailAddress, password, context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (credential.user!.uid.isNotEmpty) {
        // AnimatedSnackBar.material(
        //   'User Registered ${credential.user!.uid.toString()}',
        //   type: AnimatedSnackBarType.success,
        //   mobilePositionSettings: const MobilePositionSettings(
        //     topOnAppearance: 50,
        //   ),
        //   mobileSnackBarPosition: MobileSnackBarPosition.top,
        // ).show(context);
        return credential.user!.uid.toString();
      } else {
        return "";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // AnimatedSnackBar.material(
        //   'The password provided is too weak.',
        //   type: AnimatedSnackBarType.error,
        //   mobilePositionSettings: const MobilePositionSettings(
        //     topOnAppearance: 50,
        //   ),
        //   mobileSnackBarPosition: MobileSnackBarPosition.top,
        // ).show(context);
      } else if (e.code == 'email-already-in-use') {
        // AnimatedSnackBar.material(
        //   'The account already exists for that email.',
        //   type: AnimatedSnackBarType.error,
        //   mobilePositionSettings: const MobilePositionSettings(
        //     topOnAppearance: 50,
        //   ),
        //   mobileSnackBarPosition: MobileSnackBarPosition.top,
        // ).show(context);
      }
    } catch (e) {
      // AnimatedSnackBar.material(
      //   '$e',
      //   type: AnimatedSnackBarType.error,
      //   mobilePositionSettings: const MobilePositionSettings(
      //     topOnAppearance: 50,
      //   ),
      //   mobileSnackBarPosition: MobileSnackBarPosition.top,
      // ).show(context);
    }
  }

  loginFirebaseUser(emailAddress, password, context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      // .onError((error, stackTrace) {
      // AnimatedSnackBar.material(
      //   '${error.toString()}',
      //   type: AnimatedSnackBarType.error,
      //   mobilePositionSettings: const MobilePositionSettings(
      //     topOnAppearance: 50,
      //   ),
      //   mobileSnackBarPosition: MobileSnackBarPosition.top,
      // ).show(context);
      // return context;}
      // );
      if (credential.user!.uid.isNotEmpty) {
        return credential.user!.email;
      } else {
        return "";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // AnimatedSnackBar.material(
        //   'No user found for that email',
        //   type: AnimatedSnackBarType.error,
        //   mobilePositionSettings: const MobilePositionSettings(
        //     topOnAppearance: 50,
        //   ),
        //   mobileSnackBarPosition: MobileSnackBarPosition.top,
        // ).show(context);
        return "";
      } else if (e.code == 'wrong-password') {
        // AnimatedSnackBar.material(
        //   'Wrong password provided for that user.',
        //   type: AnimatedSnackBarType.error,
        //   mobilePositionSettings: const MobilePositionSettings(
        //     topOnAppearance: 50,
        //   ),
        //   mobileSnackBarPosition: MobileSnackBarPosition.top,
        // ).show(context);
        return "";
      }
    }
  }

  Future<bool> firebaseSignUp(emailAddress, password, context) async {
    String exists = await loginFirebaseUser(emailAddress, password, context);
    if (exists.isEmpty) {
      String response =
          await createFirebaseUser(emailAddress, password, context);
      if (response.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  Future<bool> firebaseSignIn(emailAddress, password, context) async {
    String exists = await loginFirebaseUser(emailAddress, password, context);
    if (exists.isEmpty) {
      String response =
          await createFirebaseUser(emailAddress, password, context);
      if (response.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  firebaseLogout() {
    FirebaseAuth.instance.signOut();
  }

  changePassword(password) {
    FirebaseAuth.instance.currentUser!.updatePassword(password).then(
      (value) {
        FirebaseAuth.instance.signOut();
      },
    );
  }

  ///Firebase chat
  ///
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String fcmToken = '';

  createFirebaseChat(fullName, email, userId, phone) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    fcmToken = await _firebaseMessaging.getToken() ?? '';
    _l.d(fcmToken);

    return FirebaseFirestore.instance
        .collection("user")
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) async {
      if (!value.exists) {
        await FirebaseChatCore.instance.createUserInFirestore(types.User(
            id: auth.currentUser!.uid,
            firstName: fullName.toString(),
            lastName: '',
            createdAt: DateTime.now().microsecond,
            metadata: {
              "email": email.toString(),
              "user_id": userId.toString(),
              "phone": phone.toString(),
              "token": fcmToken.toString(),
            }));
        return true;
      } else {
        return false;
      }
    });
  }

  createChatRoom(context, userId, fullName, email, phone) {
    AnimatedSnackBar.material(
      S.of(context).pleaseWait,
      type: AnimatedSnackBarType.info,
      mobilePositionSettings: const MobilePositionSettings(
        topOnAppearance: 50,
      ),
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    ).show(context);
    FirebaseFirestore.instance
        .collection("user")
        .where("metadata.user_id", isEqualTo: "$userId")
        .get()
        .then((value) async {
      print(value.size);
      // print(value.docs.first.get("metadata.token"));
      if (value.size > 0) {
        var otherUser = types.User(
            id: value.docs[0].id,
            firstName: fullName,
            lastName: '',
            createdAt: DateTime.now().microsecond,
            metadata: {
              "email": email,
              "user_id": userId,
              "phone": phone,
              "token": value.docs.first.get("metadata.token"),
            });

        FirebaseChatCore.instance.createRoom(otherUser, metadata: {
          "$userId": 0,
          "${credentialController.id}": 0,
          "last": "",
          "$userId-active": false,
          "${credentialController.id}-active": false,
        }).then((rooms) {
          print(value.docs.first.get("metadata.token"));
          print(otherUser.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                room: rooms,
                otherUserID: userId,
                token: value.docs.first.get("metadata.token"),
              ),
            ),
          );
        });
      } else {
        AnimatedSnackBar.material(
          S.of(context).notAvailableForChat,
          type: AnimatedSnackBarType.error,
          mobilePositionSettings: const MobilePositionSettings(
            topOnAppearance: 50,
          ),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
      }
    });
  }

  ///Get Chat List
  getChatHomePage(context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return FirebaseFirestore.instance
        .collection("rooms")
        .where("userIds", arrayContains: auth.currentUser!.uid)
        .orderBy("updatedAt", descending: true)
        .snapshots();
  }

  //Delete Chat
  deleteChat(context, roomId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Provider.of<ThemeProvider>(context)
                .currentTheme
                .scaffoldBackgroundColor,
            // title: Text('Are You Sure?', style: Provider.of<ThemeProvider>(context)
            //     .currentTheme.textTheme.displaySmall,),
            content: Text(
              'Are you sure, you want to delete conversation?',
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .displayMedium,
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    FirebaseChatCore.instance
                        .deleteRoom(roomId.toString())
                        .whenComplete(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                      AnimatedSnackBar.material(
                        'Conversation Deleted',
                        type: AnimatedSnackBarType.error,
                        mobilePositionSettings: const MobilePositionSettings(
                          topOnAppearance: 50,
                        ),
                        mobileSnackBarPosition: MobileSnackBarPosition.top,
                      ).show(context);
                    });
                  },
                  child: Text(
                    'Delete',
                    style: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .textTheme
                        .displaySmall,
                  )),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel',
                    style: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .textTheme
                        .displaySmall),
              ),
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          );
        });
  }

  reportUser(context, roomId, reportedBy, reportedTo) {
    FirebaseFirestore.instance.collection("rooms").doc(roomId).set({
      "metadata": {
        "reported_by": "$reportedBy",
        "reported_to": "$reportedTo",
      }
    }, SetOptions(merge: true)).whenComplete(() {
      AnimatedSnackBar.material(
        'Blocked Successfully',
        type: AnimatedSnackBarType.error,
        mobilePositionSettings: const MobilePositionSettings(
          topOnAppearance: 50,
        ),
        mobileSnackBarPosition: MobileSnackBarPosition.top,
      ).show(context);
      Navigator.pop(context);
    });
  }

  removeReportUser(context, roomId) {
    FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .set({"metadata": null}, SetOptions(merge: true)).whenComplete(() {
      AnimatedSnackBar.material(
        'Unblocked Successfully',
        type: AnimatedSnackBarType.error,
        mobilePositionSettings: const MobilePositionSettings(
          topOnAppearance: 50,
        ),
        mobileSnackBarPosition: MobileSnackBarPosition.top,
      ).show(context);
      Navigator.pop(context);
    });
  }

  Future sendNotification(
      String to, String title, String body, Map<String, String> data) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAyDUBGPc:APA91bFta5Dw1QmxUgu0DFRMqmITkY0XWpTUDl7cNkCEzeth2yuSjw9BGGxrS69ZelP758BRLqv3StW_z-2eTbOhP6EmHHj8uwlvUItGpIS_r_cH3iednwbAavc83Eexo1ZmiwVy-PRy'
    };
    var request =
        http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "to": to,
      "notification": {"title": title, "body": body, "mutable_content": true},
      "data": data,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 30));
    print(request.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('notification sent');
      return true;
    } else {
      print('notification not sent');
      return false;
    }
  }

  getSingleUserDetails(userId) {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .snapshots();
  }

  //increase Chat Count
  increaseChatCount(roomId, otherUserId) {
    FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .update({"metadata.$otherUserId": FieldValue.increment(1)});
  }

  deleteMessage(roomId, messageId) {
    FirebaseChatCore.instance.deleteMessage(roomId, messageId);
  }

  //increase Chat Count
  updateSeenMessages(roomId, userID) {
    FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .update({"metadata.$userID": '0'});
  }

  lastChatUpdate(roomId, message) {
    FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .update({"metadata.last": message});
  }

  firebaseTokenUpdate() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseMessaging message = FirebaseMessaging.instance;
    String updateToken = await message.getToken() ?? '';
    FirebaseFirestore.instance
        .collection("user")
        .doc(auth.currentUser!.uid)
        .update({"metadata.token": updateToken});
    _l.d("Token Update");
  }

  updateActiveChats({String? roomId, String? userId, bool? status}) {
    FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .update({"metadata.$userId-active": status});
  }
}
