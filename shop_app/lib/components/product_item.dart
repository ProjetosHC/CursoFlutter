import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(10.0),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            onPressed: () {},
            icon: product.isFavorite
                ? Icon(Icons.favorite, color: Colors.red.shade900)
                : Icon(Icons.favorite_border_outlined),
          ),
          title: Text(product.title, textAlign: TextAlign.center),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_checkout_sharp),
          ),
        ),
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.productDetails,
            arguments: product,
          ),
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
