import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:five_control_widget/darkmode/theme.dart';
import 'package:five_control_widget/routes/home_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('Testing add note widget', (WidgetTester tester) async {
    DeckManager.addDeck(deckName: 'newDeck');

    Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: FirstRoute())
    );

    await tester.pumpWidget(testWidget);

    // final typeDropDownButton = find.byKey(const ValueKey('typeDropDownButton'));
    //
    // await tester.tap(typeDropDownButton);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(NightModeSwitch));
    await tester.pumpAndSettle();
    expect(AppTheme().currentTheme(),ThemeMode.dark);
  });
}