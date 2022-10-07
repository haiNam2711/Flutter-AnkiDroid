import 'package:flutter/material.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';

class SecondRoute extends StatefulWidget {
  final int deckIndex;
  const SecondRoute({Key? key, required this.deckIndex}) : super(key: key);

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  final myFrontController = TextEditingController(); // control text of front text field
  final myBackController = TextEditingController();
  bool showAnswer = false;
  int cardIndex = 0;

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
                style: TextStyle(
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
            Center(
              child: Text(
                DeckManager.deckList[widget.deckIndex]
                    .getCardFromId(cardIndex).frontSide?.text??'Text not found',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(
                color: Colors.black
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: showAnswer,
              child: Center(
                child: Text(
                  DeckManager.deckList[widget.deckIndex]
                      .getCardFromId(cardIndex).backSide?.text??'Text not found',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Spacer(),
            Visibility(
              visible: showAnswer,
              child: Container(
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
                          primary: Colors.red,
                        ),
                        onPressed: () {
                          cardIndex = DeckManager.deckList[widget.deckIndex].getNextWhenAgain(cardIndex);
                          showAnswer = !showAnswer;
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
                          primary: Colors.blueGrey,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          DeckManager.deckList[widget.deckIndex].cardList[cardIndex].hardPress();
                          cardIndex++;
                          showAnswer = !showAnswer;
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
                          primary: Colors.green,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          DeckManager.deckList[widget.deckIndex].cardList[cardIndex].goodPress();
                          cardIndex++;
                          showAnswer = !showAnswer;
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
                          primary: Colors.blue,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          DeckManager.deckList[widget.deckIndex].cardList[cardIndex].easyPress();
                          cardIndex++;
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
              visible: !showAnswer,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                  ),
                  primary: Colors.blueGrey,
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
