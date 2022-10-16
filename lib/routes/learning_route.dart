// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';

import '../darkmode/theme.dart';

class SecondRoute extends StatefulWidget {
  final int deckIndex;
  int cardIndex = 0;
  bool haveCard = true;
  final Function() changeState;

  SecondRoute({Key? key, required this.deckIndex, required this.changeState}) : super(key: key) {
    cardIndex = DeckManager.deckList[deckIndex].getNextIndex(cardIndex);
    if (cardIndex == -1) {
      haveCard = false;
    }
  }

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  final myFrontController = TextEditingController(); // control text of front text field
  final myBackController = TextEditingController();
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            widget.changeState();
            Navigator.pop(context);
          },
        ),
        title: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              Text(
                DeckManager.deckList[widget.deckIndex].deckName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${DeckManager.deckList[widget.deckIndex].getCardAmout()} cards due.',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.undo,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark_add,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              color: Colors.blue.shade100,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${DeckManager.deckList[widget.deckIndex].getNewCard()} ',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${DeckManager.deckList[widget.deckIndex].getLearningCard()} ',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${DeckManager.deckList[widget.deckIndex].getGraduatedCard()}',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: !widget.haveCard,
              child: Center(
                child: Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 30,
                    color: AppTheme().currentTheme() == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              visible: !widget.haveCard,
              child: Center(
                child: Text(
                  'You have finished this deck for now.',
                  style: TextStyle(
                    fontSize: 30,
                    color: AppTheme().currentTheme() == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              visible: widget.haveCard,
              child: Center(
                child: Text(
                  widget.haveCard?
                  DeckManager.deckList[widget.deckIndex]
                      .getCardFromId(widget.cardIndex).frontSide?.text??'Text not found':
                  'Not have card',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppTheme().currentTheme() == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              visible: showAnswer && widget.haveCard,
              child: const Divider(
                  color: Colors.black
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: showAnswer && widget.haveCard,
              child: Center(
                child: Text(
                  widget.haveCard?
                  DeckManager.deckList[widget.deckIndex]
                      .getCardFromId(widget.cardIndex).backSide?.text??'Text not found':
                  'Not have card',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppTheme().currentTheme() == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            Visibility(
              visible: showAnswer && widget.haveCard,
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          DeckManager.deckList[widget.deckIndex].cardList[widget.cardIndex].againPress();
                          widget.cardIndex = DeckManager.deckList[widget.deckIndex].getNextIndex(widget.cardIndex);
                          showAnswer = !showAnswer;
                          if (widget.cardIndex == -1) {
                            widget.haveCard = false;
                          }
                          setState(() {

                          });
                        },
                        child: const Text('AGAIN'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          backgroundColor: Colors.blueGrey,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          DeckManager.deckList[widget.deckIndex].cardList[widget.cardIndex].hardPress();
                          widget.cardIndex = DeckManager.deckList[widget.deckIndex].getNextIndex(widget.cardIndex);
                          showAnswer = !showAnswer;
                          if (widget.cardIndex == -1) {
                            widget.haveCard = false;
                          }
                          setState(() {

                          });
                        },
                        child: const Text('HARD'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          backgroundColor: Colors.green,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          DeckManager.deckList[widget.deckIndex].cardList[widget.cardIndex].goodPress();
                          widget.cardIndex = DeckManager.deckList[widget.deckIndex].getNextIndex(widget.cardIndex);
                          showAnswer = !showAnswer;
                          if (widget.cardIndex == -1) {
                            widget.haveCard = false;
                          }
                          setState(() {

                          });
                        },
                        child: const Text('GOOD'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          DeckManager.deckList[widget.deckIndex].cardList[widget.cardIndex].easyPress();
                          widget.cardIndex = DeckManager.deckList[widget.deckIndex].getNextIndex(widget.cardIndex);
                          if (widget.cardIndex == -1) {
                            widget.haveCard = false;
                          }
                          showAnswer = !showAnswer;
                          setState(() {

                          });
                        },
                        child: const Text('EASY'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !showAnswer && widget.haveCard,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                  ),
                  backgroundColor: Colors.blueGrey,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () {
                  showAnswer = !showAnswer;
                  setState(() {

                  });
                },
                child: const Text('SHOW ANSWER'),
              ),
            ),
          ],
        )
      ),
    );
  }
}
