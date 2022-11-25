import 'package:five_control_widget/algorithm_sm2/card.dart';
import 'package:five_control_widget/algorithm_sm2/card_information.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    test('deck manager should add a new deck successfully', () {
      DeckManager.addDeck(deckName: 'newDeck');
      expect(DeckManager.deckList.length, 1);
    });

    test('deck manager should remove deck successfully', ()  {
      DeckManager.removeDeck(0);
      expect(DeckManager.deckList.length, 0);
    });

    test('deck manager should add card successfully', () {
      DeckManager.addDeck(deckName: 'newDeck');
      CardInformation frontSide = CardInformation(text: 'front');
      CardInformation backSide = CardInformation(text: 'back');
      FlashCard flashCard = FlashCard(
        frontSide,
        backSide,
        DateTime.now(),
            () => {},
      );
      DeckManager.addCard(deckName: 'newDeck', flashCard: flashCard);
      expect(DeckManager.deckList[0].getCardAmount(), 1);
    });

    test('deck manager should remove card successfully', () {
      DeckManager.removeCard('newDeck', 0);
      expect(DeckManager.deckList[0].getCardAmount(), 0);
    });

    test('deck manager should return a list of deck name', () {
      DeckManager.addDeck(deckName: 'newDeck1');
      DeckManager.addDeck(deckName: 'newDeck2');
      expect(DeckManager.getDecksName(), ['newDeck', 'newDeck1', 'newDeck2']);
    });
}