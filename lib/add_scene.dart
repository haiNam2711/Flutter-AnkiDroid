import 'package:five_control_widget/algorithm_sm2/card_information.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:flutter/material.dart';
import 'package:five_control_widget/algorithm_sm2/card.dart';

class AddScene extends StatefulWidget {
  const AddScene({Key? key}) : super(key: key);

  @override
  State<AddScene> createState() => _AddSceneState();
}

class _AddSceneState extends State<AddScene> {
  String typeValue = 'Basic';
  String deckValue = DeckManager.deckList[0].deckName;
  double fontSize20 = 20.0;
  double fontSize15 = 15.0;
  final myFrontController = TextEditingController(); // control text of front text field
  final myBackController = TextEditingController(); // control text of back text field
  String deckName = DeckManager.deckList[0].deckName;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myFrontController .dispose();
    myBackController .dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
            child: const Text(
              'Add note',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                CardInformation frontSide = CardInformation(myFrontController.text);
                CardInformation backSide = CardInformation(myBackController.text);
                FlashCard flashCard = FlashCard(frontSide,backSide);
                //print(deckName);
                DeckManager.addCard(deckName: deckName, flashCard: flashCard);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.check,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.remove_red_eye,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Type
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Row(
                    children: [
                      Text(
                        'Type:',
                        style: TextStyle(
                          fontSize: fontSize15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          value: typeValue,
                          isDense: true,
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              typeValue = newValue!;
                            });
                          },
                          items: <String>[
                            'Basic',
                            'Basic (and reversed card)',
                            'Basic (optional reversed card)',
                            'Basic Japanese',
                            'Cloze',
                            'compsci_graphs',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                // Deck
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Row(
                    children: [
                      Text(
                        'Deck:',
                        style: TextStyle(
                          fontSize: fontSize15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          value: deckValue,
                          isDense: true,
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              deckValue = newValue!;
                              deckName = deckValue;
                            });
                          },
                          items: DeckManager.getDecksName().map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                // Front
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        'Front',
                        style: TextStyle(
                          fontSize: fontSize15,
                        ),
                      ),
                      const SizedBox(
                        width: 260,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.attachment,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_up,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                // Text field
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                  child: TextFormField(
                    controller: myFrontController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: fontSize15,
                    ),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                // Back
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        'Back',
                        style: TextStyle(
                          fontSize: fontSize15,
                        ),
                      ),
                      const SizedBox(
                        width: 260,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.attachment,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_up,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                // Text field
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 30, 20),
                  child: TextFormField(
                    controller: myBackController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: fontSize15,
                    ),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                // Tags
                Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    color: Colors.black54,
                    child: ListTile(
                      title: Text(
                        'Tags:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize15,
                        ),
                      ),
                    )),
                // Cards
                Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    color: Colors.black54,
                    child: ListTile(
                      title: Text(
                        'Card: Card1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize15,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


