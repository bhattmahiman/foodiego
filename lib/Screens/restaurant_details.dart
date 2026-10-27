
import 'package:flutter/material.dart';
import 'package:foodiego/Screens/food_details.dart';
import 'package:foodiego/models/cart_model.dart';

class RestaurantDetails extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantDetails({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  int _selectedTab = 0;
  bool _isFavorite = false;

  List<Map<String, dynamic>> get _menuItems {
    final menu = widget.restaurant["menu"];

    debugPrint("Restaurant: ${widget.restaurant["name"]}");
    debugPrint("Menu data: $menu");

    if (menu == null || menu is! List) {
      return [];
    }

    return menu
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
  }


  String _getMenuHeading() {
    final category =
    (widget.restaurant["category"] as String? ?? "").toLowerCase();

    if (category.contains("burger")) return "Burgers";
    if (category.contains("pizza")) return "Pizzas";
    if (category.contains("chinese") || category.contains("asian")) {
      return "Chinese Dishes";
    }
    if (category.contains("indian")) return "Indian Dishes";
    if (category.contains("dessert") || category.contains("beverage")) {
      return "Desserts & Beverages";
    }

    return "Menu";
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = widget.restaurant;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F8),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant hero image
                  Stack(
                    children: [
                      Image.network(
                        restaurant["image"] ?? "",
                        height: 260,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 260,
                          color: const Color(0xFFFFDBD1),
                          child: const Center(
                            child: Icon(
                              Icons.restaurant,
                              size: 65,
                              color: Color(0xFFD94005),
                            ),
                          ),
                        ),
                      ),

                      // Dark gradient over the image
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black45,
                                Colors.transparent,
                                Colors.black12,
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 45,
                        left: 16,
                        child: _roundButton(
                          icon: Icons.arrow_back,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),

                      Positioned(
                        top: 45,
                        right: 16,
                        child: _roundButton(
                          icon: _isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          iconColor:
                          _isFavorite ? Colors.red : Colors.white,
                          onTap: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  // Main rounded restaurant panel
                  Transform.translate(
                    offset: const Offset(0, -18),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16, 14, 16, 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name and rating
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        restaurant["name"] ?? "Restaurant",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF202633),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE5F5E9),
                                        borderRadius:
                                        BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xFF168447),
                                            size: 14,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            "${restaurant["ratings"] ?? "4.5"}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // Category and delivery time
                                Wrap(
                                  crossAxisAlignment:
                                  WrapCrossAlignment.center,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      restaurant["category"] ?? "Food",
                                      style: const TextStyle(
                                        color: Color(0xFF78818D),
                                        fontSize: 11,
                                      ),
                                    ),
                                    const Text(
                                      "•",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      restaurant["time"] ?? "30–35 min",
                                      style: const TextStyle(
                                        color: Color(0xFF78818D),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 15),

                                // Service information badges
                                Row(
                                  children: [
                                    Expanded(
                                      child: _infoBadge(
                                        Icons.shopping_bag_outlined,
                                        "₹200 for two",
                                      ),
                                    ),
                                    const SizedBox(width: 7),
                                    Expanded(
                                      child: _infoBadge(
                                        Icons.eco_outlined,
                                        "Pure Veg",
                                        color: const Color(0xFF279653),
                                      ),
                                    ),
                                    const SizedBox(width: 7),
                                    Expanded(
                                      child: _infoBadge(
                                        Icons.delivery_dining,
                                        "Free Delivery",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Menu / Reviews / Info tabs
                          Row(
                            children: [
                              _tabButton("Menu", 0),
                              _tabButton("Reviews", 1),
                              _tabButton("Info", 2),
                            ],
                          ),

                          const Divider(
                            height: 1,
                            color: Color(0xFFF0F0F0),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16, 16, 16, 20,
                            ),
                            child: _buildTabContent(),
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
    );
  }

  Widget _roundButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
  }) {
    return Material(
      color: Colors.black26,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: iconColor, size: 23),
      ),
    );
  }

  Widget _infoBadge(
      IconData icon,
      String text, {
        Color color = const Color(0xFF64748B),
      }) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE9EDF1)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF606B79),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String title, int index) {
    final selected = _selectedTab == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected
                    ? const Color(0xFFFF5722)
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight:
              selected ? FontWeight.bold : FontWeight.w500,
              color: selected
                  ? const Color(0xFFFF5722)
                  : const Color(0xFF647080),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    if (_selectedTab == 1) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Reviews",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Customers' reviews will appear here.",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );
    }

    if (_selectedTab == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Restaurant Information",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text("Name: ${widget.restaurant["name"] ?? "Restaurant"}"),
          const SizedBox(height: 8),
          Text("Category: ${widget.restaurant["category"] ?? "Food"}"),
          const SizedBox(height: 8),
          Text("Delivery time: ${widget.restaurant["time"] ?? "N/A"}"),
        ],
      );
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getMenuHeading(),
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF202633),
          ),
        ),
        const SizedBox(height: 10),

        if (_menuItems.isEmpty)
          const Text(
            "No menu items available yet.",
            style: TextStyle(color: Colors.grey),
          )
        else
          ..._menuItems.map((item) => _menuCard(item)),
      ],
    );
  }

  Widget _menuCard(Map<String, dynamic> item) {
    return InkWell(
      borderRadius: BorderRadius.circular(13),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetails(
              food: item,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFF0F0F0)),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.network(
                item["image"] as String,
                width: 54,
                height: 54,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 54,
                  height: 54,
                  color: const Color(0xFFFFDBD1),
                  child: const Icon(
                    Icons.fastfood,
                    color: Color(0xFFD94005),
                  ),
                ),
              ),
            ),
      
            const SizedBox(width: 9),
      
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item["description"] as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF7D8793),
                    ),
                  ),
                ],
              ),
            ),
      
            const SizedBox(width: 6),
      
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "₹${item["price"]}",
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                SizedBox(
                  height: 29,
                  child: ElevatedButton(
                    onPressed: () {
                      CartModel.instance.addItem(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${item["name"]} selected"),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF641F),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
