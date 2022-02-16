import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/services.dart';
import './widgets/transactions_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main(List<String> args) {
  //ak chces nastaviť konkretne orientacie v ktorych sa appka može použivať
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
  //  DeviceOrientation.portraitUp,
  //  DeviceOrientation.portraitDown,
  //]);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
      ),
      title: "appka", //widno ked je appka v backround a pri taskmanagery
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _AppState();
}

class _AppState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> transactions = [
    Transaction(
      id: "t1",
      amount: 69.99,
      title: "New shoes",
      date: DateTime.now(),
    ),
    //Transaction(
    //    id: "t2",
    //    amount: 16.53,
    //    title: "Weekly groceries",
    //    date: DateTime.now())
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(
        this); // vytvorime observer ktory bude vykonavať funckiu didChangeApplifecyclestate vždy ked sa lifecycle state appky zmeni pričom observer je tento objekt classy
    super.initState();
  }

  //metoda ktory sa vykona ked sa zmeni hociaky lifecycle state appky na iny state - pozri aky všetky state može appka mať
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance
        ?.removeObserver(this); // vymažeme listener ked sa state objekt vymaže
    super.dispose();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        amount: amount,
        title: title,
        date: chosenDate);

    setState(() {
      transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void showAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (BuildContext ctxx) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
    //builder ma byt funckia ktora returne widget ktory ma byť v tom botom sheet
    //tej funkcii musime tiez poskytnuť context ktory vytvorila showModalBottomSheet
    //context su nejake metadata toho buildu, neskôr si ukažeme načo to vieme použiť
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar;
    if (Platform.isIOS) {
      appBar = CupertinoNavigationBar(
        middle: Text("Expenses app"),
        //trailing nema bounderies aky može byť velky preto defaultne nevidno middle preto treba row ktori berie infinite width ohraničiť
        trailing: Row(
          mainAxisSize: MainAxisSize
              .min, // row sa shrinkne na velkost ktoru potrebuju deti
          children: [
            //potrebujeme cupertino icon button ale ten nieje tak si spravime vlastny button, lebo material icon button by tu nesiel dať lebo by potreboval parenta aby bol material
            GestureDetector(
              onTap: () => showAddNewTransaction(context),
              child: Icon(CupertinoIcons.add),
            )
          ],
        ),
      );
    } else {
      appBar = AppBar(
        title: Text("Expences app"),
        actions: [
          IconButton(
            onPressed: () => showAddNewTransaction(context),
            icon: Icon(Icons.add),
          )
        ],
      );
    }

    final txListWidget = Container(
      child: TransactionList(transactions, _deleteTransaction),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.75,
    );

    //vsetok content v body pri ios appkach musime dať do safearea aby nazasahoval content do tej časti kde je notch, na androide som si nevšimol že by to malo nejaky efekt
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Show Chart",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (!isLandscape)
              Container(
                child: Chart(_recentTransactions),
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.25,
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      child: Chart(_recentTransactions),
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.75,
                    )
                  : txListWidget
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => showAddNewTransaction(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
