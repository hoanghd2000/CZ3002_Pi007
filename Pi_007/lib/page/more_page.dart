import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/page/category_page.dart';

class MorePage extends StatelessWidget {
  static const IconData arrow_forward_ios =
      IconData(0xe09c, fontFamily: 'MaterialIcons');
  // colors
  static const navigation_bar = Color(0xFFFFEAD1); //beige
  static const main_section = Color(0xFFC9C5F9); //purple
  static const action_button = Color(0xFFF8C8DC); //pink
  static const confirm_button = Color(0xFFB4ECB4); //green
  static const secondary_section = Color(0xFFC5E0F9); //blue
  static const list_color = Color(0xFFECECEC); //grey
  static const cancel_button = Color(0xFFFA7979);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Column(children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('XYZ123', style: TextStyle(fontSize: 40)),
          ),
        ),
        Card(
          elevation: 0,
          child:
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Column(children: [
                          Text("Back up", style: TextStyle(fontSize: 20)),
                        ])),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Column(children: [
                        // Icon(create_sharp),
                        IconButton(
                          icon: const Icon(arrow_forward_ios, color: Colors.black),
                        ),
                      ]),
                    ),
                  ]
              ),
          color: Colors.grey[50],
        ),
        Card(
          elevation: 0,
          child:
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(children: [
                        Text("Category Manager", style: TextStyle(fontSize: 20)),
                      ])),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Column(children: [
                      IconButton(
                        icon: const Icon(arrow_forward_ios, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryPage()));
                        },
                      ),
                    ]),
                  ),
                ]
            ),
          color: Colors.grey[50],
        ),
        Card(
          elevation: 0,
          child:
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Column(children: [
                          Text("Add Friends", style: TextStyle(fontSize: 20)),
                        ])),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Column(children: [
                        IconButton(
                          icon: const Icon(arrow_forward_ios, color: Colors.black),
                        ),
                      ]),
                    ),
                  ]
              ),
          color: Colors.grey[50],
        )
      ])
  );
}
