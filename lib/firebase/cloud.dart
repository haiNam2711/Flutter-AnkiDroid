// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';

import '../algorithm_sm2/card.dart';
import '../algorithm_sm2/card_information.dart';

class Cloud {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;
  late String deckListName;
  Function() setState;

  Cloud(this.fireStore, this.auth, this.setState) {
    deckListName = auth.currentUser?.uid.trim() ?? 'NotFound';
  }

  Future<void> updateCardOnCloud(
      int deckId, String deckName, int cardId, String cardName) async {
    FirebaseFirestore.instance
        .collection(deckListName)
        .doc(deckName)
        .collection('cardList')
        .doc(cardName)
        .set({
      'cardId': cardId,
      'startTime': DeckManager.deckList[deckId].cardList[cardId].startTime,
      'easeFactor': DeckManager.deckList[deckId].cardList[cardId].easeFactor,
      'learnCounter':
          DeckManager.deckList[deckId].cardList[cardId].learnCounter,
      'stateOfCard': DeckManager.deckList[deckId].cardList[cardId].stateOfCard,
      'currentInterval':
          DeckManager.deckList[deckId].cardList[cardId].currentInterval,
      'timeNotification':
          DeckManager.deckList[deckId].cardList[cardId].timeNotification,
      'frontSide': {
        'text': DeckManager.deckList[deckId].cardList[cardId].frontSide?.text,
      },
      'backSide': {
        'text': DeckManager.deckList[deckId].cardList[cardId].backSide?.text,
      },
    })
        // ignore: avoid_print
        //.then((value) => print('Card $cardId is set'))
        // ignore: avoid_print
        .catchError((error) =>
            print('Failed to set Card $cardId on Deck $deckName: $error'));
  }

  Future<void> updateDeckOnCloud(int deckId, String deckName) async {
    FirebaseFirestore.instance.collection(deckListName).doc(deckName).set({
      'deckId': deckId,
      'deckName': deckName,
    })
        // ignore: avoid_print
        //.then((value) => print('Card $cardId is set'))
        // ignore: avoid_print
        .catchError((error) => print('Failed to set Deck $deckName: $error'));
  }

  // Future<void> pushToCloud() async {
  //   CollectionReference deckList = fireStore.collection(deckListName);
  //   print(deckListName);
  //
  //   // Remove excess decks
  //   deckList.get().then((decks) {
  //     for (var deck in decks.docs) {
  //       if (deck.get('deckId') + 1 > DeckManager.deckList.length) {
  //         deckList.doc('deck${deck.get('deckId')}').delete();
  //       }
  //     }
  //   });
  //
  //   // Add current decks
  //   for (int deckId = 0; deckId < DeckManager.deckList.length; ++deckId) {
  //     deckList.doc('deck$deckId').set({
  //       'deckId': deckId, // John Doe
  //       'deckName': DeckManager.deckList[deckId].deckName, // Stokes and Sons
  //     })
  //         // ignore: avoid_print
  //         //.then((value) => print('Deck $deckId is set'))
  //         // ignore: avoid_print
  //         .catchError((error) => print('Failed to set Deck $deckId: $error'));
  //
  //     // Remove excess cards
  //     CollectionReference cardList =
  //         deckList.doc('deck$deckId').collection('cardList');
  //     cardList.get().then((cards) {
  //       for (var card in cards.docs) {
  //         if (card.get('cardId') + 1 >
  //             DeckManager.deckList[deckId].cardList.length) {
  //           cardList.doc('card${card.get('cardId')}').delete();
  //         }
  //       }
  //     });
  //
  //     // Add current cards
  //     for (int cardId = 0;
  //         cardId < DeckManager.deckList[deckId].cardList.length;
  //         ++cardId) {
  //       deckList
  //           .doc('deck$deckId')
  //           .collection('cardList')
  //           .doc('card$cardId')
  //           .set({
  //         'cardId': cardId,
  //         'startTime': DeckManager.deckList[deckId].cardList[cardId].startTime,
  //         'easeFactor':
  //             DeckManager.deckList[deckId].cardList[cardId].easeFactor,
  //         'learnCounter':
  //             DeckManager.deckList[deckId].cardList[cardId].learnCounter,
  //         'stateOfCard':
  //             DeckManager.deckList[deckId].cardList[cardId].stateOfCard,
  //         'currentInterval':
  //             DeckManager.deckList[deckId].cardList[cardId].currentInterval,
  //         'timeNotification':
  //             DeckManager.deckList[deckId].cardList[cardId].timeNotification,
  //         'frontSide': {
  //           'text':
  //               DeckManager.deckList[deckId].cardList[cardId].frontSide?.text,
  //         },
  //         'backSide': {
  //           'text':
  //               DeckManager.deckList[deckId].cardList[cardId].backSide?.text,
  //         },
  //       })
  //           // ignore: avoid_print
  //           //.then((value) => print('Card $cardId is set'))
  //           // ignore: avoid_print
  //           .catchError((error) => print('Failed to set Card $cardId: $error'));
  //     }
  //   }
  // }

  Future<void> pullFromCloud() async {
    CollectionReference deckList = fireStore.collection(deckListName);

    deckList.get().then((decks) {
      for (var deck in decks.docs) {
        String deckName = deck.get('deckName');
        DeckManager.addDeck(deckName: deckName);
        int deckId = DeckManager.deckList.length - 1;

        CollectionReference cardList =
            deckList.doc(deckName).collection('cardList');

        cardList.get().then((cards) {
          for (var card in cards.docs) {
            /// Set time notification for new card
            int timeNotification = card.get('timeNotification').toInt();

            if (timeNotification > 0) {
              Duration duration = DateTime.now()
                  .difference((card.get('startTime') as Timestamp).toDate());
              if (duration.inSeconds >= timeNotification) {
                timeNotification = 0;
              } else {
                timeNotification -= duration.inSeconds;
              }
            }

            /// Set card information for new card
            CardInformation frontSide = CardInformation(
              text: card.get('frontSide')['text'],
            );
            CardInformation backSide = CardInformation(
              text: card.get('backSide')['text'],
            );
            FlashCard flashCard =
                FlashCard(frontSide, backSide, DateTime.now(), setState);

            /// Add new card
            DeckManager.deckList[deckId].addCard(flashCard: flashCard);

            int cardId = DeckManager.deckList[deckId].cardList.length - 1;

            DeckManager.deckList[deckId].cardList[cardId].timeNotification =
                timeNotification.toDouble();
            if (timeNotification > 0) {
              DeckManager.deckList[deckId].cardList[cardId].setTimer();
            }
            DeckManager.deckList[deckId].cardList[cardId].currentInterval =
                card.get('currentInterval');
            DeckManager.deckList[deckId].cardList[cardId].stateOfCard =
                card.get('stateOfCard');
            DeckManager.deckList[deckId].cardList[cardId].learnCounter =
                card.get('learnCounter');
            DeckManager.deckList[deckId].cardList[cardId].easeFactor =
                card.get('easeFactor');
          }
        });
      }
    });
  }
}
