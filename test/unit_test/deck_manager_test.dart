import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Deck Manager', () {
    test('deck manager should add a new deck successfully', () {
      DeckManager.addDeck(deckName: 'newDeck');
      expect(DeckManager.deckList.length, 1);
    });
  });
}