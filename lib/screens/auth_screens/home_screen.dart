import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_chat/constants/colors.dart';
import 'package:learn_chat/constants/constants.dart';
import 'package:learn_chat/models/message_model.dart';
import 'package:learn_chat/services/providers/auth_provider.dart';
import 'package:learn_chat/services/providers/firebase_provider.dart';
import 'package:learn_chat/widgets/message_container.dart';
import 'package:provider/provider.dart';

// Chat Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String screenRoute = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? messageText;

  TextEditingController textEditingController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    User? currentUser = Provider.of<AuthProvider>(context).getCurrentUser();
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(kMessagesCollection)
            .orderBy('created At')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(
                child: Text('Loading...'),
              ),
            );
          }
          List<MessageModel> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(
              MessageModel.fromJson(snapshot.data!.docs[i]),
            );
          }
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kMainColor,
                centerTitle: true,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              body: !snapshot.hasData
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            reverse: true,
                            itemCount: messageList.length,
                            itemBuilder: (context, index) {
                              return currentUser!.email ==
                                      messageList[index].sender
                                  ? MessageContainer(
                                      text:
                                          messageList[index].message.toString(),
                                      isSender: true,
                                    )
                                  : MessageContainer(
                                      text:
                                          messageList[index].message.toString(),
                                      isSender: false,
                                    );
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: textEditingController,
                            onChanged: (text) {
                              messageText = text;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your message ..',
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.send,
                                  color: kMainColor,
                                ),
                                onPressed: () {
                                  textEditingController.clear();
                                  if (messageText != null) {
                                    FirebaseProvider().addMessage(
                                      text: messageText!,
                                      sender: currentUser!.email.toString(),
                                      createdAt: DateTime.now(),
                                    );
                                    FocusScope.of(context).unfocus();
                                    _scrollController.animateTo(
                                      // _scrollController
                                      //     .position.maxScrollExtent,
                                      0,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastOutSlowIn,
                                    );
                                    //messageList.clear();
                                  }
                                },
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: kMainColor,
                                  width: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
        });
  }
}
