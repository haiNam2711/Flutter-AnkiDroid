import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_control_widget/dark_mode/theme.dart';
import 'package:five_control_widget/dark_mode/theme_provider.dart';
import 'package:five_control_widget/routes/log_in_route.dart';
import 'package:flutter/material.dart';
import 'dark_mode/config.dart';
import 'routes/home_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:five_control_widget/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    appTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'AnkiDroid',
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: AppTheme().currentTheme(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeRoute(
              fireStore: FirebaseFirestore.instance,
              userId: FirebaseAuth.instance.currentUser?.uid.trim() ?? 'NotFound',
              userEmail: FirebaseAuth.instance.currentUser?.email ?? 'Wrong',
              logOut: logOut,
            );
          } else {
            // Go to login page.
            return LogInRoute(
              fireStore: FirebaseFirestore.instance,
              auth: FirebaseAuth.instance,
            );
          }
        },
      ),
    );
  }
}
