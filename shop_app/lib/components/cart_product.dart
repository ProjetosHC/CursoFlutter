import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final products = cart.items.values.toList();
    return ListView.builder(
      itemCount: cart.itemCount,
      itemBuilder: (ctx, index) {
        final product = products[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: Slidable(
            key: ValueKey(product.id),
            endActionPane: ActionPane(
              extentRatio: 0.35,
              motion: const BehindMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    cart.removeItem(product.productId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${product.name} removido com sucesso!',
                          textAlign: TextAlign.center,
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  backgroundColor: Theme.of(context).colorScheme.error,
                  icon: Icons.delete_sharp,
                  label: 'Excluir',
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
              ],
            ),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 0.0),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    product.productId.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ),
                title: Text(product.name),
                subtitle: Text('Quantidade: ${product.quantity}'),
                trailing: Text(
                  'Subtotal: R\$ ${cart.getItemSubtotal(product.productId).replaceAll('.', ',')}',
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
