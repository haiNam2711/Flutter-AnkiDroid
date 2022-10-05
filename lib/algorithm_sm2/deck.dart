import 'package:five_control_widget/algorithm_sm2/card.dart';

import 'constant.dart';

class Deck {
  String deckName = 'Default';
  List<FlashCard> cardList = [];

  Deck(String deckName) {
    this.deckName = deckName;
  }

  void addCard({required FlashCard flashCard}) {
    cardList.add(flashCard);
  }

  void removeCard(int index) {
    cardList.removeAt(index);
  }

  int getNewCard() {
    int res = 0;
    for (int i=0; i<cardList.length; i++) {
      if (cardList[i].learnCounter == 0) {
        res++;
      }
    }
    return res;
  }

  int getLearningCard() {
    int res = 0;
    for (int i=0; i<cardList.length; i++) {
      if (res!=0 && (cardList[i].stateOfCard == CardState.learningState || cardList[i].stateOfCard == CardState.relearningState)) {
        res++;
      }
    }
    return res;
  }

  int getGraduatedCard() {
    int res = 0;
    for (int i=0; i<cardList.length; i++) {
      if (cardList[i].stateOfCard == CardState.graduatedState) {
        res++;
      }
    }
    return res;
  }
}