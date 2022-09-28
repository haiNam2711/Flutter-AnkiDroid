import 'package:flutter/material.dart';

class AddScene extends StatefulWidget {
  const AddScene({Key? key}) : super(key: key);

  @override
  State<AddScene> createState() => _AddSceneState();
}

class _AddSceneState extends State<AddScene> {
  String typeValue = 'Basic';
  String deckValue = 'Default 0';
  double fontSize20 = 20.0;
  double fontsize15 = 15.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
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
              child: Text(
                'Add note',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Type
                Container(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Row(
                    children: [
                      Text(
                        'Type:',
                        style: TextStyle(
                          fontSize: fontsize15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
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
                                style: TextStyle(
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
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Row(
                    children: [
                      Text(
                        'Deck:',
                        style: TextStyle(
                          fontSize: fontsize15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
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
                            });
                          },
                          items: <String>[
                            'Default 0',
                            'Default 1',
                            'Default 2',
                            'Default 3',
                            'Default 4',
                            'Default 5',
                            'Default 6',
                            'Default 7',
                            'Default 8',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
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
                  padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        'Front',
                        style: TextStyle(
                          fontSize: fontsize15,
                        ),
                      ),
                      SizedBox(
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
                  padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: fontsize15,
                    ),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                // Back
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        'Back',
                        style: TextStyle(
                          fontSize: fontsize15,
                        ),
                      ),
                      SizedBox(
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
                  padding: EdgeInsets.fromLTRB(20, 0, 30, 20),
                  child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: fontsize15,
                      ),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                // Tags
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  color: Colors.black54,
                  child: ListTile(
                    title: Text(
                      'Tags:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontsize15,
                      ),
                    ),
                  )
                ),
                // Cards
                Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    color: Colors.black54,
                    child: ListTile(
                      title: Text(
                        'Card: Card1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontsize15,
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
