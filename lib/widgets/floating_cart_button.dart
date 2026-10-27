
import 'package:flutter/material.dart';
import 'package:foodiego/models/cart_model.dart';
import 'package:foodiego/Screens/cart.dart';

class FloatingCartButton extends StatelessWidget {
  const FloatingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartModel.instance;

    return AnimatedBuilder(
      animation: cart,
      builder: (context, child) {
        if (cart.totalQuantity == 0) {
          return const SizedBox.shrink();
        }

        return FloatingActionButton(
          heroTag: 'global_cart_button',
          backgroundColor: const Color(0xFFD94005),
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const Cart(),
              ),
            );
          },
          child: Badge(
            label: Text('${cart.totalQuantity}'),
            child: const Icon(Icons.shopping_cart_outlined),
          ),
        );
      },
    );
  }
}
