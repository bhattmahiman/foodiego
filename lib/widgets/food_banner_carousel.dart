import 'package:flutter/material.dart';

class FoodBannerCarousel extends StatefulWidget {
  const FoodBannerCarousel({super.key});

  @override
  State<FoodBannerCarousel> createState() =>
      _FoodBannerCarouselState();
}

class _FoodBannerCarouselState extends State<FoodBannerCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> banners = [
    {
      'title': 'Delicious Food\nAt Your Doorstep',
      'discount': 'Up to 50% OFF',
      'image': 'assets/images/noodles.png',
    },
    {
      'title': 'Fresh & Tasty\nEvery Single Day',
      'discount': 'Up to 40% OFF',
      'image': 'assets/images/burger.png',
    },
    {
      'title': 'Your Favorite Food\nDelivered Fast',
      'discount': 'Up to 30% OFF',
      'image': 'assets/images/pizza.png',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 235,
          child: PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = banners[index];

              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3DE),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Stack(
                  children: [
                    // Food image on the right
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      width: 205,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(28),
                          bottomRight: Radius.circular(28),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              banner['image']!,
                              fit: BoxFit.cover,
                            ),

                            // Black overlay
                            Container(
                              color: Colors.white30,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Text and button on the left
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        26,
                        30,
                        10,
                        30,
                      ),
                      child: SizedBox(
                        width: 240,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              banner['title']!,
                              style: const TextStyle(
                                fontSize: 26,
                                height: 1.15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3B1F14),
                              ),
                            ),

                            const SizedBox(height: 10),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF4A3026),
                                ),
                                children: [
                                  const TextSpan(text: 'Up to '),
                                  TextSpan(
                                    text: banner['discount']!
                                        .replaceFirst('Up to ', ''),
                                    style: const TextStyle(
                                      color: Color(0xFFD94005),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            ElevatedButton(
                              onPressed: () {
                                // Navigate to food or restaurant screen
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color(0xFFD94005),
                                foregroundColor: Colors.white,
                                elevation: 5,
                                shadowColor: const Color(0x55D94005),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Order Now',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward, size: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // Carousel indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
                (index) {
              final isActive = _currentPage == index;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 22 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFD94005)
                      : const Color(0xFFD6C6BC),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}