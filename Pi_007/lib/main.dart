
import 'package:flutter/material.dart';
import 'package:pi_007/page/budget_page.dart';
import 'package:pi_007/page/more_page.dart';
import 'package:pi_007/page/report_page.dart';
import 'package:pi_007/page/splitbill_page.dart';
import 'package:pi_007/page/transactions_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  static const main_section =  Color(0xFFC9C5F9);   //purple
  static const action_button =  Color(0xFFF8C8DC);  //pink
  static const confirm_button =  Color(0xFFB4ECB4); //green
  static const secondary_section =  Color(0xFFC5E0F9); //blue
  static const list_color =  Color(0xFFECECEC);  //grey

  int index = 0;

  final screens = [
    TransactionsPage(),
    ReportPage(),
    SplitBillPage(),
    BudgetPage(),
    MorePage(),
    // Center(child:Text('Transactions'),),
    // Center(child:Text('Report'),),
    // Center(child:Text('Split Bill'),),
    // Center(child:Text('Budget'),),
    // Center(child:Text('More'),),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: navigation_bar,
      title: Text("Pi_007", style: TextStyle(color: Colors.black)),
    ),
    body: screens[index],
    bottomNavigationBar: NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.black12,
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
        ),
      ),
      child: NavigationBar(
        height: 70,
        backgroundColor:Color(0xFFFFEAD1),
        selectedIndex: index,
        onDestinationSelected: (index) =>
            setState(() => this.index = index),
        destinations: [
          NavigationDestination(
              icon:Icon(Icons.article_outlined),
              selectedIcon: Icon(Icons.article),
              label: 'Transactions'
          ),
          NavigationDestination(
              icon:Icon(Icons.insights_outlined),
              selectedIcon: Icon(Icons.insights),
              label: 'Report'
          ),
          NavigationDestination(
              icon:Icon(Icons.monetization_on_outlined),
              selectedIcon: Icon(Icons.monetization_on),
              label: 'Split Bill'
          ),
          NavigationDestination(
              icon:Icon(Icons.savings_outlined),
              selectedIcon: Icon(Icons.savings),
              label: 'Budget'
          ),
          NavigationDestination(
              icon:Icon(Icons.more_horiz_outlined),
              selectedIcon: Icon(Icons.more_horiz),
              label: 'More'
          )
        ],
      ),
    ),
  );
}
