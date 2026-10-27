import 'package:flutter/material.dart';
import 'package:foodiego/Screens/restaurant_details.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String category;
  final String rating;
  final String deliveryTime;
  final String image;
  final Map<String, dynamic> restaurant;

  const RestaurantCard({
    super.key,
    required this.name,
    required this.category,
    required this.rating,
    required this.deliveryTime,
    required this.image,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetails(
              restaurant: restaurant,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    image,
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 95,
                        width: double.infinity,
                        color: Colors.orange.shade100,
                        child: const Center(
                          child: Icon(Icons.fastfood, size: 40),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFB800),
                          size: 14,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          rating,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF242424),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF777777),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 13,
                        color: Color(0xFF8A8A8A),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          deliveryTime,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}