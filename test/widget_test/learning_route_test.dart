import 'package:five_control_widget/algorithm_sm2/card.dart';
import 'package:five_control_widget/algorithm_sm2/card_information.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:five_control_widget/routes/learning_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(

      home: child,
    );
  }



  group('Counter', () {
    testWidgets('Testing showing a empty deck', (tester) async {
      DeckManager.addDeck(deckName: 'test_deck1');

      await tester.pumpWidget(createWidgetForTesting(child: LearningRoute(deckIndex: 0, changeState: (){})));
      await tester.pumpAndSettle();

      final titleFinder = find.text('0 cards due.');
      expect(titleFinder, findsOneWidget);

      final congratulationFinder = find.text('Congratulations!');
      expect(congratulationFinder, findsOneWidget);
    });

    testWidgets('Testing showing a card', (tester) async {
      DeckManager.addDeck(deckName: 'test_deck1');
      CardInformation frontSide = CardInformation(text: 'front 1');
      CardInformation backSide = CardInformation(text: 'back 1');
      FlashCard flashCard = FlashCard(frontSide, backSide, DateTime.now());
      DeckManager.addCard(deckName: 'test_deck1', flashCard: flashCard);

      frontSide = CardInformation(text: 'front 2');
      backSide = CardInformation(text: 'back 2');
      flashCard = FlashCard(frontSide, backSide, DateTime.now());
      DeckManager.addCard(deckName: 'test_deck1', flashCard: flashCard);

      frontSide = CardInformation(text: 'front 3');
      backSide = CardInformation(text: 'back 3');
      flashCard = FlashCard(frontSide, backSide, DateTime.now());
      DeckManager.addCard(deckName: 'test_deck1', flashCard: flashCard);

      frontSide = CardInformation(text: 'front 4');
      backSide = CardInformation(text: 'back 4');
      flashCard = FlashCard(frontSide, backSide, DateTime.now());
      DeckManager.addCard(deckName: 'test_deck1', flashCard: flashCard);

      await tester.pumpWidget(createWidgetForTesting(child: LearningRoute(deckIndex: 0, changeState: (){})));
      await tester.pumpAndSettle();

      final titleFinder = find.text('test_deck1');
      expect(titleFinder, findsOneWidget);

      await tester.tap(find.byIcon(Icons.undo));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.bookmark_add));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      final showAnswerFind1 = find.byType(ElevatedButton);
      expect(showAnswerFind1, findsOneWidget);
      await tester.tap(showAnswerFind1);
      await tester.pumpAndSettle();

      final showFourButtons = find.byType(ElevatedButton);
      expect(showFourButtons, findsNWidgets(4));


    });


    testWidgets('Testing back button', (tester) async {
      DeckManager.addDeck(deckName: 'test_deck1');
      LearningRoute secondRoute = LearningRoute(deckIndex: 0, changeState: (){});

      await tester.pumpWidget(createWidgetForTesting(child: secondRoute));
      await tester.pumpAndSettle();


      // Tap the back button.
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      //final secondRouteFind = find.;
      expect(find.byWidget(secondRoute), findsNothing);
    });
  });
}
