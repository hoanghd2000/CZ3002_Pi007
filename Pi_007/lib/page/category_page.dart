import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_category.dart';
import 'edit_category.dart';

class CategoryPage extends StatelessWidget {

  static const IconData category =
      IconData(0xe148, fontFamily: 'MaterialIcons');
  static const IconData grid_view_sharp =
      IconData(0xe9e5, fontFamily: 'MaterialIcons');
  static const IconData create_sharp =
    IconData(0xe89b, fontFamily: 'MaterialIcons');

  final Map<String, IconData> myIconCollection = {
    'food': Icons.fastfood,
    'shopping': Icons.shopping_bag,
    'car': Icons.directions_car,
    'work': Icons.work,
    'savings': Icons.savings,
    'bitcoin': Icons.currency_bitcoin,
    'create_sharp': Icons.create_sharp,
  };

  // colors
  static const navigation_bar = Color(0xFFFFEAD1); //beige
  static const main_section = Color(0xFFC9C5F9); //purple
  static const action_button = Color(0xFFF8C8DC); //pink
  static const confirm_button = Color(0xFFB4ECB4); //green
  static const secondary_section = Color(0xFFC5E0F9); //blue
  static const list_color = Color(0xFFECECEC); //grey
  static const cancel_button = Color(0xFFFA7979);

  List<Categories> spendingCategoryList = [
    Categories(title: 'Food', icon: "food"),
    Categories(title: 'Transport', icon: "car"),
    Categories(title: 'Shopping', icon: "shopping"),
  ];

  List<Categories> earningCategoryList = [
    Categories(title: 'Salary', icon: "work"),
    Categories(title: 'Allowance', icon: "savings"),
    Categories(title: 'Investment', icon: "bitcoin"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Category'),
          backgroundColor: navigation_bar,
          foregroundColor: Colors.black,
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(children: [
              Icon(category, size: 35),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text("Category", style: TextStyle(fontSize: 35)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddCategory())
                        );
                  },
                  child: Text("+ Add Category", style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                    backgroundColor: action_button,
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text("Earning Categories: ", style: TextStyle(fontSize: 20))
              ],
            ),
          ),
          const Divider(
            height: 3,
            thickness: 1,
            indent: 5,
            endIndent: 5,
            color: Colors.black,
          ),
          ...earningCategoryList
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Card(
                    elevation: 0,
                    shape: Border(bottom: BorderSide(color: Colors.black)),
                    child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(children: [
                            IconButton(
                              icon: Icon(myIconCollection[item.icon], color: Colors.black),
                            ),
                          ]),
                          Column(children: [
                            Text(item.title, style: TextStyle(fontSize: 20)),
                          ]),
                          Spacer(),
                          Column(children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.create_sharp, color: Colors.black),
                                  onPressed: () async {
                                    final edittedresult =
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditCategory(item)
                                      )
                                    );
                                    // .then(
                                    //   (value) => (context as Element).reassemble()
                                    // );
                                    // print(edittedresult);
                                    },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.black),
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ]),
                        ]),
                    color: Colors.grey[50],
                  ),
                ),
              )
              .toList(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text("Spending Categories: ", style: TextStyle(fontSize: 20))
              ],
            ),
          ),
          const Divider(
            height: 3,
            thickness: 1,
            indent: 5,
            endIndent: 5,
            color: Colors.black,
          ),
          ...spendingCategoryList
              .map(
                (item) => Padding(
              padding: const EdgeInsets.all(0.0),
              child: Card(
                elevation: 0,
                shape: Border(bottom: BorderSide(color: Colors.black)),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(children: [
                        IconButton(
                          icon: Icon(myIconCollection[item.icon], color: Colors.black),
                        ),
                      ]),
                      Column(children: [
                        Text(item.title, style: TextStyle(fontSize: 20)),
                      ]),
                      Spacer(),
                      Column(children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.create_sharp, color: Colors.black),
                              onPressed: () async {
                                final edittedresult =
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditCategory(item)
                                    )
                                );
                                // .then(
                                //   (value) => (context as Element).reassemble()
                                // );
                                // print(edittedresult);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.black),
                              onPressed: () {},
                            ),
                          ],
                        )
                      ]),
                    ]),
                color: Colors.grey[50],
              ),
            ),
          )
              .toList(),
        ]));
  }
}

class Categories {
  final String title;
  final String icon;

  const Categories({this.title, this.icon});
}
