import 'package:five_control_widget/darkmode/theme.dart';
import 'package:flutter/material.dart';
import 'algorithm_sm2/card.dart';
import 'algorithm_sm2/card_information.dart';
import 'algorithm_sm2/deck_manager.dart';
import 'darkmode/config.dart';
import 'first_route.dart';
import 'package:five_control_widget/darkmode/theme.dart';
import 'package:flutter/material.dart';
import 'darkmode/config.dart';
import 'first_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  DeckManager.addDeck(deckName: 'text');
  DeckManager.addDeck(deckName: 'text1');
  DeckManager.addDeck(deckName: 'text2');

  CardInformation frontSide = CardInformation('1');
  CardInformation backSide = CardInformation('1');
  FlashCard flashCard = FlashCard(frontSide,backSide);
  //print(deckName);
  DeckManager.addCard(deckName: 'text', flashCard: flashCard);

  frontSide = CardInformation('2');
  backSide = CardInformation('2');
  flashCard = FlashCard(frontSide,backSide);
  //print(deckName);
  DeckManager.addCard(deckName: 'text', flashCard: flashCard);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    appTheme.addListener((){
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnkiDroid',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: AppTheme().currentTheme(),
      home: const FirstRoute(),

    );
  }
}
