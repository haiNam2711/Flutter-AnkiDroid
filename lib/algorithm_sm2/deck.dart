import 'package:five_control_widget/algorithm_sm2/card.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';

import '../firebase/cloud.dart';
import 'constant.dart';

class Deck {
  String deckName = 'Default';
  List<FlashCard> cardList = [];

  Deck(this.deckName);

  void addCard({required FlashCard flashCard}) {
    cardList.add(flashCard);
  }

  void addCardToCloud({required int deckId, required Cloud cloud}) {
    int cardId = cardList.length - 1;
    cloud.updateCardOnCloud(
      deckId,
      deckName,
      cardId,
      cardList[cardId].name,
    );
  }

  void updateCardOnCloud(
      {required int deckId, required int cardId, required Cloud cloud}) {
    cloud.updateCardOnCloud(
      deckId,
      deckName,
      cardId,
      cardList[cardId].name,
    );
  }

  void removeCard(int index) {
    cardList.removeAt(index);
  }

  void removeCardOnCloud(String deckName, String cardName, Cloud cloud) {
    cloud.removeCardOnCloud(deckName, cardName);
  }

  void renameDeckOnCloud(int deckId, String deckName, Cloud cloud) {
    cloud.updateDeckOnCloud(deckName);
    for (int i = 0; i < cardList.length; i++) {
      cloud.updateCardOnCloud(deckId, deckName, i, cardList[i].name);
    }
    cloud.removeDeckOnCloud(this.deckName);
    this.deckName = deckName;
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

  int getCardAmount() {
    return getGraduatedCard() + getLearningCard() + getNewCard();
  }

  int getNextIndex(int cardIndex) {
    if (cardList.isEmpty) {
      return -1;
    }

    for (int i = cardIndex + 1; i < cardList.length; ++i) {
      if (cardList[i].timeNotification == 0) {
        return i;
      }
    }

    for (int i = 0; i <= cardIndex; ++i) {
      if (cardList[i].timeNotification == 0) {
        return i;
      }
    }

    return -1;
  }
}
