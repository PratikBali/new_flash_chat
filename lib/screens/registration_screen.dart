import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import './chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;

  Widget wRegisterButton() {
    return RoundedButton(
      title: 'Register',
      colour: Colors.blueAccent,
      onPressed: () async {
        setState(() {
          showSpinner = true;
        });
        print('=> email: $email, password: $password');
        try {
          final newUser = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          print('=> Register newUser: $newUser');
          if (newUser != null) {
            Navigator.pushNamed(context, ChatScreen.id);
          }

          setState(() {
            showSpinner = false;
          });
        } catch (e) {
          print(e);
        }
      },
    );
  }

  Widget wRegisterFlexImage = Flexible(
    child: Hero(
      tag: 'logo',
      child: Container(
        height: 200.0,
        child: Image.asset('images/logo.png'),
      ),
    ),
  );
  Widget wRegisterEmailField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      onChanged: (value) {
        email = value;
      },
      decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
    );
  }
  Widget wRegisterPasswordField() {
    return TextField(
      obscureText: true,
      textAlign: TextAlign.center,
      onChanged: (value) {
        password = value;
      },
      decoration: kTextFieldDecoration.copyWith(
          hintText: 'Enter your password'),
    );
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: LoadingOverlay(
          isLoading: showSpinner,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                wRegisterFlexImage,
                const SizedBox(height: 48.0),
                wRegisterEmailField(),
                const SizedBox(height: 8.0),
                wRegisterPasswordField(),
                const SizedBox(height: 24.0),
                wRegisterButton(),
              ],
            ),
          ),
        ),
      );
    }

}

