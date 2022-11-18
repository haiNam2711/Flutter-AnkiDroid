// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../algorithm_sm2/constant.dart';
import '../main.dart';

class SignUpRoute extends StatefulWidget {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  const SignUpRoute({Key? key, required this.fireStore, required this.auth})
      : super(key: key);

  @override
  State<SignUpRoute> createState() => _SignUpRouteState();
}

class _SignUpRouteState extends State<SignUpRoute> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Sign up',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    key: const Key('EmailTextFromField'),
                    controller: emailController,
                    //keyboardType: TextInputType.multiline,
                    // maxLines: null,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      isDense: true,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    key: const Key('PasswordTextFromField'),
                    controller: passwordController,
                    //keyboardType: TextInputType.multiline,
                    // maxLines: null,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      isDense: true,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    key: const Key('ConfirmPasswordTextFromField'),
                    controller: confirmPasswordController,
                    //keyboardType: TextInputType.multiline,
                    // maxLines: null,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      isDense: true,
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      errorText: _passwordErrorText,
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {});
                    },
                    // onTap: () {
                    //   setState(() {});
                    // },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    signUp();
                    setState(() {});
                    //Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have and account ? '),
                  InkWell(
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? get _passwordErrorText {
    var password = passwordController.text.trim();
    var confirm = confirmPasswordController.text.trim();
    if (password != confirm) {
      return 'Passwords must be same';
    }
    return null;
  }

  Future<void> showConfirm(String content) async {
    await showDialog(
      context: context,
      builder: (context) {
        String contentText = content;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(contentText),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> signUp() async {
    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    if (_passwordErrorText != null) {
      showConfirm('Passwords should be the same');
      return;
    }

    try {
      await widget.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception catch (e) {
      showConfirm(e.toString());
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    await Future.delayed(const Duration(milliseconds: Time.loadTime));

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
