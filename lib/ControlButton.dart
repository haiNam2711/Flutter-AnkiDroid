import 'dart:ffi';
import 'dart:math';

import 'package:five_control_widget/AddScene.dart';
import 'package:flutter/material.dart';

Widget ControlButton(
    BuildContext context,
    AnimationController rotateController,
    Animation<double> rotateAnimation,
    AnimationController moveController,
    Animation<double> moveAnimation,
    ValueNotifier<bool> openedButton,
    ) {
  return Stack(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Text(
                            'Create deck',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.black54,
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        ),
                        FloatingActionButton(
                          heroTag: "creat deck",
                          mini: true,
                          backgroundColor: Colors.blue,
                          child: const Icon(Icons.folder),
                          onPressed: () {},
                        ),
                      ]
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Get shared data button.
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              'Get shared decks',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.black54,
                            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          ),
                          FloatingActionButton(
                            heroTag: "get shard decks",
                            mini: true,
                            backgroundColor: Colors.blue,
                            child: const Icon(Icons.download),
                            onPressed: () {},
                          ),
                        ]
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Add note button.
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.black54,
                            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          ),
                          FloatingActionButton(
                            heroTag: "add",
                            mini: true,
                            backgroundColor: Colors.blue,
                            child: const Icon(Icons.add),
                            onPressed: () {
                              rotateController.reverse();
                              moveController.reverse();
                              openedButton.value = !openedButton.value;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddScene()),
                              );
                            },
                          ),
                        ]
                    ),
                    SizedBox(
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
                  heroTag: "control",
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add),
                  onPressed: () {
                    openedButton.value = !openedButton.value;
                    if (openedButton.value) rotateController.forward();
                    else rotateController.reverse();
                    if (openedButton.value) moveController.forward();
                    else moveController.reverse();
                  },
                ),
                builder: (context, child) => Transform.rotate(
                  angle: rotateAnimation.value,
                  child: child,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
