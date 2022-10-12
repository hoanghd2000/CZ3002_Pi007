import 'package:charts_flutter/flutter.dart';
import 'package:pi_007/databases/db_transactions.dart';

class spendingsChart extends StatelessWidget {

  final DbTrans_Manager dbmanager = new DbTrans_Manager();


  FutureBuilder(
          future: dbmanager.getTransactionByYear(),
          builder: (BuildContext context,
                AsyncSnapshot<List<Transaction>> snapshot) {
              if (snapshot.hasData) {
                txnData = snapshot.data;
                List<charts.Series<Transaction, String>> series = [
                charts.Series(
                  id: "Spendings",
                  data: txnData
                  domainFn: (Transaction txn, _) => series.timestamp,
                  measureFn: (Transaction txn, _) => series.amount,
                  colorFn: (Transaction txn, _) => series.barColor
                )
              ];

                return Container(
                  height: 400,
                  padding: EdgeInserts.all(20),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column
                    )
                  )
                  },
                );
              } else {
                return const Center(
                  child: Text("No data found."),
                );
              }
            },
          )
        )
        
            
         
          
        return charts.BarChart(series, animate: true);
        
}

