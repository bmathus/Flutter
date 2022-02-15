// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/widgets/adaptive_text_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() {
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  var selectedDate;

  //vykona sa nazačiatku ked sa vytvori widget a jeho state potom ked sa už widget znovu builduje/vytvara tak sa state nemeni čiže sa nevykonava už ani initState-vykona sa len raz pri prvotno vytvoreni widgetu respektivne stavu
  @override
  void initState() {
    //použiva sa na vlastnu inicializaciu napr http request na nacitanie nejakych dat zo servera alebo z databazy
    //nezalezi ci vlastny kod piseme za super.initstate alebo pred - oficialne je recomenned za tým ale je to jedno
    super.initState(); // zavola sa aj parentova initState teda classy State
  }

  //zavala sa ked widget ktory bol atachnuty k stavu sa zmeni - respektivne ked stary objekt vydgetu je vymeneny za novy objekt toho isteho widgetu pri vykonani build() jeho parenta
  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    //argument je predchadzujuci widget ktory bol atatched to state aby si ho vedel porovnať napr s aktualnym
    //k aktualnemu pristupis pomocou widget.
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  //vykona sa ked sa vydget už nieje na obrazovke - nie ked sa rebuilduje ale ked celkovo sa zavrie/odstrani/vymaze z obrazovky teda ked aj jeho state sa vymaže
  //- teda ked element objekt,state objekt aj render objekt toho widgetu sa vymaze
  @override
  void dispose() {
    // TODO: implement dispose
    //pouziva sa napr na ukončenie spojenia so serverom ked tento widget je vymazany
    super.dispose();
  }

  void submit() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }
    //widget je specialna property pomocou ktorej vieme pristupovať k properties
    //ktore mame v stateful widget s ktorou je tato state class prepojena
    widget.addNewTransaction(enteredTitle, enteredAmount, selectedDate);

    //zavretie toho bottom sheet ked submitneme inputy
    //zavrie to ten top most context vlastne
    //context je specialna property ktory je awailable celej state class
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      //pomocou then poskytneme future objektu funckiu ktora sa vykona ked user vyberie datum a potvrdi ho
      if (pickedDate == null) {
        //user dal cancel
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
                onSubmitted: (_) => submit(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submit(),
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate == null
                          ? "No Date Chosen!"
                          : "Picked date: ${DateFormat.yMd().format(selectedDate)}"),
                    ),
                    AdaptiveTextButton(
                        text: "Choose Date", handler: _presentDatePicker)
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => submit(),
                child: Text("Add Transaction"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
