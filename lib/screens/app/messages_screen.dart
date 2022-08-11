import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/prefs/user_preferences_controller.dart';
import 'package:tokoto/widgets/app_app_bar.dart';

final _fireStore = FirebaseFirestore.instance;

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessagesScreen> {
  late TextEditingController _textEditingController;

  String? messageText;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    // getCurrentUser();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const AppAppBar(text: 'Messages', automaticallyImplyLeading: false),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStreamBuilder(),
            Container(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.send,
                      controller: _textEditingController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.color
                            ?.withOpacity(0.6),
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        hintText: 'Write Message here....',
                        prefixIcon: const Icon(
                          Icons.message,
                          color: kPrimaryColor,
                          size: 30,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.color
                              ?.withOpacity(0.5),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_textEditingController.text.isNotEmpty) {
                        _textEditingController.clear();
                        _fireStore
                            .collection('messages')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('message')
                            .add({
                          'text': messageText,
                          'sender': UserPreferencesController().user.email,
                          'time': FieldValue.serverTimestamp()
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: kPrimaryColor,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection('messages')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('message')
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messagesWidgets = [];
        if (!snapshot.hasData || snapshot.data!.size == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: kDefaultPadding * 10),
              Image.asset('images/messages.png'),
              const SizedBox(height: kDefaultPadding),
              const Text(
                'No Messages',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: kPrimaryColor,
                ),
              ),
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(
              radius: 25,
              animating: true,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final messageTime = message.get('time');
          final currentUser = UserPreferencesController().user.email;
          final messageWidget = MessageLine(
            isMe: currentUser == messageSender,
            text: messageText,
            time: messageTime,
          );

          messagesWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            children: messagesWidgets,
          ),
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  final String? text;
  final Timestamp? time;
  final bool isMe;

  const MessageLine(
      {required this.isMe, this.text, required this.time, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: isMe
              ? const EdgeInsets.only(left: 100)
              : const EdgeInsets.only(right: 100),
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 3),
          child: Material(
            elevation: 1,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
            color: isMe ? kPrimaryColor : Theme.of(context).backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 18,
                    color: isMe
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyText1?.color),
              ),
            ),
          ),
        ),
        Text(
          time != null
              ? '${DateTime.fromMillisecondsSinceEpoch(time!.millisecondsSinceEpoch).hour}:${DateTime.fromMillisecondsSinceEpoch(time!.millisecondsSinceEpoch).minute}'
              : 'sending..',
          style: TextStyle(
              fontSize: 16,
              color: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.color
                  ?.withOpacity(0.6)),
        ),
      ],
    );
  }
}
