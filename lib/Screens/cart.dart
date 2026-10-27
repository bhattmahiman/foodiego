
import 'package:flutter/material.dart';
import 'package:foodiego/models/cart_model.dart';
import 'package:foodiego/Screens/checkout.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartModel.instance;

    return AnimatedBuilder(
      animation: cart,
      builder: (context, child) {
        final items = cart.items;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          body: SafeArea(
            child: Column(
              children: [
                // Header
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 18, 20, 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 23,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'My Cart',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                if (items.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 75,
                            color: Color(0xFFD5D5D5),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Your cart is empty',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Explore restaurants and add your favourite food.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                else ...[
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      children: [
                        ...List.generate(items.length, (index) {
                          final item = items[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFF0F0F0),
                              ),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    item['image'] as String,
                                    width: 65,
                                    height: 65,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        Container(
                                          width: 65,
                                          height: 65,
                                          color: const Color(0xFFFFDBD1),
                                          child: const Icon(
                                            Icons.fastfood,
                                            color: Color(0xFFD94005),
                                          ),
                                        ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'] as String,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '₹${item['price']}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if ((item['instructions'] as String)
                                          .isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          item['instructions'] as String,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                      const SizedBox(height: 8),

                                      // Quantity selector
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFFEAEAEA),
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(18),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _quantityButton(
                                              Icons.remove,
                                                  () => cart.updateQuantity(
                                                index,
                                                (item['quantity'] as int) - 1,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 28,
                                              child: Text(
                                                '${item['quantity']}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            _quantityButton(
                                              Icons.add,
                                                  () => cart.updateQuantity(
                                                index,
                                                (item['quantity'] as int) + 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                IconButton(
                                  onPressed: () => cart.removeItem(index),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Color(0xFFD98484),
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 6),

                        // Bill summary
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F1F3),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              _billRow('Item Total', cart.itemTotal),
                              const SizedBox(height: 9),
                              _billRow('Delivery Fee', cart.deliveryFee),
                              const SizedBox(height: 9),
                              _billRow('Platform Fee', cart.platformFee),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(height: 1),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    '₹${cart.total}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),

                  // Checkout button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 49,
                      child: ElevatedButton(
                        onPressed: cart.items.isEmpty
                            ? null
                            : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Checkout(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF641F),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        child: Text(
                          'Proceed to Checkout  ·  ₹${cart.total}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _quantityButton(
      IconData icon,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: 29,
        height: 29,
        child: Icon(icon, size: 14),
      ),
    );
  }

  static Widget _billRow(String label, int amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF77818D),
          ),
        ),
        Text(
          '₹$amount',
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF465160),
          ),
        ),
      ],
    );
  }
}
