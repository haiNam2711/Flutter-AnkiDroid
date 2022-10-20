import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:five_control_widget/routes/add_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> testChangeState() async {

}

void main() {
  testWidgets('Testing add note widget', (WidgetTester tester) async {
    DeckManager.addDeck(deckName: 'newDeck');
    Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(home: AddScene(changeState: testChangeState))
    );

    await tester.pumpWidget(testWidget);

    final typeDropDownButton = find.byKey(const ValueKey('typeDropDownButton'));

    await tester.tap(typeDropDownButton);
    await tester.pump();
  });
}