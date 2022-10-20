import 'dart:async';

import 'package:five_control_widget/algorithm_sm2/constant.dart';
import 'package:five_control_widget/algorithm_sm2/card_information.dart';

class FlashCard {
  double easeFactor = GraduatingStep.defaultEaseFactor;
  int learnCounter = 0;
  int stateOfCard = 0; // learn = 0, graduated = 1, relearn = 2;
  double currentInterval = 0;
  double timeNotification = 0;
  DateTime startTime;
  CardInformation? frontSide;
  CardInformation? backSide;

  FlashCard(this.frontSide, this.backSide, this.startTime);

  void setTimer() {
    startTime = DateTime.now();
    Timer(
      Duration(seconds: timeNotification.toInt()),
          () {
        timeNotification = 0;
      },
    );
  }

  void againPress() {
    learnCounter += 1;
    switch (stateOfCard) {
      case CardState.learningState: {
        timeNotification = LearningStep.againStep;
        setTimer();
        break;
      }
      case CardState.graduatedState: {
        easeFactor -= RelearningStep.minusAgainEase;
        timeNotification = RelearningStep.againRelearningStep;
        stateOfCard = CardState.relearningState;
        setTimer();
        break;
      }
      case CardState.relearningState: {
        timeNotification = RelearningStep.againRelearningStep;
        setTimer();
        break;
      }
    }
  }

  void hardPress() {
    learnCounter += 1;
    switch (stateOfCard) {
      case CardState.learningState: {
        timeNotification = LearningStep.hardStep;
        setTimer();
        break;
      }
      case CardState.graduatedState: {
        easeFactor = easeFactor - RelearningStep.minusHardEase;
        currentInterval = currentInterval * GraduatingStep.defaultHardInterval;
        timeNotification = currentInterval;
        setTimer();
        break;
      }
      case CardState.relearningState: {
        timeNotification = RelearningStep.hardRelearningStep;
        setTimer();
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
        setTimer();
        break;
      }
      case CardState.graduatedState: {
        currentInterval = currentInterval * easeFactor;
        timeNotification = currentInterval;
        setTimer();
        break;
      }
      case CardState.relearningState: {
        currentInterval = currentInterval * RelearningStep.newGoodInterval;
        timeNotification = currentInterval;
        setTimer();
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
        setTimer();
        break;
      }
      case CardState.graduatedState: {
        easeFactor += RelearningStep.addEasyEase;
        currentInterval = currentInterval * easeFactor * GraduatingStep.defaultEaseBonus;
        timeNotification = currentInterval;
        setTimer();
        break;
      }
      case CardState.relearningState: {
        currentInterval = currentInterval * RelearningStep.newEasyInterval;
        timeNotification = currentInterval;
        setTimer();
        break;
      }
    }
  }

}