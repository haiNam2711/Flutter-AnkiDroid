import 'package:five_control_widget/darkmode/theme.dart';
import 'package:five_control_widget/darkmode/theme_provider.dart';
import 'package:flutter/material.dart';
import 'algorithm_sm2/card.dart';
import 'algorithm_sm2/card_information.dart';
import 'algorithm_sm2/deck_manager.dart';
import 'darkmode/config.dart';
import 'routes/home_route.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase/firebase_options.dart';

void main() async {
  DeckManager.addDeck(deckName: 'deck0');
  DeckManager.addDeck(deckName: 'deck1');
  DeckManager.addDeck(deckName: 'deck2');

  CardInformation frontSide = CardInformation(text: 'this is card 0 front side');
  CardInformation backSide = CardInformation(text: 'this is card 0 back side');
  FlashCard flashCard = FlashCard(frontSide,backSide,DateTime.now());
  //print(deckName);
  DeckManager.addCard(deckName: 'deck0', flashCard: flashCard);

  frontSide = CardInformation(text: 'this is card 1 front side');
  backSide = CardInformation(text: 'this is card 1 back side');
  flashCard = FlashCard(frontSide,backSide,DateTime.now());
  //print(deckName);
  DeckManager.addCard(deckName: 'deck0', flashCard: flashCard);

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: AppTheme().currentTheme(),
      home: const FirstRoute(),

    );
  }
}
