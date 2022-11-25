import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_control_widget/algorithm_sm2/constant.dart';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';
import 'package:five_control_widget/dark_mode/theme.dart';
import 'package:five_control_widget/firebase/cloud.dart';
import 'package:five_control_widget/routes/card_browser.dart';

import '../dark_mode/config.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'learning_route.dart';
import '../widget/main_button.dart';

class HomeRoute extends StatefulWidget {
  final FirebaseFirestore fireStore;

  final Function() logOut;
  final String userId;
  final String userEmail;

  const HomeRoute(
      {Key? key,
      required this.fireStore,
      required this.userId,
      required this.userEmail,
      required this.logOut})
      : super(key: key);

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with TickerProviderStateMixin {
  late AnimationController rotateController;
  late Animation<double> rotateAnimation;

  late AnimationController moveController;
  late Animation<double> moveAnimation;
  late Cloud cloud;

  ValueNotifier<bool> openedButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    DeckManager.removeAll();

    cloud = Cloud(
      widget.fireStore,
      widget.userId,
      () => {setState(() {})},
    );

    rotateController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    rotateAnimation = Tween<double>(
      begin: 0.0,
      end: pi / 4 * 3,
    ).animate(rotateController);

    moveController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    moveAnimation = Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(moveController);

    openedButton.value = false;
//moveController.forward();
//rotateController.forward();
  }

  @override
  void dispose() {
    rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        rotateController.reverse();
        moveController.reverse();
        openedButton.value = false;
      },
      child: Scaffold(
        drawer: SideBar(
          userEmail: widget.userEmail,
          logOut: widget.logOut,
          setState: () => setState(() {}),
          cloud: cloud,
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          // leading: IconButton(
          //   icon: const Icon(
          //     Icons.menu,
          //   ),
          //   onPressed: () {},
          // ),
          title: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AnkiDroid',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.userEmail,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                // Show loading icon when pulling from cloud.
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                            child: CircularProgressIndicator(
                          color: Colors.blue,
                        )));
                await DeckManager.removeAll();
                await cloud.pullFromCloud();
                await Future.delayed(
                    const Duration(milliseconds: Time.loadTime));
                navigatorKey.currentState!.popUntil((route) => route.isFirst);
                setState(() {});
              },
              icon: const Icon(
                Icons.download,
              ),
            ),
            // IconButton (
            //   onPressed: () async {
            //     showDialog(
            //         context: context,
            //         barrierDismissible: false,
            //         builder: (context) => const Center(child: CircularProgressIndicator(
            //           color: Colors.blue,
            //         ))
            //     );
            //     await cloud.pushToCloud();
            //     await Future.delayed(const Duration(milliseconds: 3000));
            //     navigatorKey.currentState!.popUntil((route) => route.isFirst);
            //     setState(() {
            //
            //     });
            //   },
            //   icon: const Icon(
            //     Icons.backup,
            //   ),
            // ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
        floatingActionButton: MainButton(
          context,
          rotateController,
          rotateAnimation,
          moveController,
          moveAnimation,
          openedButton,
          changeState: () {
            setState(() {});
          },
          cloud: cloud,
        ),
        body: SafeArea(
          child: ListView.builder(
            //padding: const EdgeInsets.only(bottom: 500),
            itemCount: DeckManager.deckList.length,
            itemBuilder: (context, index) {
              return Card(
                color: index % 2 == 0 ? Colors.grey : Colors.white,
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.only(top: 4.5),
                    child: Text(
                      DeckManager.deckList[index].deckName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppTheme().currentTheme() == ThemeMode.dark
                            ? Colors.black
                            : Colors.black,
                      ),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${DeckManager.deckList[index].getNewCard()} ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        '${DeckManager.deckList[index].getLearningCard()} ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.red.shade700,
                        ),
                      ),
                      Text(
                        '${DeckManager.deckList[index].getGraduatedCard()}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.green.shade900),
                      ),
                    ],
                  ),
                  onTap: () {
                    rotateController.reverse();
                    moveController.reverse();
                    openedButton.value = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LearningRoute(
                                deckIndex: index,
                                changeState: () {
                                  setState(() {});
                                },
                                cloud: cloud,
                              )),
                    );
                  },
                  onLongPress: () {
                    String deckName = DeckManager.deckList[index].deckName;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Deck: $deckName'),
                            content: setupAlertDialoadContainer(index),
                          );
                        });
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget setupAlertDialoadContainer(int inpIndex) {
    return SizedBox(
      height: 110.0,
      width: 300.0,
      child: ListView.builder(
        shrinkWrap: false,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Rename'),
              onTap: () {
                Navigator.pop(context);
                showRenameDia(inpIndex);
              },
            );
          } else {
            return ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                setState(() {
                  String deckName = DeckManager.deckList[inpIndex].deckName;
                  DeckManager.removeDeck(inpIndex);
                  DeckManager.removeDeckOnCloud(deckName, cloud);
                  Navigator.pop(context);
                });
              },
            );
          }
        },
      ),
    );
  }

  void showRenameDia(int index) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Rename'),
        content: TextFormField(
          controller: deckNameController,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              print(index);
              if (deckNameController.text != '') {
                bool flag = true;
                for (int i = 0; i < DeckManager.deckList.length; i++) {
                  if (DeckManager.deckList[i].deckName ==
                      deckNameController.text) {
                    flag = false;
                  }
                }
                if (flag == true) {
                  // DeckManager.deckList[index].deckName =
                  //     deckNameController.text;
                  DeckManager.deckList[index]
                      .renameDeckOnCloud(index, deckNameController.text, cloud);
                  deckNameController.text = '';
                } else {
                  Navigator.pop(context, 'OK');
                  deckNameController.text = '';
                  showAddDia('Your deck is already exist.',
                      'Please choose other name.');
                  return;
                }
              } else {
                Navigator.pop(context, 'OK');
                deckNameController.text = '';
                showAddDia(
                    'Your deck name is empty.', 'Please choose other name.');
                return;
              }
              setState(() {});
              Navigator.pop(context, 'OK');
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: AppTheme().currentTheme() == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showAddDia(String title, String content) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(
              'OK',
              style: TextStyle(
                color: AppTheme().currentTheme() == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  final Function() setState;
  final Cloud cloud;
  final Function() logOut;
  final String userEmail;

  const SideBar(
      {Key? key,
      required this.userEmail,
      required this.logOut,
      required this.setState,
      required this.cloud})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Image(
            image: AssetImage('images/anki.png'),
            fit: BoxFit.fill,
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Card browser'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CardBrowserRoute(
                          setHomeState: setState,
                          cloud: cloud,
                        )),
              );
            }, //TODO : implement
          ),
          const ListTile(
            leading: Icon(Icons.dynamic_form),
            title: Text('Statistics'),
          ),
          SizedBox(
            width: double.infinity,
            height: 1,
            child: Container(
              color: Colors.grey,
            ),
          ),
          const ListTile(
            leading: Icon(Icons.mode_night),
            title: Text('Night Mode'),
            trailing: NightModeSwitch(),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          const ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              logOut();
              setState();
            },
          ),
        ],
      ),
    );
  }
}

class NightModeSwitch extends StatefulWidget {
  const NightModeSwitch({Key? key}) : super(key: key);

  @override
  State<NightModeSwitch> createState() => _NightModeSwitchState();
}

class _NightModeSwitchState extends State<NightModeSwitch> {
  static bool light = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: light,
        onChanged: (bool value2) {
          light = value2;
          appTheme.switchTheme();
          setState(() {});
        });
  }
}
