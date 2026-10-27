
import 'package:flutter/material.dart';
import 'package:foodiego/Screens/home.dart';

class SuccessfulOrder extends StatelessWidget {
  final String orderId;
  final String estimatedDelivery;

  const SuccessfulOrder({
    super.key,
    required this.orderId,
    this.estimatedDelivery = '25–30 min',
  });

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFFF641F);
    const dark = Color(0xFF202633);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFEFB),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 25, 16, 12),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        // Success icon and celebration
                        SizedBox(
                          width: 190,
                          height: 125,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ...List.generate(12, (index) {
                                final angle = index * 30.0;
                                return Transform.rotate(
                                  angle: angle * 3.1415926535 / 180,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Container(
                                        width: 4,
                                        height: 9,
                                        decoration: BoxDecoration(
                                          color: [
                                            orange,
                                            const Color(0xFF69B96E),
                                            const Color(0xFFFFCF58),
                                            const Color(0xFF69B6E8),
                                          ][index % 4],
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              Container(
                                width: 74,
                                height: 74,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4CAF66),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 55,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 3),

                        const Text(
                          'Order Placed!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: dark,
                          ),
                        ),

                        const SizedBox(height: 7),

                        const Text(
                          'Your delicious food is on the way.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF7B8794),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Rider illustration from assets
                        Image.asset(
                          'assets/images/success_order_rider.png',
                          height: 345,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const SizedBox(
                            height: 145,
                            child: Icon(
                              Icons.delivery_dining,
                              size: 100,
                              color: orange,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Order information card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFFF0F0F0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 12,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order #$orderId',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: dark,
                                ),
                              ),

                              const SizedBox(height: 16),

                              const Text(
                                'Estimated Delivery',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF7B8794),
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                estimatedDelivery,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: dark,
                                ),
                              ),

                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Divider(
                                  height: 1,
                                  color: Color(0xFFF0F0F0),
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Order tracking will be available here.',
                                      ),
                                    ),
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      'Track Order',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: orange,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.chevron_right,
                                      color: orange,
                                      size: 19,
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.chevron_right,
                                      color: orange,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Back to Home
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 49,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
