import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';

import '../algorithm_sm2/card.dart';
import '../algorithm_sm2/card_information.dart';

class PushToCloud extends StatelessWidget {
  const PushToCloud({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    CollectionReference deckList = firestore.collection('deckList');

    Future<void> pushToCloud() async {
      for (int deckId = 0; deckId < DeckManager.deckList.length; ++deckId) {
        deckList.doc('deck[$deckId]').set({
          'deckId': deckId, // John Doe
          'deckName': DeckManager.deckList[deckId].deckName, // Stokes and Sons
        })
            // ignore: avoid_print
            //.then((value) => print('Deck $deckId is set'))
            // ignore: avoid_print
            .catchError((error) => print('Failed to set Deck $deckId: $error'));

        for (int cardId = 0;
            cardId < DeckManager.deckList[deckId].cardList.length;
            ++cardId) {
          deckList
              .doc('deck[$deckId]')
              .collection('cardList')
              .doc('card[$cardId]')
              .set({
            'cardId': cardId,
            'startTime':
                DeckManager.deckList[deckId].cardList[cardId].startTime,
            'easeFactor':
                DeckManager.deckList[deckId].cardList[cardId].easeFactor,
            'learnCounter':
                DeckManager.deckList[deckId].cardList[cardId].learnCounter,
            'stateOfCard':
                DeckManager.deckList[deckId].cardList[cardId].stateOfCard,
            'currentInterval':
                DeckManager.deckList[deckId].cardList[cardId].currentInterval,
            'timeNotification':
                DeckManager.deckList[deckId].cardList[cardId].timeNotification,
            'frontSide': {
              'text':
                  DeckManager.deckList[deckId].cardList[cardId].frontSide?.text,
            },
            'backSide': {
              'text':
                  DeckManager.deckList[deckId].cardList[cardId].backSide?.text,
            },
          })
              // ignore: avoid_print
              //.then((value) => print('Card $cardId is set'))
              // ignore: avoid_print
              .catchError(
                  (error) => print('Failed to set Card $cardId: $error'));
        }
      }
    }

    return TextButton(
      onPressed: pushToCloud,
      child: const Text(
        'Push To Cloud',
      ),
    );
  }
}

class PullFromCloud extends StatelessWidget {
  const PullFromCloud({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference deckList =
        FirebaseFirestore.instance.collection('deckList');

    Future<void> pullFromCloud() async {
      deckList.snapshots().listen((decks) {
        for (var deck in decks.docs) {
          if (DeckManager.deckList.length < deck.get('deckId') + 1) {
            DeckManager.addDeck(deckName: deck.get('deckName'));
          }

          CollectionReference cardList = deckList
              .doc('deck[${deck.get('deckId')}]')
              .collection('cardList');
          cardList.snapshots().listen((cards) {
            for (var card in cards.docs) {
              int timeNotification = card.get('timeNotification').toInt();

              if (timeNotification > 0) {
                Duration duration = DateTime.now()
                    .difference((card.get('startTime') as Timestamp).toDate());
                print(duration.inSeconds);
                if (duration.inSeconds >= timeNotification) {
                  timeNotification = 0;
                } else {
                  timeNotification -= duration.inSeconds;
                }
              }

              if (DeckManager.deckList[deck.get('deckId')].cardList.length <
                  card.get('cardId') + 1) {
                CardInformation frontSide = CardInformation(
                  text: card.get('frontSide')['text'],
                );
                CardInformation backSide = CardInformation(
                  text: card.get('backSide')['text'],
                );
                FlashCard flashCard =
                    FlashCard(frontSide, backSide, DateTime.now());
                DeckManager.deckList[deck.get('deckId')]
                    .addCard(flashCard: flashCard);
              } else {
                DeckManager.deckList[deck.get('deckId')]
                    .cardList[card.get('cardId')].frontSide = CardInformation(
                  text: card.get('frontSide')['text'],
                );
                DeckManager.deckList[deck.get('deckId')]
                    .cardList[card.get('cardId')].backSide = CardInformation(
                  text: card.get('backSide')['text'],
                );
              }

              DeckManager
                  .deckList[deck.get('deckId')]
                  .cardList[card.get('cardId')]
                  .timeNotification = timeNotification.toDouble();
              if (timeNotification > 0) {
                DeckManager
                    .deckList[deck.get('deckId')].cardList[card.get('cardId')]
                    .setTimer();
              }
              DeckManager
                  .deckList[deck.get('deckId')]
                  .cardList[card.get('cardId')]
                  .currentInterval = card.get('currentInterval');
              DeckManager
                  .deckList[deck.get('deckId')]
                  .cardList[card.get('cardId')]
                  .stateOfCard = card.get('stateOfCard');
              DeckManager
                  .deckList[deck.get('deckId')]
                  .cardList[card.get('cardId')]
                  .learnCounter = card.get('learnCounter');
              DeckManager
                  .deckList[deck.get('deckId')]
                  .cardList[card.get('cardId')]
                  .easeFactor = card.get('easeFactor');
            }
          });
        }
      });

      //print('deck list is pulled from cloud!');
    }

    return TextButton(
      onPressed: pullFromCloud,
      child: const Text(
        'Pull From Cloud',
      ),
    );
  }
}
