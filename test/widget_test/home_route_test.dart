import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:five_control_widget/dark_mode/theme.dart';
import 'package:five_control_widget/firebase_options.dart';
import 'package:five_control_widget/routes/home_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testing home route widget', (WidgetTester tester) async {
    DeckManager.addDeck(deckName: 'newDeck');
    final fireStore = FakeFirebaseFirestore();

    Widget testWidget = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
            home: HomeRoute(
          fireStore: fireStore,
          userEmail: 'email',
          userId: 'id',
          logOut: () => {},
        )));

    await tester.pumpWidget(testWidget);

    // final typeDropDownButton = find.byKey(const ValueKey('typeDropDownButton'));
    //
    // await tester.tap(typeDropDownButton);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(NightModeSwitch));
    await tester.pumpAndSettle();
    expect(AppTheme().currentTheme(), ThemeMode.dark);
  });
}
