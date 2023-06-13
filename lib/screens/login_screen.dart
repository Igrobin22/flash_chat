import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../reusableButton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String loginScreenId = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _loadingCheck = false;
  bool eyeIcon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _loadingCheck,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
              const SizedBox(
                height: 48.0,
              ),
              TextField(

                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;

                    //Do something with the user input.
                  },
                  decoration: kInputDecorationTextField.copyWith(
                      hintText: 'Enter your email')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(

                obscureText: eyeIcon,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kInputDecorationTextField.copyWith(
                    suffixIcon: TextButton(
                        onPressed: () {
                          setState(() {
                            if(eyeIcon==true){
                              eyeIcon=false;
                            }
                            else{eyeIcon=true;}
                          });
                        },
                        child:eyeIcon==true ? Icon(
                          Icons.remove_red_eye_outlined,
                        ) :Icon(
                          Icons.remove_red_eye,
                        ) ),
                    hintText: 'Enter your password'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              reusableButton(
                colour: Colors.lightBlueAccent,
                buttonText: 'Log in',
                onPressed: () async {
                  try {
                    _loadingCheck = true;
                    final checkuser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (checkuser != null) {
                      _loadingCheck = false;
                      Navigator.pushNamed(context, ChatScreen.chatScreenId);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
