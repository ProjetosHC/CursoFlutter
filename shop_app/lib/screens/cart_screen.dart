import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: cart.itemCount == 0
              ? Text(
                  'Carrinho vazio',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
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
                            //backgroundColor: Colors.transparent,
                            //textStyle: TextStyle(fontSize: 16.0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            side: BorderSide(color: Colors.white, width: 1.0),
                          ),
                          onPressed: () {
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
                          child: Text("Limpar".toUpperCase()),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.itemCount,
                        itemBuilder: (ctx, index) {
                          final item = cart.items.values.toList()[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Chip(
                              label: ListTile(
                                leading: CircleAvatar(
                                  child: Text(
                                    item.productId.toUpperCase(),
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodySmall?.color,
                                    ),
                                  ),
                                ),
                                title: Text(item.name),
                                subtitle: Text(
                                  'Quantidade: ${item.quantity}',
                                ),
                                trailing: Text(
                                  'Subtotal: R\$ ${cart.getItemSubtotal(item.productId).replaceAll('.', ',')}',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50.0,
        width: 100.0,
        child: FloatingActionButton.extended(
          onPressed: () {
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
          label: Text(
            'Comprar'.toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.white, width: 1.0),
          ),
        ),
      ),
    );
  }
}
