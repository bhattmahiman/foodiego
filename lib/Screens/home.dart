import 'package:flutter/material.dart';
import 'package:foodiego/Screens/cart.dart';
import 'package:foodiego/Screens/explore.dart';
import 'package:foodiego/Screens/profile.dart';
import 'package:foodiego/widgets/floating_cart_button.dart';
import 'package:foodiego/widgets/restaurant_card.dart';
import 'package:foodiego/widgets/food_banner_carousel.dart';
import 'package:foodiego/data/restaurant_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  List<Map<String,dynamic>> categoryList =[
    {
      "name": "Burger",
      "image": "assets/images/burger.png"
    },
    {
      "name":"Pizza",
      "image":"assets/images/pizza.png"
    },
    {
      "name":"Chinese",
      "image":"assets/images/noodles.png"
    },
    {
      "name":"Indian",
      "image":"assets/images/indian.jpg"
    },
    {
      "name":"Desserts",
      "image":"assets/images/desserts.jpg"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange[100],
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFFDBD1),
                                borderRadius: BorderRadius.circular(30)
                            ),
            
                            child: Icon(Icons.fastfood,color: const Color(0xFFD94005),),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Home",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,color: const Color(0xFFD94005),size: 20,),
                                  Text('Deliver To Downtown',style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.notifications_none_outlined),
                          SizedBox(width: 20,),
                          CircleAvatar(
                            backgroundColor: const Color(0xFFD94005),
                            child: Icon(Icons.person_outlined,color: Colors.white,),
                          )
                        ],
                      )
                    ],
                  ),
            
                  SizedBox(height: 20,),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFDBD1),
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: Icon(Icons.location_on,color: const Color(0xFFD94005),),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Deliver to",style: TextStyle(fontWeight: FontWeight.w500),),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Ahmedabad, Gujarat",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 22,
                                    color: Colors.black,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 23,
                              backgroundColor: const Color(0xFFFFDBD1),
                              child: Icon(Icons.person_outlined,color: const Color(0xFFD94005),),
                            ),
            
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade700,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  SearchBar(
                    hintText: "Search for food, restaurants...",
                    hintStyle: const WidgetStatePropertyAll(
                      TextStyle(
                        color: Color(0xFFB0A09A),
                        fontSize: 18,
                      ),
                    ),
                    backgroundColor: const WidgetStatePropertyAll(
                      Colors.white,
                    ),
                    elevation: const WidgetStatePropertyAll(0),
                    shadowColor: const WidgetStatePropertyAll(
                      Colors.transparent,
                    ),
                    shape: const WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                    ),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 20),
                    ),
                    leading: const Icon(
                      Icons.search,
                      color: Color(0xFF987C70),
                      size: 26,
                    ),
                    trailing: const [
                      Icon(
                        Icons.mic,
                        color: Color(0xFF603D2F),
                        size: 24,
                      ),
                    ],
                  ),
            
                  SizedBox(height: 20,),
            
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FoodBannerCarousel(),
                  ),
            
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: categoryList.map((category) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xFFFFDBD1),
                            radius: 30,
                            child: ClipOval(
                              child: Image.asset(
                                category["image"],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.fastfood);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(category["name"]),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Popular Restaurants",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Explore(),
                                ),
                              );
                            },
                            child: const Text("See All"),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        height: 250,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: restaurantDetails.length,
                          separatorBuilder: (context, index) =>
                          const SizedBox(width: 14),
                          itemBuilder: (context, index) {
                            final restaurant = restaurantDetails[index];

                            return SizedBox(
                              width: 200,
                              child: RestaurantCard(
                                name: restaurant['name'] as String,
                                category: restaurant['category'] as String,
                                rating: restaurant['ratings'] as String,
                                deliveryTime: restaurant['time'] as String,
                                image: restaurant['image'] as String,
                                restaurant: restaurant,
                              ),
                            );
                          },
                        ),
                      ),

                      // Space after the restaurant cards
                      const SizedBox(height: 30),
                    ],
                  ),
            
                ],
              ),
            ),
          )
      ),

    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    const HomePage(),
    Explore(),
    Cart(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

      floatingActionButton: const FloatingCartButton(),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFD94005),
        unselectedItemColor: const Color(0xFF999999),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


