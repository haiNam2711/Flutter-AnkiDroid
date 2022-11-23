import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:five_control_widget/algorithm_sm2/card.dart';
import 'package:flutter/material.dart';

import '../algorithm_sm2/deck.dart';
import '../algorithm_sm2/deck_manager.dart';
import '../dark_mode/theme.dart';
import '../firebase/cloud.dart';
import '../widget/scrollable_widget.dart';

class CardBrowserRoute extends StatefulWidget {
  final Function() setHomeState;
  final Cloud cloud;
  const CardBrowserRoute(
      {Key? key, required this.setHomeState, required this.cloud})
      : super(key: key);

  @override
  State<CardBrowserRoute> createState() => _CardBrowserRouteState();
}

class _CardBrowserRouteState extends State<CardBrowserRoute> {
  TextEditingController frontSideController = TextEditingController();
  TextEditingController backSideController = TextEditingController();
  String currentDeck = DeckManager.deckList[0].deckName;
  Deck tmpDeck = DeckManager.deckList[0];
  final List<String> items = [];
  List<FlashCard> SelectedCards = [];
  List<FlashCard> cardsList = [];

  _CardBrowserRouteState() {
    for (int i = 0; i < DeckManager.deckList.length; i++) {
      items.add(DeckManager.deckList[i].deckName);
    }
    currentDeck = items[0];
    for (int i = 0; i < items.length; i++) {
      print(items[i]);
    }
    print(currentDeck);
    for (int i = 0; i < DeckManager.deckList[0].cardList.length; i++) {
      cardsList.add(DeckManager.deckList[0].cardList[i]);
    }
  }

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
            widget.setHomeState();
            Navigator.pop(context);
          },
        ),
        title: Container(
          padding: const EdgeInsets.only(left: 10),
          width: 250,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: DropdownButton<String>(
            isExpanded: true,
            value: currentDeck,
            onChanged: (String? newValue) {
              currentDeck = newValue!;
              for (int i = 0; i < DeckManager.deckList.length; i++) {
                if (DeckManager.deckList[i].deckName == currentDeck) {
                  cardsList = DeckManager.deckList[i].cardList;
                  tmpDeck = DeckManager.deckList[i];
                }
              }
              setState(() {});
            },
            items: items
                .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                color:
                                    AppTheme().currentTheme() == ThemeMode.dark
                                        ? Colors.teal
                                        : Colors.black,
                              )),
                        ))
                .toList(),

            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.teal,
            ),
            iconSize: 35,
            //underline: SizedBox(),
          ),
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              customButton: Container(
                margin: EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              customItemsHeights: [
                ...List<double>.filled(MenuItems.firstItems.length, 48),
                8,
                ...List<double>.filled(MenuItems.secondItems.length, 48),
              ],
              items: [
                ...MenuItems.firstItems.map(
                  (item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item),
                  ),
                ),
                const DropdownMenuItem<Divider>(
                    enabled: false, child: Divider()),
                ...MenuItems.secondItems.map(
                  (item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item),
                  ),
                ),
              ],
              onChanged: (value) {
                switch (value) {
                  case MenuItems.edit:
                    if (SelectedCards.length == 1) {
                      showEditDia(SelectedCards[0]);
                      SelectedCards = [];
                      setState(() {});
                    } else {
                      showFailDia(
                          'Edit Card Fail.', 'Your card number is not valid.');
                    }
                    SelectedCards = [];
                    break;
                  case MenuItems.delete:
                    if (SelectedCards.isNotEmpty) {
                      int firstLength = SelectedCards.length;
                      for (int i = firstLength - 1; i >= 0; i--) {
                        FlashCard fc = SelectedCards[i];
                        cardsList.remove(fc);
                        tmpDeck.cardList.remove(fc);
                        tmpDeck.removeCardOnCloud(
                            tmpDeck.deckName, fc.name, widget.cloud);
                      }
                      SelectedCards = [];
                      setState(() {});
                    } else {
                      showFailDia(
                          'Delete Card Fail.', 'Your must select cards to delete.');
                    }
                    break;
                }
              },
              itemHeight: 48,
              itemPadding: const EdgeInsets.only(left: 16, right: 16),
              dropdownWidth: 160,
              dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.blue.shade400,
              ),
              dropdownElevation: 8,
              offset: const Offset(0, 8),
            ),
          )
        ],
      ),
      body: ScrollableWidget(child: buildDataTable()),
    );
  }

  Widget buildDataTable() {
    final Columns = ['Front Side', 'Back Side'];

    return DataTable(
      columns: getColumn(Columns),
      rows: getRow(cardsList),
    );
  }

  List<DataColumn> getColumn(List<String> columns) => columns
      .map((String column) => DataColumn(
              label: Text(
            column,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppTheme().currentTheme() == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            ),
          )))
      .toList();

  List<DataRow> getRow(List<FlashCard> rows) => rows
      .map((FlashCard card) => DataRow(
              selected: SelectedCards.contains(card),
              onSelectChanged: (isSelected) {
                setState(() {
                  final isAdding = ((isSelected != null) && isSelected);
                  isAdding
                      ? SelectedCards.add(card)
                      : SelectedCards.remove(card);
                  print(SelectedCards.length);
                });
              },
              cells: [
                DataCell(Container(
                    width: 150,
                    child: Text(
                      card.frontSide!.text!,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: AppTheme().currentTheme() == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ))),
                DataCell(Container(
                    width: 150,
                    child: Text(
                      card.backSide!.text!,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: AppTheme().currentTheme() == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    )))
              ]))
      .toList();

  void showEditDia(FlashCard flashCard) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Edit a card from $currentDeck',
          style: TextStyle(
            color: AppTheme().currentTheme() == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            controller: frontSideController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          TextFormField(
            controller: backSideController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ]),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              setState(() {
                SelectedCards = [];
                int index = tmpDeck.cardList.indexOf(flashCard);
                tmpDeck.cardList[index].frontSide?.text =
                    frontSideController.text;
                tmpDeck.cardList[index].backSide?.text =
                    backSideController.text;
                for (int i = 0; i < DeckManager.deckList.length; ++i) {
                  if (DeckManager.deckList[i].deckName == currentDeck) {
                    tmpDeck.updateCardOnCloud(deckId: i, cardId: index, cloud: widget.cloud);
                    break;
                  }
                }

                frontSideController.text = '';
                backSideController.text = '';
              });
              Navigator.pop(context);
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
              SelectedCards = [];
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

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [edit];
  static const List<MenuItem> secondItems = [delete];

  static const edit = MenuItem(text: 'Edit', icon: Icons.edit);
  static const delete = MenuItem(text: 'Delete', icon: Icons.delete);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item, FlashCard fc) {
    switch (item) {
      case MenuItems.edit:
        //Do something
        break;
      case MenuItems.delete:
        //Do something
        break;
    }
  }
}
