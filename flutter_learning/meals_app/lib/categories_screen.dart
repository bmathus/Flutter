import 'package:flutter/material.dart';

import './dummy_data.dart';
import './category_item.dart';

class CateforiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DeliMeals"),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          // class ktora nam umožni zadať max width tych jednotlivých itemov v gride a podla toho vie vytvoriť požadovany počet riadkov tak aby sa všetky itemy zmestili
          childAspectRatio: 3 / 2,
          // definujeme ako maju byť itemy velka vzdhladom na hight a width
          crossAxisSpacing: 20, //aky je spacing medzi collumns a rows
          mainAxisSpacing: 20,
        ),
        children: dummyCategories.map((catData) {
          return CategoryItem(
            catData.title,
            catData.color,
          );
        }).toList(),
      ),
    );
  }
}
