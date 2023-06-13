import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatefulWidget {
  static const String chatScreenId= '/chatscreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth =FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;
  late String message ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser();
  }
late User LoggedInUser;
  void currentUser(){
    try{
    final user = _auth.currentUser;
    if(user != null){
LoggedInUser=user;
    }}
        catch(e){print(LoggedInUser);}
  }
void getMsgsAndSEmail()async{
    final doc =await _fireStore.collection('msgs').get();
    for (var messages in doc.docs ){
      print(messages.data());
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                getMsgsAndSEmail();
            //    _auth.signOut();
              //  Navigator.pushNamed(context, LoginScreen.loginScreenId);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        message = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      try {
                        final info = _fireStore.collection('msgs').add({
                          'message': message,
                          'user': LoggedInUser.email
                        });
                      }
                      catch(e){print(e);}
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
         Padding(
           padding: const EdgeInsets.all(20.0),
           child: Text('hello'),
         ) ],
          
        ),
      ),
    );
  }
}
