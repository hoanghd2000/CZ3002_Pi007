import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pi_007/page/splitbill_page2.dart';
import 'package:pi_007/page/splitbill_page3.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class SplitBillPage extends StatefulWidget {
  const SplitBillPage({Key key}) : super(key: key);

  @override
  State<SplitBillPage> createState() => _SplitBillPage();
}

class _SplitBillPage extends State<SplitBillPage> {
  // colors
  static const navigation_bar = Color(0xFFFFEAD1); //beige
  static const main_section = Color(0xFFC9C5F9); //purple
  static const action_button = Color(0xFFF8C8DC); //pink
  static const confirm_button = Color(0xFFB4ECB4); //green
  static const secondary_section = Color(0xFFC5E0F9); //blue
  static const list_color = Color(0xFFECECEC); //grey

  bool isAdded = false;

  List<Bill> billList = [
    Bill("Hot pot with JC friends", 103.50, DateTime.parse("2022-09-04")),
  ];

  @override
  Widget build(BuildContext context) {
    print("isAdded is ${isAdded}");

    if (isAdded) {
      billList.add(Bill('Receipt1', 60.0, DateTime.parse("2022-10-27")));
      setState(() {
        isAdded = false;
      });
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: billList.length,
        itemBuilder: (context, index) {
          // return GestureDetector(
          //   onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SplitBillPage3(itemPayerMap))),
          //   child: _displayCard(billList[index]),
          // );
          return _displayCard(billList[index]);
        },
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: action_button,
          foregroundColor: Colors.black,
          onPressed: () {
            // add route here
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SplitBillPage2()));

            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("New Receipt", textAlign: TextAlign.center),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: <Widget>[
                        Column(
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                // _navigateToAddPage(context);
                              },
                              child: Text('Add Manually'),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                primary: action_button, //background
                                onPrimary: Colors.black, //foreground
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                // _fakeAddImage(context, ImageSource.camera);
                              },
                              child: Text('Add from camera'),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                primary: action_button, //background
                                onPrimary: Colors.black, //foreground
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                _fakeAddImage(context, ImageSource.gallery);
                              },
                              child: Text('Add from gallery'),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                primary: action_button, //background
                                onPrimary: Colors.black, //foreground
                              ),
                            )
                          ],
                        )
                      ],
                    ));
          }),
    );
  }

  void _fakeAddImage(BuildContext context, ImageSource imgSrc) async {
    // Initialize an ImagePicker
    final ImagePicker _picker = ImagePicker();
    // Pick an image from Gallery
    final XFile image = await _picker.pickImage(source: imgSrc);
    if (image != null) {
      // sleep(Duration(seconds: 3));
      // isAdded = true;

      await Future.delayed(Duration(seconds: 2));
      setState(() {
        isAdded = true;
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SplitBillPage2()));
    }
  }
}

class Bill {
  final String name;
  final double amount;
  final DateTime date;

  const Bill(this.name, this.amount, this.date);
}

Widget _displayCard(Bill bill) {
  return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(DateFormat('yyyy-MM-dd').format(bill.date),
              style: TextStyle(fontSize: 16)),
          Text(bill.name, style: TextStyle(fontSize: 16)),
          Text("\$" + (bill.amount).toStringAsFixed(2),
              style: TextStyle(fontSize: 16, color: Colors.red)),
        ]),
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Color(0xFFF7F7F7),
      margin: const EdgeInsets.only(bottom: 20));
}
