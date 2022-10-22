import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:pi_007/page/splitbill_page.dart';
import 'package:intl/intl.dart';
// import 'package:pi_007/graphics/blue-strikethrough.png';
import '../main.dart';

class SplitBillPage3 extends StatefulWidget {
  // const SplitBillPage3({Key key}) : super(key: key);
  final Map payerAmountItemMap;
  SplitBillPage3(this.payerAmountItemMap);
  @override
  State<SplitBillPage3> createState() => _SplitBillPage3();
}

class _SplitBillPage3 extends State<SplitBillPage3>
    with TickerProviderStateMixin {
  static const confirm_button = Color(0xFFB4ECB4); //green
  static const navigation_bar = Color(0xFFFFEAD1); //beige
  static const list_color = Color(0xFFECECEC); //grey

  static const List<String> payer_list = <String>[
    'Me',
    'John',
    'Jimmy',
    'Jackson'
  ];

  Map<String, dynamic> modelOutput = {
    'price_list': {
      'Prawns': '20.00',
      'Chicken': '15.50',
      'Mushroom': '12.00',
      'Potato': '8.50',
      'Tofu': '4.00',
    },
    'total': '60.00'
  };

  // Map<String, List<String>> itemPayerMap = {
  //   'Prawns': ['Me', 'John', 'Jimmy', 'Jackson'], // 5 each
  //   'Chicken': ['Me', 'Jimmy', 'Jackson'], // 5.17 each (round up)
  //   'Mushroom': ['John', 'Jimmy'], // 6 each
  //   'Potato': ['Me', 'John'], // 4.25 each
  //   'Tofu': ['Jackson'], // 4
  // };

  // Map<String, List<String>> payerItemMap = {
  //   'Me': ['Prawns', 'Chicken', 'Potato'],
  //   'John': ['Prawns', 'Mushroom', 'Potato'],
  //   'Jimmy': ['Prawns', 'Chicken', 'Mushroom'],
  //   'Jackson': ['Prawns', 'Chicken', 'Tofu'],
  // };

  // Me = 14.42, john = 15.25, jimmy = 16.17, jackson = 14.17

  Map<String, double> payerAmountMap;
  Map<String, dynamic> payerItemMap;

  List<bool> isStrike = [false, false, false, false];

  List<double> strikeHeight = [
    20.0,
    30.0,
    50.0,
    60.0,
    80.0,
  ];

  // 5 = 80.0
  // 4 = 60
  // 3 = 50
  // 2 = 30
  // 1 = 20

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
      duration: new Duration(milliseconds: 225),
      vsync: this,
    );

    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.easeOut);

    animation = new Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() => setState(() {}));
    controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    payerAmountMap = widget.payerAmountItemMap['payerAmountMap'];
    payerItemMap = widget.payerAmountItemMap['payerItemMap'];
    print(payerAmountMap);
    print(payerItemMap);
    print(isStrike.toString());

    return Scaffold(
        appBar: AppBar(
          title: Text('Group Receipt'),
          backgroundColor: navigation_bar,
          foregroundColor: Colors.black,
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(160, 20, 0, 0),
            child: Text("Untitled",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          // Text(widget.itemPayerMap.toString()),
          // Text(payerItemMap.toString()),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("Payer",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(110, 20, 0, 0),
                  child: Text("Amount",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 20, 0, 0),
                  child: Text("Items",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            // ListView.builder(
            //   physics: NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: 4,
            //   itemBuilder: ,
            // ),
            InkWell(
              onTap: () {
                setState((() => isStrike[0] = !isStrike[0]));
                controller.forward(from: 0.0);
              },
              child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(flex: 1, child: SizedBox.shrink()),
                          Expanded(
                              flex: 5,
                              child: Text(
                                "1.  " + payer_list[0],
                                style: TextStyle(fontSize: 16),
                              )),
                          Expanded(flex: 2, child: SizedBox.shrink()),
                          Expanded(
                            flex: 5,
                            child: Text(
                              payerAmountMap[payer_list[0]].toString(),
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox.shrink()),
                          Expanded(
                              flex: 5,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: payerItemMap[payer_list[0]].length,
                                itemBuilder:
                                    (BuildContext context, int index) => Text(
                                  payerItemMap[payer_list[0]][index].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          Expanded(flex: 1, child: SizedBox.shrink()),
                        ],
                      ),
                      Container(
                        height: strikeHeight[
                            payerItemMap[payer_list[0]].length - 1],
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..scale(animation.value, 1.0),
                        child: Text(
                          "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                          style: TextStyle(
                            color: Colors.transparent,
                            decorationColor: Color.fromARGB(255, 0, 105, 192),
                            decorationStyle: TextDecorationStyle.solid,
                            decoration: isStrike[0]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            // SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                setState((() => isStrike[1] = !isStrike[1]));
                controller.forward(from: 0.0);
              },
              child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(flex: 1, child: SizedBox.shrink()),
                          Expanded(
                              flex: 5,
                              child: Text(
                                "2.  " + payer_list[1],
                                style: TextStyle(fontSize: 16),
                              )),
                          Expanded(flex: 2, child: SizedBox.shrink()),
                          Expanded(
                            flex: 5,
                            child: Text(
                              payerAmountMap[payer_list[1]].toString(),
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox.shrink()),
                          Expanded(
                              flex: 5,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: payerItemMap[payer_list[1]].length,
                                itemBuilder:
                                    (BuildContext context, int index) => Text(
                                  payerItemMap[payer_list[1]][index].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          Expanded(flex: 1, child: SizedBox.shrink()),
                        ],
                      ),
                      Container(
                        height: strikeHeight[
                            payerItemMap[payer_list[1]].length - 1],
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..scale(animation.value, 1.0),
                        child: Text(
                          "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                          style: TextStyle(
                            color: Colors.transparent,
                            decorationColor: Color.fromARGB(255, 0, 105, 192),
                            decorationStyle: TextDecorationStyle.solid,
                            decoration: isStrike[1]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            // SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                setState((() => isStrike[2] = !isStrike[2]));
                controller.forward(from: 0.0);
              },
              child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(flex: 1, child: SizedBox.shrink()),
                          Expanded(
                              flex: 5,
                              child: Text(
                                "3.  " + payer_list[2],
                                style: TextStyle(fontSize: 16),
                              )),
                          Expanded(flex: 2, child: SizedBox.shrink()),
                          Expanded(
                            flex: 5,
                            child: Text(
                              payerAmountMap[payer_list[2]].toString(),
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox.shrink()),
                          Expanded(
                              flex: 5,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: payerItemMap[payer_list[2]].length,
                                itemBuilder:
                                    (BuildContext context, int index) => Text(
                                  payerItemMap[payer_list[2]][index].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          Expanded(flex: 1, child: SizedBox.shrink()),
                        ],
                      ),
                      Container(
                        height: strikeHeight[
                            payerItemMap[payer_list[2]].length - 1],
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..scale(animation.value, 1.0),
                        child: Text(
                          "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                          style: TextStyle(
                            color: Colors.transparent,
                            decorationColor: Color.fromARGB(255, 0, 105, 192),
                            decorationStyle: TextDecorationStyle.solid,
                            decoration: isStrike[2]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            // SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                setState((() => isStrike[3] = !isStrike[3]));
                controller.forward(from: 0.0);
              },
              child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(flex: 1, child: SizedBox.shrink()),
                          Expanded(
                              flex: 5,
                              child: Text(
                                "4.  " + payer_list[3],
                                style: TextStyle(fontSize: 16),
                              )),
                          Expanded(flex: 2, child: SizedBox.shrink()),
                          Expanded(
                            flex: 5,
                            child: Text(
                              payerAmountMap[payer_list[3]].toString(),
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox.shrink()),
                          Expanded(
                              flex: 5,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: payerItemMap[payer_list[3]].length,
                                itemBuilder:
                                    (BuildContext context, int index) => Text(
                                  payerItemMap[payer_list[3]][index].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          Expanded(flex: 1, child: SizedBox.shrink()),
                        ],
                      ),
                      Container(
                        height: strikeHeight[
                            payerItemMap[payer_list[3]].length - 1],
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..scale(animation.value, 1.0),
                        child: Text(
                          "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                          style: TextStyle(
                            color: Colors.transparent,
                            decorationColor: Color.fromARGB(255, 0, 105, 192),
                            decorationStyle: TextDecorationStyle.solid,
                            decoration: isStrike[3]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontSize: 16,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      // save back to static list in splitbill_page
                      // SplitBillPage.addGrpReceipt(Bill('Untitled', 50.0, DateTime.parse("2022-10-27")));
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SplitBillPage()));
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyApp()));
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      primary: confirm_button, //background
                      onPrimary: Colors.black, //foreground
                    )),
              ),
            ),
          ])
        ]));
  }
}
