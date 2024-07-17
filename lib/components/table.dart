import 'package:baby_shop/ClientSite/product_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Price')),
          DataColumn(label: Text('Image')),
          DataColumn(label: Text('Category')),
          DataColumn(label: Text('Description')),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('1001')),
            DataCell(Text('Pants')),
            DataCell(Text('1000')),
            DataCell(Text('image')),
            DataCell(Text('Clothing')),
            DataCell(Text('iadasamage')),
          ]),
        ],
      ),
    );
  }
}
