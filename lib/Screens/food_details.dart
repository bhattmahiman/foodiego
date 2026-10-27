
import 'package:flutter/material.dart';
import 'package:foodiego/models/cart_model.dart';

class FoodDetails extends StatefulWidget {
  final Map<String, dynamic> food;

  const FoodDetails({
    super.key,
    required this.food,
  });

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  int _quantity = 1;
  bool _isFavorite = false;

  final TextEditingController _instructionsController =
  TextEditingController();

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;
    final int price = (food["price"] as num?)?.toInt() ?? 0;
    final int totalPrice = price * _quantity;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Food image with back and favorite buttons
                    Stack(
                      children: [
                        Image.network(
                          food["image"] as String? ?? "",
                          height: 270,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 270,
                            width: double.infinity,
                            color: const Color(0xFFFFDBD1),
                            child: const Icon(
                              Icons.fastfood,
                              size: 70,
                              color: Color(0xFFD94005),
                            ),
                          ),
                        ),

                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.35),
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.08),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 16,
                          left: 16,
                          child: _roundButton(
                            icon: Icons.arrow_back,
                            onTap: () => Navigator.pop(context),
                          ),
                        ),

                        Positioned(
                          top: 16,
                          right: 16,
                          child: _roundButton(
                            icon: _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            onTap: () {
                              setState(() {
                                _isFavorite = !_isFavorite;
                              });
                            },
                            iconColor: _isFavorite
                                ? Colors.red
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),

                    // Rounded food details panel
                    Transform.translate(
                      offset: const Offset(0, -18),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(
                          16, 14, 16, 22,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Food name and rating
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    food["name"] ?? "Food Item",
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF202633),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5F5E9),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 14,
                                        color: Color(0xFF168447),
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        "${food["ratings"] ?? "4.5"}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 5),

                            Text(
                              "₹$price",
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF202633),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              food["description"] ?? "",
                              style: const TextStyle(
                                fontSize: 12,
                                height: 1.5,
                                color: Color(0xFF78818D),
                              ),
                            ),

                            const SizedBox(height: 20),
                            const Divider(
                              color: Color(0xFFF0F0F0),
                            ),

                            // Quantity selector
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Quantity",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF303846),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFEEEEEE),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      _quantityButton(
                                        icon: Icons.remove,
                                        onTap: () {
                                          if (_quantity > 1) {
                                            setState(() {
                                              _quantity--;
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 42,
                                        child: Text(
                                          "$_quantity",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      _quantityButton(
                                        icon: Icons.add,
                                        onTap: () {
                                          setState(() {
                                            _quantity++;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),
                            const Divider(
                              color: Color(0xFFF0F0F0),
                            ),
                            const SizedBox(height: 12),

                            // Additional instructions
                            const Text(
                              "Additional Instructions",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF303846),
                              ),
                            ),

                            const SizedBox(height: 10),

                            TextField(
                              controller: _instructionsController,
                              maxLines: 2,
                              style: const TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                hintText: "Any special request? (optional)",
                                hintStyle: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFFADB5BF),
                                ),
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFD94005),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Add to cart button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  CartModel.instance.addItem(
                                    food,
                                    quantity: _quantity,
                                    instructions: _instructionsController.text.trim(),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${food["name"]} added to cart',
                                      ),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color(0xFFFF641F),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: Text(
                                  "Add to Cart  ·  ₹$totalPrice",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roundButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
  }) {
    return Material(
      color: Colors.black.withOpacity(0.35),
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: iconColor, size: 23),
      ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      color: const Color(0xFF303846),
      constraints: const BoxConstraints(
        minWidth: 38,
        minHeight: 38,
      ),
      padding: EdgeInsets.zero,
    );
  }
}
