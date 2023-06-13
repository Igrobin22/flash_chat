
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../reusableButton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flash_chat/user_Repository.dart';
class RegistrationScreen extends StatefulWidget {
  static const String registrationScreenId = '/signup';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
   database(UserModal userModal)async{
   await _db.collection('ePass').add(userModal.toJson()).whenComplete(() => SnackBar(content: Text('Complete sucessfully')));
  }
  late String email;
  late String pass;
   bool _loadingSwitcher = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall:_loadingSwitcher ,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(

                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email =value;
                    //Do something with the user input.
                  },
                  decoration: kInputDecorationTextField.copyWith(
                      hintText: 'Enter your email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(

                obscureText: true,
                onChanged: (value) {
                  pass = value;
                  //Do something with the user input.
                },
                decoration: kInputDecorationTextField.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              reusableButton(

                  colour: Colors.blueAccent,
                  buttonText: 'Register',
                  onPressed: ()async{
                    try {
                      setState(() {
                        _loadingSwitcher=true;
                      });
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: pass);
                      UserModal userModal =UserModal(email: email, password: pass);
                     await database(userModal);
                      if (newUser != null) {
                        _loadingSwitcher=false;
                        Navigator.pushNamed(context, ChatScreen.chatScreenId);

                      }
                    }
                    catch(e){
                      print(e);
                    }
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
