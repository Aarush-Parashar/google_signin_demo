import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  void _handleGoogleSign() {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _googleSignInButton() {
      return Center(
        child: SizedBox(
          height: 50,
          child: SignInButton(
            Buttons.google,
            text: 'Signup with Google',
            onPressed: _handleGoogleSign,
          ),
        ),
      );
    }

    Widget _userInfo() {
      return SizedBox();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign-In'),
      ),
      body: _user != null ? _userInfo() : _googleSignInButton(),
    );
  }
}
