import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timemanager/Screens/chat_screen.dart';
import 'package:timemanager/UserInterface/constants.dart';
import 'registration_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'chat_icon',
                  child: Container(
                    height: 200.0,
                    child: Icon(
                      Icons.chat,
                      size: 150.0,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 42.0,
              ),
              TextField(
                controller: emailController,
                onChanged: (value) {
                  email = value;
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'username@email.com',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: passwordController,
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Password',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        emailController.clear();
                        passwordController.clear();
                        if (newUser != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0),
                child: Material(
                  color: Colors.blueAccent,
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
