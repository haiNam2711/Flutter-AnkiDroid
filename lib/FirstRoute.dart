import 'dart:ffi';

import 'package:flutter/material.dart';
import 'SecondRoute.dart';

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: SideBar(),
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
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              ),
            ),
            IconButton(
              onPressed: () {},
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
        body: ListView.builder(
          itemCount: 9,
          itemBuilder: (context, index) {
            return Card(
              color: index % 2 == 0 ? Colors.grey : Colors.white,
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.only(top: 4.5),
                  child: Text(
                    'Default $index',
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '1 ',
                      style: TextStyle(
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const Text(
                      '2 ',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      '3',
                      style: TextStyle(color: Colors.green.shade400),
                    ),
                  ],
                ),
                onTap: () {
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
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Image.asset('images/anki.png'),
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
            trailing: nightModeSwitch(),
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

class nightModeSwitch extends StatefulWidget {
  const nightModeSwitch({Key? key}) : super(key: key);

  @override
  State<nightModeSwitch> createState() => _nightModeSwitchState();
}

class _nightModeSwitchState extends State<nightModeSwitch> {
  bool light = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: light,
        onChanged: (bool value2) {
          setState(() {
            light = value2;
          });
        });
  }
}