import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(10.0),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.toggleFavorite();
              },
              icon: product.isFavorite
                  ? Icon(Icons.favorite, color: Colors.red.shade700)
                  : Icon(Icons.favorite_border_outlined),
            ),
          ),
          title: Text(product.title, textAlign: TextAlign.center),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(
                CartItem(
                  id: DateTime.now().toString(),
                  productId: product.id,
                  name: product.title,
                  quantity: '1',
                  price: product.price.toStringAsFixed(2),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${product.title} adicionado ao carrinho!',
                    textAlign: TextAlign.center,
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
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
