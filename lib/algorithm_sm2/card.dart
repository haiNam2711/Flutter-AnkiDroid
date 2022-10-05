import 'package:five_control_widget/algorithm_sm2/constant.dart';
import 'package:five_control_widget/algorithm_sm2/card_information.dart';

class FlashCard {
  double easeFactor = GraduatingStep.defaultEaseFactor;
  int learnCounter = 0;
  int stateOfCard = 0; // learn = 0, graduated = 1, relearn = 2;
  double currentInterval = 0;
  double timeNotification = 0;
  CardInformation? frontSide;
  CardInformation? backSide;

  FlashCard(this.frontSide, this.backSide);


  void againPress() {
    learnCounter += 1;
    switch (stateOfCard) {
      case CardState.learningState: {
        timeNotification = LearningStep.againStep;
        break;
      }
      case CardState.graduatedState: {
        easeFactor -= RelearningStep.minusAgainEase;
        timeNotification = RelearningStep.againRelearningStep;
        stateOfCard = CardState.relearningState;
        break;
      }
      case CardState.relearningState: {
        timeNotification = RelearningStep.againRelearningStep;
        break;
      }
    }
  }

  void hardPress() {
    learnCounter += 1;
    switch (stateOfCard) {
      case CardState.learningState: {
        timeNotification = LearningStep.hardStep;
        break;
      }
      case CardState.graduatedState: {
        easeFactor = easeFactor - RelearningStep.minusHardEase;
        currentInterval = currentInterval * GraduatingStep.defaultHardInterval;
        timeNotification = currentInterval;
        break;
      }
      case CardState.relearningState: {
        timeNotification = RelearningStep.hardRelearningStep;
        break;
      }
    }
  }

  void goodPress() {
    learnCounter += 1;
    switch (stateOfCard) {
      case CardState.learningState: {
        if (timeNotification == LearningStep.goodStep) {
          stateOfCard = CardState.graduatedState;
          currentInterval = LearningStep.graduatingIvl;
          timeNotification = currentInterval;
        } else {
          timeNotification = LearningStep.goodStep;
        }
        break;
      }
      case CardState.graduatedState: {
        currentInterval = currentInterval * easeFactor;
        timeNotification = currentInterval;
        break;
      }
      case CardState.relearningState: {
        currentInterval = currentInterval * RelearningStep.newGoodInterval;
        timeNotification = currentInterval;
        break;
      }
    }
  }

  void easyPress() {
    learnCounter += 1;
    switch (stateOfCard) {
      case CardState.learningState: {
        currentInterval = LearningStep.easyIvl;
        timeNotification = currentInterval;
        stateOfCard = CardState.graduatedState;
        break;
      }
      case CardState.graduatedState: {
        easeFactor += RelearningStep.addEasyEase;
        currentInterval = currentInterval * easeFactor * GraduatingStep.defaultEaseBonus;
        timeNotification = currentInterval;
        break;
      }
      case CardState.relearningState: {
        currentInterval = currentInterval * RelearningStep.newEasyInterval;
        timeNotification = currentInterval;
        break;
      }
    }
  }

}