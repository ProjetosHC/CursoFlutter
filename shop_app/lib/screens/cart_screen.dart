import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/utils/app_routes.dart';

import '../components/cart_product.dart';
import '../models/cart.dart';
import '../models/order_list.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _showConfirmDialog(
    String title,
    BuildContext context,
    String message,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).popAndPushNamed(AppRoutes.homeScreen);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<OrderList>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: LayoutBuilder(
        builder: (ctx, cont) {
          return cart.itemCount == 0
              ? Center(
                  child: Text(
                    'Carrinho vazio',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Chip(
                              label: Text(
                                'Total: R\$ ${cart.totalAmount.replaceAll('.', ',')}'
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.color,
                                ),
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                              onPressed: () {
                                _showConfirmDialog(
                                  'Limpar carrinho',
                                  context,
                                  'Você tem certeza que deseja limpar o carrinho?',
                                  () {
                                    cart.clear();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Carrinho limpo com sucesso!',
                                          textAlign: TextAlign.center,
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text("Limpar".toUpperCase()),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 10, child: CartProduct()),
                    ],
                  ),
                );
        },
      ),
      floatingActionButton: cart.itemCount > 0
          ? FloatingActionButton.extended(
              onPressed: () {
                _showConfirmDialog(
                  "Confirmar compra",
                  context,
                  "Deseja finalizar sua compra?",
                  () {
                    order.addOrder(cart);
                    cart.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Compra realizada com sucesso!',
                          textAlign: TextAlign.center,
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
              label: Text(
                'Comprar'.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.white, width: 1.0),
              ),
            )
          : null,
    );
  }
}
