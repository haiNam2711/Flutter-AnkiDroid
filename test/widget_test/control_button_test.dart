import 'dart:math';

import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:five_control_widget/widget/control_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> testChangeState() async {

}

void main() {
  late AnimationController rotateController;
  late Animation<double> rotateAnimation;

  late AnimationController moveController;
  late Animation<double> moveAnimation;

  ValueNotifier<bool> openedButton = ValueNotifier<bool>(false);

  TestVSync testVSync = const TestVSync();

  setUpAll(() => {
    rotateController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: testVSync,
    ),

    rotateAnimation = Tween<double>(
      begin: 0.0,
      end: pi / 4 * 3,
    ).animate(rotateController),

    moveController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: testVSync,
    ),

    moveAnimation = Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(moveController),

    openedButton.value = false,
  });

  testWidgets('Testing control button widget', (WidgetTester tester) async {
    DeckManager.addDeck(deckName: 'newDeck');

    await tester.pumpWidget(
        Builder(
            builder: (BuildContext context) {
              return MediaQuery(
                  data: const MediaQueryData(),
                  child: MaterialApp(home: ControlButton(
                    context,
                    rotateController,
                    rotateAnimation,
                    moveController,
                    moveAnimation,
                    openedButton,
                    changeState: testChangeState,
                  )),
              );
            }
          )
    );

    // final typeDropDownButton = find.byKey(const ValueKey('typeDropDownButton'));
    // await tester.tap(typeDropDownButton);

    await tester.pump();
  });
}