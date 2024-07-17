import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ProductsUsersChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
        future: fetchChartData(),
        builder: (context, AsyncSnapshot<Map<String, List<dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            List<Product> products = snapshot.data!['products'] as List<Product>;
            List<User> users = snapshot.data!['users'] as List<User>;

            // Calculate total counts
            int totalProducts = products.length;
            int totalUsers = users.length;

            // Calculate ratio (just for demonstration, replace with actual meaningful data)
            double productRatio = totalProducts.toDouble();
            double userRatio = totalUsers.toDouble();

            // Build chart series
            List<charts.Series<ChartItem, String>> series = [
              charts.Series(
                id: 'Counts',
                data: [
                  ChartItem('Products', productRatio),
                  ChartItem('Users', userRatio),
                ],
                domainFn: (ChartItem item, _) => item.category,
                measureFn: (ChartItem item, _) => item.value.toInt(),
                colorFn: (ChartItem item, _) => charts.MaterialPalette.blue.shadeDefault,
                labelAccessorFn: (ChartItem item, _) => '${item.value.toInt()}',
              ),
            ];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Dashboard',
                    style: Theme.of(context).textTheme.headline6,
                    // textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30,),
                  SizedBox(
                    height: 250,
                    child: charts.BarChart(
                      series,
                      animate: true,
                      barRendererDecorator: charts.BarLabelDecorator<String>(),
                      domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.SmallTickRendererSpec(labelRotation: 0)),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Text('Failed to fetch data'),
          );
        },
      ),
    );
  }

  Future<Map<String, List<dynamic>>> fetchChartData() async {
    QuerySnapshot productSnapshot = await FirebaseFirestore.instance.collection('Products').get();
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance.collection('userInfo').get();

    List<Product> products = productSnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    List<User> users = userSnapshot.docs.map((doc) => User.fromFirestore(doc)).toList();

    return {'products': products, 'users': users};
  }
}

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Product(
      name: data['Name'] ?? '',
      price: data['Price'] != null ? double.parse(data['Price'].toString()) : 0,
    );
  }
}

class User {
  final String name;
  final String address;

  User({required this.name, required this.address});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return User(
      name: data['Name'] ?? '',
      address: data['Address'] ?? '',
    );
  }
}

class ChartItem {
  final String category;
  final double value;

  ChartItem(this.category, this.value);
}

void main() {
  runApp(MaterialApp(
    home: ProductsUsersChart(),
  ));
}