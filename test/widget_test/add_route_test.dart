import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:five_control_widget/firebase/cloud.dart';
import 'package:five_control_widget/routes/add_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> testChangeState() async {

}

void main() {
  testWidgets('Testing add note widget', (WidgetTester tester) async {
    for (int i = 0; i < 50; ++i) {
      DeckManager.addDeck(deckName: 'deck$i');
    }
    final fireStore = FakeFirebaseFirestore();
    final cloud = Cloud(
      fireStore,
      'Test',
          () => {},
    );

    Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(home: AddScene(
            changeState: testChangeState,
            cloud: cloud,
        ))
    );

    // pump widget
    await tester.pumpWidget(testWidget);

    // TEST BY FINDING

    // Find Widget with text
    expect(find.text('Add note'), findsOneWidget);
    expect(find.text('Type:'), findsOneWidget);
    expect(find.text('Deck:'), findsOneWidget);
    expect(find.text('Front'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);

    // Find Widget with key
    final typeDropDownButton = find.byKey(const ValueKey('TypeDropDownButton'));
    expect(typeDropDownButton, findsOneWidget);
    final deckDropDownButton = find.byKey(const ValueKey('DeckDropDownButton'));
    expect(deckDropDownButton, findsOneWidget);
    final arrowBackIconButton = find.byKey(const ValueKey('ArrowBackIconButton'));
    expect(arrowBackIconButton, findsOneWidget);
    final checkIconButton = find.byKey(const ValueKey('CheckIconButton'));
    expect(checkIconButton, findsOneWidget);
    final frontTextFromField = find.byKey(const ValueKey('FrontTextFromField'));
    expect(frontTextFromField, findsOneWidget);
    final backTextFromField = find.byKey(const ValueKey('BackTextFromField'));
    expect(backTextFromField, findsOneWidget);

    // TEST BY SCROLLING

    // TEST BY TAPING

    await tester.tap(find.byKey(const ValueKey('FrontTextFromField')).hitTestable());
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('BackTextFromField')).hitTestable());
    await tester.pump();

    await tester.tap(typeDropDownButton);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Basic').hitTestable());
    await tester.pump();

    await tester.tap(deckDropDownButton);
    await tester.pumpAndSettle();
    await tester.tap(find.text('deck5').hitTestable());
    await tester.pump();

    // Ask Flutter to rebuild the widget
    await tester.pump();
  });
}