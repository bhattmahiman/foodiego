import 'package:flutter/material.dart';
import 'package:foodiego/models/cart_model.dart';
import 'package:foodiego/Screens/successful_order.dart';
import 'package:foodiego/widgets/add_address_dialog.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final CartModel _cart = CartModel.instance;

  String _selectedPayment = 'UPI';
  String _selectedAddress = 'Home';
  String _addressDetails = 'B-12, Shanti Nagar, Ahmedabad\nGujarat - 380015';

  final List<Map<String, String>> _addresses = [
    {
      'name': 'Home',
      'details': 'B-12, Shanti Nagar, Ahmedabad\nGujarat - 380015',
    },
  ];

  Future<void> _addAddress() async {
    // The dialog owns and disposes its own controllers (see AddAddressDialog).
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (_) => const AddAddressDialog(),
    );

    if (!mounted || result == null) return;

    setState(() {
      _addresses.add(result);
      _selectedAddress = result['name']!;
      _addressDetails = result['details']!;
    });
  }

  Future<void> _chooseAddress() async {
    final selected = await showModalBottomSheet<Map<String, String>>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Delivery Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ..._addresses.map(
                    (address) => ListTile(
                  leading: const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFFD94005),
                  ),
                  title: Text(address['name']!),
                  subtitle: Text(address['details']!),
                  onTap: () => Navigator.pop(sheetContext, address),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Add New Address'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _addAddress();
                },
              ),
            ],
          ),
        ),
      ),
    );

    if (!mounted || selected == null) return;

    setState(() {
      _selectedAddress = selected['name']!;
      _addressDetails = selected['details']!;
    });
  }

  void _placeOrder() {
    if (_cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your cart is empty.')),
      );
      return;
    }

    final orderId =
        'FG${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessfulOrder(
          orderId: orderId,
          estimatedDelivery: '25–30 min',
        ),
      ),
    );

    // Clear the cart after capturing the order details.
    _cart.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _cart,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFFAFAFA),
          body: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new, size: 19),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 40,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    children: [
                      // Delivery address
                      const Text(
                        'Delivery Address',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF303846),
                        ),
                      ),
                      const SizedBox(height: 10),

                      InkWell(
                        onTap: _chooseAddress,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: _cardDecoration(),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 23,
                                color: Color(0xFF657080),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _selectedAddress,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _addressDetails,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        height: 1.4,
                                        color: Color(0xFF77818D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Color(0xFF77818D),
                              ),
                            ],
                          ),
                        ),
                      ),

                      TextButton.icon(
                        onPressed: _addAddress,
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          foregroundColor: const Color(0xFF465160),
                        ),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text(
                          'Add New Address',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),

                      const Divider(height: 20),

                      // Payment method
                      const Text(
                        'Payment Method',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF303846),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: _cardDecoration(),
                        child: Column(
                          children: [
                            _paymentOption(
                              title: 'UPI (PhonePe, GPay, Paytm)',
                              value: 'UPI',
                              icon: Icons.account_balance_wallet_outlined,
                            ),
                            _paymentOption(
                              title: 'Cards (Credit / Debit)',
                              value: 'Card',
                              icon: Icons.credit_card,
                            ),
                            _paymentOption(
                              title: 'Cash on Delivery',
                              value: 'Cash on Delivery',
                              icon: Icons.money,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 22),

                      // Dynamic order summary
                      const Text(
                        'Order Summary',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF303846),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: _cardDecoration(),
                        child: Column(
                          children: [
                            _summaryRow('Item Total', _cart.itemTotal),
                            const SizedBox(height: 10),
                            _summaryRow('Delivery Fee', _cart.deliveryFee),
                            const SizedBox(height: 10),
                            _summaryRow('Platform Fee', _cart.platformFee),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Divider(height: 1),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  '₹${_cart.total}',
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

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 49,
                        child: ElevatedButton(
                          onPressed: _cart.items.isEmpty ? null : _placeOrder,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF641F),
                            disabledBackgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Place Order',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _paymentOption({
    required String title,
    required String value,
    required IconData icon,
  }) {
    final selected = _selectedPayment == value;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedPayment = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 20,
              color: selected
                  ? const Color(0xFFFF641F)
                  : const Color(0xFF9AA3AE),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF596474),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String title, int amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
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

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE9EDF1)),
    );
  }
}