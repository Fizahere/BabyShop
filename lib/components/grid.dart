import 'package:baby_shop/ClientSite/product_detail.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      crossAxisCount: 2,
      children: List.generate(9, (index) {
        return GestureDetector(
          onTap:(){
            Navigator.push(context,MaterialPageRoute(builder:(context)=>ProductDetailScreen()));
          },
          child: Column(
            children: [
              Container(
                height: 140,
                width: 140,
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent.shade100,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Clothing',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  Text('\$ 90',style: TextStyle(fontSize: 14,color: Colors.green),),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}