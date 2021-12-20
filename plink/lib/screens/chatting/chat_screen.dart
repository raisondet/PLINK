//import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plink/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:plink/colors.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/services.dart';
import 'package:plink/size_config.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInuser;
final focusNode = FocusNode();

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  static String routeName = "/chatting";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;
  var messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {
      setState(() {
        this.isKeyboardVisible = isKeyboardVisible;
      });

      if (isKeyboardVisible && isEmojiVisible) {
        setState(() {
          isEmojiVisible = false;
        });
      }
    });
  }

  Future toggleEmojiKeyboard() async {
    if (isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }

    setState(() {
      isEmojiVisible = !isEmojiVisible;
    });
  }

  Future<bool> onBackPress() {
    if (isEmojiVisible) {
      toggleEmojiKeyboard();
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  @override
  void dispose() async {
    super.dispose();
    await _auth.signOut();
  }

  void getCurrentUser() {
    try {
      // TODO : CHECK
      final user = _auth.currentUser;
      if (user != null) {
        loggedInuser = user;
        print(loggedInuser);
      }
    } catch (e) {
      print(e);
    }
  }

  void onEmojiSelected(String emoji) => setState(() {
        controller.text = controller.text + emoji;
      });

  @override
  Widget build(BuildContext context) {
    Widget buildSticker() {
      return Container();
      /*return EmojiPicker(
        onEmojiSelected: (emoji, category) {
          onEmojiSelected(category.emoji);
        },
      );*/
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messages",
          style: TextStyle(
            color: kTextColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: onBackPress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
              Container(
                width: double.infinity,
                height: getProportionateScreenHeight(60),
                decoration: new BoxDecoration(
                    border: new Border(
                        top:
                            new BorderSide(color: Colors.blueGrey, width: 0.5)),
                    color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      child: new Container(
                        margin: new EdgeInsets.symmetric(horizontal: 1.0),
                        child: new IconButton(
                          icon: new Icon(isEmojiVisible
                              ? Icons.keyboard_rounded
                              : Icons.emoji_emotions),
                          onPressed: onClickedEmoji,
                          color: Colors.blueGrey,
                        ),
                      ),
                      color: Colors.white,
                    ),
                    Flexible(
                      child: Container(
                        height: getProportionateScreenHeight(30),
                        child: TextField(
                          textInputAction: TextInputAction.send,
                          keyboardType: TextInputType.multiline,
                          focusNode: focusNode,
                          onSubmitted: (value) {
                            controller.clear();
                            _firestore.collection('messages').add({
                              'sender': 'raisondet@gmail.com',
                              //loggedInuser!.email,
                              'text': messageText,
                              'timestamp': Timestamp.now(),
                            });
                          },
                          maxLines: null,
                          controller: controller,
                          onChanged: (value) {
                            messageText = value;
                          },
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 17.0,
                              /*height: 30.0*/),
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                    ),
                    Material(
                      child: new Container(
                        margin: new EdgeInsets.symmetric(horizontal: 8.0),
                        child: new IconButton(
                          icon: new Icon(Icons.send),
                          onPressed: () {
                            controller.clear();
                            _firestore.collection('messages').add({
                              'sender': 'raisondet@gmail.com',
                              //loggedInuser!.email,
                              'text': messageText,
                              'timestamp': Timestamp.now(),
                            });
                          },
                          color: Colors.blueGrey,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              (isEmojiVisible ? buildSticker() : Container()),
            ],
          ),
        ),
      ),
    );
  }

  void onClickedEmoji() async {
    if (isEmojiVisible) {
      focusNode.requestFocus();
    } else if (isKeyboardVisible) {
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await Future.delayed(Duration(milliseconds: 100));
    }
    toggleEmojiKeyboard();
  }
}

String giveUsername(String email) {
  return email.replaceAll(new RegExp(r'@g(oogle)?mail\.com$'), '');
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          // Sort the messages by timestamp DESC because we want the newest messages on bottom.
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("snapshot error!!!");
        }
        // If we do not have data yet, show a progress indicator.
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // Create the list of message widgets.
        List<Widget> messageWidgets = snapshot.data!.docs.map<Widget>((m) {
          final data = m.data as dynamic;
          final messageText = data()['text'];
          final messageSender = data()['sender'];
          final currentUser = 'raisondet@gmail.com'; //loggedInuser!.email;
          final timeStamp = data()['timestamp'];
          return MessageBubble(
            sender: messageSender,
            text: messageText,
            timestamp: timeStamp,
            isMe: currentUser == messageSender,
          );
        }).toList();

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.timestamp, this.isMe});

  final String? sender;
  final String? text;
  final Timestamp? timestamp;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp!.seconds * 1000);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${giveUsername(sender!)}",
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: isMe!
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color:
                isMe! ? PalletteColors.primaryGrey : PalletteColors.lightBlue,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment:
                    isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    text!,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: isMe! ? Colors.white : Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      "${DateFormat('h:mm a').format(dateTime)}",
                      style: TextStyle(
                        fontSize: 9.0,
                        color: isMe!
                            ? Colors.white.withOpacity(0.5)
                            : Colors.black54.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
