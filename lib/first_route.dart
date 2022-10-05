import 'dart:math';
import 'package:five_control_widget/algorithm_sm2/deck_manager.dart';

import 'darkmode/config.dart';
import 'package:flutter/material.dart';
import 'second_route.dart';
import 'control_button.dart';

class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> with TickerProviderStateMixin {
  late AnimationController rotateController;
  late Animation<double> rotateAnimation;

  late AnimationController moveController;
  late Animation<double> moveAnimation;

  ValueNotifier<bool> openedButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

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
        drawer: const SideBar(),
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
              children: const [
                Text(
                  'AnkiDroid',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '10 cards due.',
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
              onPressed: () {
                print(DeckManager.deckList[0].cardList.length);
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {

                });
              },
              icon: const Icon(
                Icons.refresh,
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
        floatingActionButton: controlButton(
          context,
          rotateController,
          rotateAnimation,
          moveController,
          moveAnimation,
          openedButton,
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: DeckManager.deckList.length,
            itemBuilder: (context, index) {
              return Card(
                color: index % 2 == 0 ? Colors.grey : Colors.white,
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.only(top: 4.5),
                    child: Text(
                      DeckManager.deckList[index].deckName,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${DeckManager.deckList[index].getNewCard()} ',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        '${DeckManager.deckList[index].getLearningCard()} ',
                        style: TextStyle(
                          color: Colors.red.shade700,
                        ),
                      ),
                      Text(
                        '${DeckManager.deckList[index].getGraduatedCard()}',
                        style: TextStyle(color: Colors.green.shade900),
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
                          builder: (context) => const SecondRoute()),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

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
          const ListTile(
            leading: Icon(Icons.manage_search),
            title: Text('Decks'),
          ),
          const ListTile(
            leading: Icon(Icons.search),
            title: Text('Card browser'),
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
  bool light = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: light,
        onChanged: (bool value2) {
          light = value2;
          appTheme.switchTheme();
          setState(() {

          });
        });
  }
}
