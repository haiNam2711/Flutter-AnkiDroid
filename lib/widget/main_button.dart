import 'package:five_control_widget/routes/add_route.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
//import 'package:five_control_widget/firebase/cloud.dart';
import 'package:flutter/material.dart';

import '../dark_mode/theme.dart';

TextEditingController deckNameController = TextEditingController();

class MainButton extends StatelessWidget {
  final BuildContext context;
  final AnimationController rotateController;
  final Animation<double> rotateAnimation;
  final AnimationController moveController;
  final Animation<double> moveAnimation;
  final ValueNotifier<bool> openedButton;

  const MainButton(this.context, this.rotateController, this.rotateAnimation,
      this.moveController, this.moveAnimation, this.openedButton,
      {super.key, required this.changeState});

  final Function() changeState;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedBuilder(
                    animation: moveAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Create deck button.
                        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                          Container(
                            color: Colors.black54,
                            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: const Text(
                              key: Key('CreateDeckWord'),
                              'Create deck',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          FloatingActionButton(
                            key: const Key('CreateDeckButton'),
                            heroTag: 'create deck',
                            mini: true,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.folder,
                              color: AppTheme().currentTheme() == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            onPressed: () {
                              rotateController.reverse();
                              moveController.reverse();
                              openedButton.value = !openedButton.value;
                              showCreateDia(context);
                            },
                          ),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        // Get shared data button.
                        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                          Flexible(
                            child: Container(
                              color: Colors.black54,
                              margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: const Text(
                                key: Key('GetSharedDecksWord'),
                                'Get shared decks',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          FloatingActionButton(
                            key: const Key('GetSharedDeckButton'),
                            heroTag: 'get shared decks',
                            mini: true,
                            backgroundColor: Colors.blue,
                            child: Icon(
                                Icons.download,
                                color: AppTheme().currentTheme() == ThemeMode.dark
                                    ? Colors.black
                                    : Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          // const PushToCloud(),
                          // const PullFromCloud(),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        // Add note button.
                        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                          Container(
                            color: Colors.black54,
                            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: const Text(
                              key: Key('AddWord'),
                              'Add',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          FloatingActionButton(
                            key: const Key('AddButton'),
                            heroTag: 'add',
                            mini: true,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.add,
                              color: AppTheme().currentTheme() == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            onPressed: () {
                              rotateController.reverse();
                              moveController.reverse();
                              openedButton.value = !openedButton.value;
                              if (DeckManager.deckList.isEmpty) {
                                showAddDia(context);
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddScene(
                                          changeState: () {
                                            changeState();
                                          },
                                        )),
                              );
                            },
                          ),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    builder: (context, child) => Transform.translate(
                      offset: Offset(
                        0.0,
                        -moveAnimation.value + 400.0,
                      ),
                      child: child,
                    ),
                  ),

                  // Main control button.
                  AnimatedBuilder(
                    animation: rotateAnimation,
                    child: FloatingActionButton(
                      key: const Key('MainControlButton'),
                      heroTag: 'control',
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.add,
                        color: AppTheme().currentTheme() == ThemeMode.dark
                            ? Colors.black
                            : Colors.white,
                      ),
                      onPressed: () {
                        openedButton.value = !openedButton.value;
                        if (openedButton.value) {
                          rotateController.forward();
                        } else {
                          rotateController.reverse();
                        }
                        if (openedButton.value) {
                          moveController.forward();
                        } else {
                          moveController.reverse();
                        }
                      },
                    ),
                    builder: (context, child) => Transform.rotate(
                      angle: rotateAnimation.value,
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showCreateDia(dynamic context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Create Deck'),
        content: TextFormField(
          controller: deckNameController,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (deckNameController.text != '') {
                DeckManager.addDeck(deckName: deckNameController.text);
                changeState();
              }
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showAddDia(dynamic context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add card flase'),
        content: const Text('Your deck list is empty.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
