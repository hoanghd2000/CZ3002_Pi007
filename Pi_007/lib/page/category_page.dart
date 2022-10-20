import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/databases/db_categories.dart';
import 'add_category.dart';
import 'edit_category.dart';

class CategoryPage extends StatelessWidget {

  static const IconData categoryIcon =
      IconData(0xe148, fontFamily: 'MaterialIcons');
  static const IconData grid_view_sharp =
      IconData(0xe9e5, fontFamily: 'MaterialIcons');
  static const IconData create_sharp =
    IconData(0xe89b, fontFamily: 'MaterialIcons');

  final Map<String, IconData> myIconCollection = {
    'favorite': Icons.favorite,
    'home': Icons.home,
    'android': Icons.android,
    'album': Icons.album,
    'ac_unit': Icons.ac_unit,
    'access_alarm': Icons.access_alarm,
    'access_time': Icons.access_time,
    'umbrella_sharp': Icons.umbrella_sharp,
    'headphones': Icons.headphones,
    'car_repair': Icons.car_repair,
    'settings': Icons.settings,
    'flight': Icons.flight,
    'run_circle': Icons.run_circle,
    'book': Icons.book,
    'sports_rugby_rounded': Icons.sports_rugby_rounded,
    'alarm': Icons.alarm,
    'call': Icons.call,
    'snowing': Icons.snowing,
    'hearing': Icons.hearing,
    'music_note': Icons.music_note,
    'note': Icons.note,
    'edit': Icons.edit,
    'sunny': Icons.sunny,
    'radar': Icons.radar,
    'wallet': Icons.wallet,
    'food': Icons.fastfood,
    'shopping': Icons.shopping_bag,
    'car': Icons.directions_car,
    'work': Icons.work,
    'dollar_sign': Icons.attach_money,
    'dollar_bill': Icons.money_sharp,
    'savings': Icons.savings,
    'bitcoin': Icons.currency_bitcoin,
    'currency_exchange': Icons.currency_exchange,
  };

  // colors
  static const navigation_bar = Color(0xFFFFEAD1); //beige
  static const main_section = Color(0xFFC9C5F9); //purple
  static const action_button = Color(0xFFF8C8DC); //pink
  static const confirm_button = Color(0xFFB4ECB4); //green
  static const secondary_section = Color(0xFFC5E0F9); //blue
  static const list_color = Color(0xFFECECEC); //grey
  static const cancel_button = Color(0xFFFA7979);

  // List<Categories> categoryList = [
  //   Categories(title: 'Salary', icon: "work", isSpending: 0),
  //   Categories(title: 'Allowance', icon: "savings", isSpending: 0),
  //   Categories(title: 'Investment', icon: "bitcoin", isSpending: 0),
  //   Categories(title: 'Food', icon: "food", isSpending: 1),
  //   Categories(title: 'Transport', icon: "car", isSpending: 1),
  //   Categories(title: 'Shopping', icon: "shopping", isSpending: 1),
  // ];

