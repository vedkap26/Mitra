import "package:chat_app/widgets/chat_messages.dart";
import "package:chat_app/widgets/new_messages.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_messaging/firebase_messaging.dart";
//import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    // final token = await fcm.getToken();
    //print(token);
    fcm.subscribeToTopic('Chat');
  }

  @override
  void initState() {
    super.initState();

    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter chat'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      // body: const Center(
      //   child: Text('Logged in'),
      body: Column(
        children: const [
          Expanded(
            child: ChatMessages(),
          ),
          //ChatMessages(),
          NewMessage(),
        ],
      ),
    );
  }
}
