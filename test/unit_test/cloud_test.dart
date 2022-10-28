import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:five_control_widget/algorithm_sm2/card.dart';
import 'package:five_control_widget/algorithm_sm2/card_information.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:five_control_widget/firebase/cloud.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fireStore = FakeFirebaseFirestore();
  final cloud = Cloud(fireStore);
  test('Pushing function should work correctly', () {
    for (int i = 0; i < 10; ++i) {
      DeckManager.addDeck(deckName: 'deck$i');
    }

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

    cloud.pushToCloud();

    CollectionReference deckList = fireStore.collection('deckList');
    deckList.get().then((element) {
      expect(element.docs.length, 10);
      int count = 0;
      for (var deck in element.docs) {
        expect(deck.get('deckId'), count);
        expect(deck.get('deckName'), 'deck$count');
        count++;
      }
    });

    CollectionReference cardList = deckList.doc('deck0').collection('cardList');
    cardList.get().then((element) {
      expect(element.docs.length, 2);
      int count = 0;
      for (var card in element.docs) {
        expect(card.get('cardId'), count);
        expect(card.get('learnCounter'), 0);
        expect(card.get('frontSide')['text'], 'this is card $count front side');
        expect(card.get('backSide')['text'], 'this is card $count back side');
        count++;
      }
    });
  });

  test('Pulling function should work correctly', () async {
    expect(DeckManager.deckList.length, 10);
    for (int i = 9; i >= 0; --i) {
      DeckManager.removeDeck(i);
    }
    expect(DeckManager.deckList.length, 0);

    cloud.pullFromCloud();

    await Future.delayed(const Duration(seconds: 3));

    expect(DeckManager.deckList.length, 10);

    for (int i = 0; i < DeckManager.deckList.length; ++i) {
      expect(DeckManager.deckList[i].deckName, 'deck$i');
    }

    expect(DeckManager.deckList[0].cardList.length, 2);

    expect(DeckManager.deckList[0].cardList[0].learnCounter, 0);
    expect(DeckManager.deckList[0].cardList[1].learnCounter, 0);

    expect(DeckManager.deckList[0].cardList[0].frontSide?.text,
        'this is card 0 front side');
    expect(DeckManager.deckList[0].cardList[1].frontSide?.text,
        'this is card 1 front side');

    expect(DeckManager.deckList[0].cardList[0].backSide?.text,
        'this is card 0 back side');
    expect(DeckManager.deckList[0].cardList[1].backSide?.text,
        'this is card 1 back side');
  });
}