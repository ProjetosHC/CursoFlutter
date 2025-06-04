import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Column(
        children: [
          Text("${Decimal.parse("0.1") + Decimal.parse("0.2")}"),
          Text("${0.2+0.1}"),
        ],
      ),
    );
  }
}
