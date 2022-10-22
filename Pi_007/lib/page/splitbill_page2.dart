import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:pi_007/page/splitbill_page3.dart';


class SplitBillPage2 extends StatefulWidget {
  const SplitBillPage2({Key key}) : super(key: key);

  @override
  State<SplitBillPage2> createState() => _SplitBillPage2();
}

class _SplitBillPage2 extends State<SplitBillPage2> {

  static const confirm_button = Color(0xFFB4ECB4); //green
  static const navigation_bar = Color(0xFFFFEAD1); //beige
  static const list_color = Color(0xFFECECEC); //grey

  static const List<String> payer_list = <String>['Me', 'Hoang', 'Mei Qi', 'Jimmy'];
  static const List<String> item_list = <String>['Prawns', 'Chicken','Mushroom','Potato','Tofu'];
  static const List<String> amt_list = <String>['20.00', '15.50','12.00','8.50','4.00'];

  static const Map<String, dynamic> modelOutput = {
    'price_list': {
      'Prawns': '20.00',
      'Chicken': '15.50',
      'Mushroom': '12.00',
      'Potato': '8.50',
      'Tofu': '4.00',
    },
    'total': '60.00'
  };

  Rx<List<String>> selectedOptionList = Rx<List<String>>([]);
  var selectedOption = ''.obs;
  List<String> selected_prawn = [];
  List<String> selected_chick = [];
  List<String> selected_mushroom = [];
  List<String> selected_potato = [];
  List<String> selected_tofu = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('Create Group Receipt'),
      backgroundColor: navigation_bar,
      foregroundColor: Colors.black,
    ),
    body: ListView(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(160,20,0,0),
        child: Text("Untitled",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20,20,0,0),
                child: Text("Items",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90,20,0,0),
                child: Text("Amount",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90,20,0,0),
                child: Text("Payers",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
              ),
            ],
          ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12,20,12,12),
                  child: Text("1.  "+item_list[0],style:TextStyle(fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(64,20,12,12),
                  child: Text(amt_list[0],style:TextStyle(fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,8,0,0),
                  child: Container(
                    width: 160,
                    height: 50,
                    child: DropDownMultiSelect(
                      onChanged: (List<String> x) {
                        setState(() {
                          selected_prawn =x;
                        });
                      },
                      options: payer_list,
                      selectedValues: selected_prawn,
                      whenEmpty: 'Select Payer',
                    ),
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("2.  "+item_list[1],style:TextStyle(fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60,12,12,12),
                child: Text(amt_list[1],style:TextStyle(fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,8,0,0),
                child: Container(
                  width: 160,
                  height: 50,
                  child: DropDownMultiSelect(
                    onChanged: (List<String> x) {
                      setState(() {
                        selected_chick =x;
                      });
                    },
                    options: payer_list,
                    selectedValues: selected_chick,
                    whenEmpty: 'Select Payer',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("3.  "+item_list[2],style:TextStyle(fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40,12,12,12),
                child: Text(amt_list[2],style:TextStyle(fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,8,0,0),
                child: Container(
                  width: 160,
                  height: 50,
                  child: DropDownMultiSelect(
                    onChanged: (List<String> x) {
                      setState(() {
                        selected_mushroom =x;
                      });
                    },
                    options: payer_list,
                    selectedValues: selected_mushroom,
                    whenEmpty: 'Select Payer',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("4.  "+item_list[3],style:TextStyle(fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(75,12,12,12),
                child: Text(amt_list[3],style:TextStyle(fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,8,0,0),
                child: Container(
                  width: 160,
                  height: 50,
                  child: DropDownMultiSelect(
                    onChanged: (List<String> x) {
                      setState(() {
                        selected_potato =x;
                      });
                    },
                    options: payer_list,
                    selectedValues: selected_potato,
                    whenEmpty: 'Select Payer',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("5.  "+item_list[4],style:TextStyle(fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90,12,12,12),
                child: Text(amt_list[4],style:TextStyle(fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,8,0,0),
                child: Container(
                  width: 160,
                  height: 50,
                  child: DropDownMultiSelect(
                    onChanged: (List<String> x) {
                      setState(() {
                        selected_tofu =x;
                      });
                    },
                    options: payer_list,
                    selectedValues: selected_tofu,
                    whenEmpty: 'Select Payer',
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(155, 0,0, 12),
            child: Text('_________',style:TextStyle(fontSize: 15)),
          ),
          Padding(
           padding: const EdgeInsets.fromLTRB(160, 0, 12, 12),
           child: Text('60.00',style:TextStyle(fontSize: 15)),
         ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,20,0,0),
            child: Center(
              child: ElevatedButton(
                  onPressed: (){
                    // how to make all payer list static after this is pressed?
                    final List<String> prawn = selected_prawn;
                    final List<String> chick = selected_chick;
                    final List<String> mushroom = selected_mushroom;
                    final List<String> potato = selected_potato;
                    final List<String> tofu = selected_tofu;
                    Map<String,List<String>> itemPayerMap = {
                      'Prawns': prawn,
                      'Chicken': chick,
                      'Mushroom': mushroom,
                      'Potato': potato,
                      'Tofu': tofu,
                    };
                    // for (final e in itemPayerMap.entries) {
                    //   print('${e.key} : ${e.value}');
                    // }
                    print(itemPayerMap);
                    print("Confirm button pressed");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SplitBillPage3(_convert(itemPayerMap))));
                  },
                  child: Text('Confirm'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                    primary: confirm_button,  //background
                    onPrimary: Colors.black, //foreground
                  )
              ),
            ),
          ),
        ],
      ),
    ]
    )
    );
    
}
Map _convert(Map itemPayerMap) {
  // we need to get
  // Map<String, double> payerAmountMap = {};
  // Map<String, dynamic> payerItemMap = {};
  Map<String, double> payerAmountMap = {};
  Map<String, dynamic> payerItemMap = {};

  Map<String, String> itemAmtMap = modelOutput['price_list'];

  // calculate the split amount for each item = item price / no. of payer for that item
  // {'Prawns': 4.00, 'Chicken': 5.17, ...}
  Map<String, double> itemSplitAmtMap = {};
  itemAmtMap.forEach((item, amt) => itemSplitAmtMap[item] = double.parse(
      (double.parse(amt) / itemPayerMap[item].length)
          .toStringAsFixed(2)));

  // for each item, then for each payer, accumulate the amount owed
  itemPayerMap.forEach((item, payerList) => payerList.forEach(
      (payer) => payerAmountMap[payer] = payerAmountMap.containsKey(payer)
          ? payerAmountMap[payer] += itemSplitAmtMap[item]
          : itemSplitAmtMap[item]));

  // format the doubles nicely
  payerAmountMap.forEach((payer, amt) =>
      payerAmountMap[payer] = double.parse(amt.toStringAsFixed(2)));

  // for each item, then for each payer, accumulate the item they paid for
  itemPayerMap.forEach((item, payerList) => payerList.forEach(
      (payer) => payerItemMap.containsKey(payer)
          ? payerItemMap[payer].add(item)
          : payerItemMap[payer] = [item]));

  print(payerAmountMap);
  print(payerItemMap);

  var a = {'payerAmountMap': payerAmountMap, 'payerItemMap': payerItemMap};
  print(a);
  return {'payerAmountMap': payerAmountMap, 'payerItemMap': payerItemMap};
}
}