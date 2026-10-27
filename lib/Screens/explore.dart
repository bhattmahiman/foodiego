import 'package:flutter/material.dart';
import 'package:foodiego/widgets/restaurant_list.dart';


class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  // final List<String> _filterList = ["All","Pure Veg","Fast Food","Chinese"];
  // int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 5
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Restaurants",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.search),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(height: 20,),
                Expanded(child: RestaurantList())
              ],
            )
          )
      ),
    );
  }
}
