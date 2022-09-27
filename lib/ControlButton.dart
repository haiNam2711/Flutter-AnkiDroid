import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

Widget ControlButton(
    BuildContext context,
    AnimationController rotateController,
    Animation<double> rotateAnimation,
    AnimationController moveController,
    Animation<double> moveAnimation,
    bool openedButton,
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
                            mini: true,
                            backgroundColor: Colors.blue,
                            child: const Icon(Icons.add),
                            onPressed: () {},
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
                      -moveAnimation.value + 300.0,
                  ),
                  child: child,
                ),
              ),

              // Main control button.
              AnimatedBuilder(
                animation: rotateAnimation,
                child: FloatingActionButton(
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add),
                  onPressed: () {
                    openedButton = !openedButton;
                    if (openedButton) rotateController.forward();
                    else rotateController.reverse();
                    if (openedButton) moveController.forward();
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
