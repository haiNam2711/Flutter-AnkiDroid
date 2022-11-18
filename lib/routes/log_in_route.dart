// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:five_control_widget/routes/sign_up_route.dart';
import 'package:flutter/material.dart';

import '../algorithm_sm2/constant.dart';
import '../main.dart';

class LogInRoute extends StatefulWidget {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  const LogInRoute({Key? key, required this.fireStore, required this.auth})
      : super(key: key);

  @override
  State<LogInRoute> createState() => _LogInRouteState();
}

class _LogInRouteState extends State<LogInRoute> {
  final emailController =
      TextEditingController(); // control text of front text field
  final passwordController =
      TextEditingController(); // control text of back text field
  bool showAnswer = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
            'Log in',
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(60, 0, 30, 0),
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
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                        child: TextFormField(
                          key: const Key('PasswordTextFromField'),
                          controller: passwordController,
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
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    logIn();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    'Log in',
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
                  const Text('New User ? '),
                  InkWell(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpRoute(
                                  auth: widget.auth,
                                  fireStore: widget.fireStore,
                                )),
                      );
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

  Future logIn() async {
    try {
      await widget.auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on Exception catch (e) {
      showConfirm(e.toString());
      return;
    }
  }
}
