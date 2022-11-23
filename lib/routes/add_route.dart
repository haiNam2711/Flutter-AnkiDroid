import 'package:five_control_widget/algorithm_sm2/card_information.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:flutter/material.dart';
import 'package:five_control_widget/algorithm_sm2/card.dart';

import '../dark_mode/theme.dart';
import '../firebase/cloud.dart';

// ignore: must_be_immutable
class AddScene extends StatefulWidget {
  Function() changeState;
  Cloud cloud;

  AddScene({Key? key, required this.changeState, required this.cloud})
      : super(key: key);

  @override
  State<AddScene> createState() => _AddSceneState();
}

class _AddSceneState extends State<AddScene> {
  String typeValue = 'Basic';
  String deckValue = DeckManager.deckList[0].deckName;
  double fontSize20 = 20.0;
  double fontSize15 = 15.0;
  final myFrontController =
      TextEditingController(); // control text of front text field
  final myBackController =
      TextEditingController(); // control text of back text field
  String deckName = DeckManager.deckList[0].deckName;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myFrontController.dispose();
    myBackController.dispose();
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
            key: const Key('ArrowBackIconButton'),
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
            child: const Text(
              'Add note',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          actions: [
            IconButton(
              key: const Key('CheckIconButton'),
              onPressed: () {
                CardInformation frontSide =
                    CardInformation(text: myFrontController.text);
                CardInformation backSide =
                    CardInformation(text: myBackController.text);
                FlashCard flashCard = FlashCard(
                  frontSide,
                  backSide,
                  DateTime.now(),
                  widget.changeState,
                );
                //print(deckName);
                DeckManager.addCard(deckName: deckName, flashCard: flashCard);
                DeckManager.addCardToCloud(
                    deckName: deckName, cloud: widget.cloud);

                myFrontController.text = '';
                myBackController.text = '';
                showFailDia('Success', 'Your card is created successfully!');
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
                          key: const Key('TypeDropDownButton'),
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
                          key: const Key('DeckDropDownButton'),
                          value: deckValue,
                          isDense: true,
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              deckValue = newValue!;
                              deckName = deckValue;
                            });
                          },
                          items: DeckManager.getDecksName()
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              key: Key(value),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Front',
                        style: TextStyle(
                          fontSize: fontSize15,
                        ),
                      ),
                      // const SizedBox(
                      //   width: 260,
                      // ),
                      IconButton(
                        icon: const Icon(
                          Icons.attachment,
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
                    key: const Key('FrontTextFromField'),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Back',
                        style: TextStyle(
                          fontSize: fontSize15,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.attachment,
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
                    key: const Key('BackTextFromField'),
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

  void showFailDia(String title, String content) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              setState(() {});
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: AppTheme().currentTheme() == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
