import 'dart:async';

import 'package:five_control_widget/algorithm_sm2/card.dart';
import 'package:five_control_widget/algorithm_sm2/card_information.dart';
import 'package:five_control_widget/algorithm_sm2/constant.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    test('deck should add a new card successfully', () {
      DeckManager.addDeck(deckName: 'newDeck');
      CardInformation frontSide = CardInformation(text: 'front');
      CardInformation backSide = CardInformation(text: 'back');
      FlashCard flashCard = FlashCard(
        frontSide,
        backSide,
        DateTime.now(),
            () => {},
      );
      DeckManager.deckList[0].addCard(flashCard: flashCard);

      CardInformation frontSide1 = CardInformation(text: 'front1');
      CardInformation backSide1 = CardInformation(text: 'back1');
      FlashCard flashCard1 = FlashCard(
        frontSide1,
        backSide1,
        DateTime.now(),
            () => {},
      );
      DeckManager.deckList[0].addCard(flashCard: flashCard1);

      CardInformation frontSide2 = CardInformation(text: 'front2');
      CardInformation backSide2 = CardInformation(text: 'back2');
      FlashCard flashCard2 = FlashCard(
        frontSide2,
        backSide2,
        DateTime.now(),
            () => {},
      );
      DeckManager.deckList[0].addCard(flashCard: flashCard2);
      expect(DeckManager.deckList[0].getCardAmount(), 3);
    });

    test('deck  should remove a card successfully', () {
      DeckManager.deckList[0].removeCard(0);
      expect(DeckManager.deckList[0].cardList.length, 2);
    });

    test('deck should get true amount of NEW card', () {
      expect(DeckManager.deckList[0].getNewCard(), 2);
    });

    test('deck should get true amount of LEARNING card', () async {
      DeckManager.deckList[0].cardList[0].againPress();
      DeckManager.deckList[0].cardList[1].againPress();

      int seconds = (LearningStep.againStep + 2).toInt();
      await Future.delayed(Duration(seconds: seconds), (){});

      expect(DeckManager.deckList[0].getLearningCard(), 2);
    });

    test('deck should get true amount of GRADUATED card', () async {
      CardInformation frontSide = CardInformation(text: 'front');
      CardInformation backSide = CardInformation(text: 'back');
      FlashCard flashCard = FlashCard(
        frontSide,
        backSide,
        DateTime.now(),
            () => {},
      );
      DeckManager.deckList[0].addCard(flashCard: flashCard);

      DeckManager.deckList[0].cardList[2].easyPress();

      int seconds = (LearningStep.easyIvl + 2).toInt();
      await Future.delayed(Duration(seconds: seconds), (){});

      expect(DeckManager.deckList[0].getGraduatedCard(), 1);
    }, timeout: Timeout(Duration(minutes: 1)));

    test('deck should return the right card', () {
      expect(DeckManager.deckList[0].getCardFromId(1), DeckManager.deckList[0].cardList[1]);
    });

    test('deck should return the right index', () {
      expect(DeckManager.deckList[0].getNextIndex(0), 1);
    });
}