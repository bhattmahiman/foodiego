
import 'package:flutter/material.dart';
import 'package:foodiego/Screens/restaurant_details.dart';
import 'package:foodiego/data/restaurant_data.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  int _selectedFilter = 0;

  final List<String> _filters = [
    "All",
    "Pure Veg",
    "Fast Food",
    "Chinese",
  ];

  final Set<String> _favorites = {"The Burger House"};

  @override
  Widget build(BuildContext context) {
    final filteredRestaurants = _selectedFilter == 0
        ? restaurantDetails
        : restaurantDetails.where((restaurant) {
      return restaurant["type"] == _filters[_selectedFilter];
    }).toList();

    return Container(
      color: const Color(0xFFF8F8F8),
      child: Column(
        children: [
          // Filter chips
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilter == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.orange
                            : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(_filters[index],style: TextStyle(color: isSelected ? Colors.white : Colors.black,fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal),),
                    ),
                  );
                },
              ),
            ),
          ),

          // Restaurant cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = filteredRestaurants[index];
                final name = restaurant["name"] as String;
                final isFavorite = _favorites.contains(name);

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
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Row(
                      children: [
                        // Restaurant image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            restaurant["image"] as String,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return Container(
                                width: 66,
                                height: 66,
                                color: const Color(0xFFFFDBD1),
                                child: const Icon(
                                  Icons.restaurant,
                                  color: Color(0xFFD94005),
                                ),
                              );
                            },
                          ),
                        ),
                  
                        const SizedBox(width: 12),
                  
                        // Restaurant details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF171717),
                                ),
                              ),
                              const SizedBox(height: 4),
                  
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Color(0xFF16A34A),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    restaurant["ratings"] as String,
                                    style: const TextStyle(
                                      color: Color(0xFF16A34A),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                  
                              const SizedBox(height: 4),
                  
                              Text(
                                restaurant["category"] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF929292),
                                ),
                              ),
                  
                              const SizedBox(height: 3),
                  
                              Text(
                                restaurant["time"] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF929292),
                                ),
                              ),
                            ],
                          ),
                        ),
                  
                        const SizedBox(width: 8),
                  
                        // Favorite button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isFavorite) {
                                _favorites.remove(name);
                              } else {
                                _favorites.add(name);
                              }
                            });
                          },
                          child: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite
                                ? const Color(0xFFFF5722)
                                : const Color(0xFFD5D5D5),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
