import 'package:five_control_widget/algorithm_sm2/card.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class Deck {
  String deckName = 'Default';
  List<FlashCard> cardList = [];

  Deck(String deckName) {
    this.deckName = deckName;
  }

  void addCard({required FlashCard flashCard}) {
    cardList.add(flashCard);
    print(cardList.length);
  }

  void removeCard(int index) {
    cardList.removeAt(index);
  }

  int getNewCard() {
    int res = 0;
    for (int i = 0; i < cardList.length; i++) {
      if (cardList[i].learnCounter == 0) {
        res++;
      }
    }
    return res;
  }

  int getLearningCard() {
    int res = 0;
    for (int i = 0; i < cardList.length; i++) {
      if (cardList[i].timeNotification == 0 &&
          cardList[i].learnCounter != 0 &&
          (cardList[i].stateOfCard == CardState.learningState ||
              cardList[i].stateOfCard == CardState.relearningState)) {
        res++;
      }
    }
    return res;
  }

  int getGraduatedCard() {
    int res = 0;
    for (int i = 0; i < cardList.length; i++) {
      if (cardList[i].timeNotification == 0 &&
          cardList[i].stateOfCard == CardState.graduatedState) {
        res++;
      }
    }
    return res;
  }

  FlashCard getCardFromId(int cardIndex) {
    return cardList[cardIndex];
  }

  int getCardAmout() {
    return getGraduatedCard() + getLearningCard() + getNewCard();
  }

  int getNextWhenAgain(int cardIndex) {
    cardList[cardIndex].againPress();
    bool isFinded = false;
    int nextCardIndex = cardIndex;
    for (int i = cardIndex + 1; i < cardList.length; ++i) {
      if (cardList[i].stateOfCard == CardState.learningState ||
          cardList[i].stateOfCard == CardState.relearningState) {
        nextCardIndex = i;
        isFinded = true;
        break;
      }
    }

    if (!isFinded) {
      for (int i = 0; i <= cardIndex; ++i) {
        if (cardList[i].stateOfCard == CardState.learningState ||
            cardList[i].stateOfCard == CardState.relearningState) {
          nextCardIndex = i;
          break;
        }
      }
    }
    if (cardList[nextCardIndex].stateOfCard == CardState.graduatedState) {
      return -1;
    }
    return nextCardIndex;
  }
}