  DbCats_Manager categoriesDBM = DbCats_Manager();
  Category category;
  List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Category'),
          backgroundColor: navigation_bar,
          foregroundColor: Colors.black,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(children: [
                Icon(categoryIcon, size: 35),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("Category", style: TextStyle(fontSize: 35)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: OutlinedButton(
                    onPressed: () async {
                      final result = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddCategory()));
                      (context as Element).reassemble();
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
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Row(
            //     children: [
            //       Text("Earning Categories: ", style: TextStyle(fontSize: 20))
            //     ],
            //   ),
            // ),
            FutureBuilder(
              future: categoriesDBM.getAllCategory(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
                if (snapshot.hasData) {
                  int numEarningCategory = 0;
                  categoryList = snapshot.data;
                  for (var i = 0; i < categoryList.length; i++) {
                    if (categoryList[i].isSpending == 0){
                      numEarningCategory++;
                      print("increment");
                    }
                  }
                  print("numEarningCat: " + numEarningCategory.toString());
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      // print(categoryList[index]);
                      // print(categoryList[index].id);
                      // if (categoryList[index].isSpending == 0){
                        print("Check1 id");
                        print(categoryList[index].id);
                        return Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text("Earning Categories: ", style: TextStyle(fontSize: 20)),
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Card(
                                        elevation: 0,
                                        shape: Border(bottom: BorderSide(color: Colors.black)),
                                        child: Row(
                                            children: [
                                              Column(children: [
                                                IconButton(
                                                  icon: Icon(myIconCollection[categoryList[index].icon], color: Colors.black),
                                                ),
                                              ]),
                                              Column(children: [
                                                Text(categoryList[index].name, style: TextStyle(fontSize: 20)),
                                              ]),
                                              // Spacer(),
                                              SizedBox(width: 150),
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
                                                                builder: (context) => EditCategory(categoryList[index])
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
                                  ],
                                ),

                              ),
                            ],
                          ),
                        );
                      // }
                    },
                  );

                } else {
                  return const Center(
                    child: Text("No data found"),
                  );
                }
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Row(
            //     children: [
            //       Text("Spending Categories: ", style: TextStyle(fontSize: 20))
            //     ],
            //   ),
            // ),
            // FutureBuilder(
            //   future: categoriesDBM.getAllCategory(),
            //   builder:
            //       (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
            //     if (snapshot.hasData) {
            //       int numSpendingCategory = 0;
            //       categoryList = snapshot.data;
            //       for (var i = 0; i < categoryList.length; i++) {
            //         if (categoryList[i].isSpending == 1){
            //           numSpendingCategory++;
            //           print("test: " + numSpendingCategory.toString());
            //         }
            //       }
            //       categoryList = snapshot.data;
            //       return ListView.builder(
            //         primary: false,
            //         shrinkWrap: true,
            //         itemCount: numSpendingCategory,
            //         itemBuilder: (context, index) {
            //           if (categoryList[index].isSpending == 1){
            //             print("Check2");
            //             return Container(
            //               child: Row(
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.all(15.0),
            //                     child: Row(
            //                       children: [
            //                         // Text("Earning Categories: ", style: TextStyle(fontSize: 20)),
            //                         Padding(
            //                           padding: const EdgeInsets.all(0.0),
            //                           child: Card(
            //                             elevation: 0,
            //                             shape: Border(bottom: BorderSide(color: Colors.black)),
            //                             child: Row(
            //                                 children: [
            //                                   Column(children: [
            //                                     IconButton(
            //                                       icon: Icon(myIconCollection[categoryList[index].icon], color: Colors.black),
            //                                     ),
            //                                   ]),
            //                                   Column(children: [
            //                                     Text(categoryList[index].name, style: TextStyle(fontSize: 20)),
            //                                   ]),
            //                                   // Spacer(),
            //                                   SizedBox(width: 150),
            //                                   Column(children: [
            //                                     Row(
            //                                       children: [
            //                                         IconButton(
            //                                           icon: Icon(Icons.create_sharp, color: Colors.black),
            //                                           onPressed: () async {
            //                                             final edittedresult =
            //                                             await Navigator.push(
            //                                                 context,
            //                                                 MaterialPageRoute(
            //                                                     builder: (context) => EditCategory(categoryList[index])
            //                                                 )
            //                                             );
            //                                             // .then(
            //                                             //   (value) => (context as Element).reassemble()
            //                                             // );
            //                                             // print(edittedresult);
            //                                           },
            //                                         ),
            //                                         IconButton(
            //                                           icon: Icon(Icons.delete, color: Colors.black),
            //                                           onPressed: () {},
            //                                         ),
            //                                       ],
            //                                     )
            //                                   ]),
            //                                 ]),
            //                             color: Colors.grey[50],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //
            //                   ),
            //                 ],
            //               ),
            //             );
            //           }
            //         },
            //       );
            //
            //     } else {
            //       return const Center(
            //         child: Text("No data found"),
            //       );
            //     }
            //   },
            // ),
          ],
        ),
    );
  }
}

class Categories {
  final String title;
  final String icon;
  final int isSpending;

  const Categories({this.title, this.icon, this.isSpending});
}
