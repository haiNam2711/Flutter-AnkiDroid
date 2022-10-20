import 'package:five_control_widget/algorithm_sm2/card.dart';
import 'package:five_control_widget/algorithm_sm2/card_information.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:five_control_widget/algorithm_sm2/constant.dart';

void main() {
  test('Again Press on new card or learn card', () {
    CardInformation frontSide = CardInformation(text: 'front');
    CardInformation backSide = CardInformation(text: 'back');
    FlashCard flashCard = FlashCard(frontSide, backSide, DateTime.now());

    flashCard.againPress();

    expect([
      flashCard.learnCounter,
      flashCard.timeNotification,
      flashCard.stateOfCard,
    ], [
      1,
      LearningStep.againStep,
      CardState.learningState,
    ]);
  });

  test('Again Press on graduated card', () {
    CardInformation frontSide = CardInformation(text: 'front');
    CardInformation backSide = CardInformation(text: 'back');
    FlashCard flashCard = FlashCard(frontSide, backSide, DateTime.now());

    flashCard.easyPress();
    flashCard.againPress();
    expect([
      flashCard.learnCounter,
      flashCard.timeNotification,
      flashCard.stateOfCard,
    ], [
      2,
      RelearningStep.againRelearningStep,
      CardState.relearningState,
    ]);
  });

  test('Again Press on relearning card', () {
    CardInformation frontSide = CardInformation(text: 'front');
    CardInformation backSide = CardInformation(text: 'back');
    FlashCard flashCard = FlashCard(frontSide, backSide, DateTime.now());

    flashCard.easyPress();
    flashCard.againPress();
    flashCard.againPress();

    expect([
      flashCard.learnCounter,
      flashCard.timeNotification,
      flashCard.stateOfCard,
    ], [
      3,
      RelearningStep.againRelearningStep,
      CardState.relearningState,
    ]);
  });

  test('Hard Press on new card or learn card', () {
    CardInformation frontSide = CardInformation(text: 'front');
    CardInformation backSide = CardInformation(text: 'back');
    FlashCard flashCard = FlashCard(frontSide, backSide, DateTime.now());

    flashCard.hardPress();

    expect([
      flashCard.learnCounter,
      flashCard.timeNotification,
      flashCard.stateOfCard,
    ], [
      1,
      LearningStep.hardStep,
      CardState.learningState,
    ]);
  });

  test('Hard Press on graduated card', () {
    CardInformation frontSide = CardInformation(text: 'front');
    CardInformation backSide = CardInformation(text: 'back');
    FlashCard flashCard = FlashCard(frontSide, backSide, DateTime.now());

    flashCard.easyPress();
    flashCard.againPress();

    expect([
      flashCard.learnCounter,
      flashCard.timeNotification,
      flashCard.stateOfCard,
    ], [
      2,
      RelearningStep.againRelearningStep,
      CardState.relearningState,
    ]);
  });

  test('Hard Press on relearning card', () {
    CardInformation frontSide = CardInformation(text: 'front');
    CardInformation backSide = CardInformation(text: 'back');
    FlashCard flashCard = FlashCard(frontSide, backSide, DateTime.now());

    flashCard.easyPress();
    flashCard.againPress();
    flashCard.againPress();

    expect([
      flashCard.learnCounter,
      flashCard.timeNotification,
      flashCard.stateOfCard,
    ], [
      3,
      RelearningStep.againRelearningStep,
      CardState.relearningState,
    ]);
  });
}
