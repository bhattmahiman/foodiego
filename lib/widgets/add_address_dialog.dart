import 'package:flutter/material.dart';

/// Dialog that owns its text controllers and disposes them only after the
/// dialog has been fully removed from the widget tree.
class AddAddressDialog extends StatefulWidget {
  const AddAddressDialog({super.key});

  @override
  State<AddAddressDialog> createState() => _AddAddressDialogState();
}

class _AddAddressDialogState extends State<AddAddressDialog> {
  static const Color _orange = Color(0xFFFF641F);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final List<Map<String, dynamic>> _quickLabels = const [
    {'label': 'Home', 'icon': Icons.home_outlined},
    {'label': 'Work', 'icon': Icons.work_outline},
    {'label': 'Other', 'icon': Icons.location_on_outlined},
  ];

  String? _nameError;
  String? _addressError;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    final address = _addressController.text.trim();

    setState(() {
      _nameError = name.isEmpty ? 'Please enter an address name' : null;
      _addressError = address.isEmpty ? 'Please enter the full address' : null;
    });

    if (name.isEmpty || address.isEmpty) return;

    Navigator.pop(context, {'name': name, 'details': address});
  }

  InputDecoration _fieldDecoration({
    required String label,
    required String hint,
    required IconData icon,
    String? error,
  }) {
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color, width: width),
        );

    return InputDecoration(
      labelText: label,
      hintText: hint,
      errorText: error,
      prefixIcon: Icon(icon, size: 20, color: const Color(0xFF77818D)),
      filled: true,
      fillColor: const Color(0xFFF6F7F9),
      labelStyle: const TextStyle(fontSize: 13, color: Color(0xFF77818D)),
      hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFA5ADB7)),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: border(const Color(0xFFE9EDF1)),
      focusedBorder: border(_orange, 1.5),
      errorBorder: border(Colors.red.shade400),
      focusedErrorBorder: border(Colors.red.shade400, 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: _orange.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add_location_alt_outlined,
                    color: _orange,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Delivery Address',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF303846),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Where should we deliver your order?',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF77818D),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.close, size: 20, color: Color(0xFF77818D)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Quick label chips
            Wrap(
              spacing: 8,
              children: _quickLabels.map((item) {
                final label = item['label'] as String;
                final selected = _nameController.text.trim() == label;
                return ChoiceChip(
                  avatar: Icon(
                    item['icon'] as IconData,
                    size: 16,
                    color: selected ? Colors.white : const Color(0xFF657080),
                  ),
                  label: Text(label),
                  selected: selected,
                  showCheckmark: false,
                  selectedColor: _orange,
                  backgroundColor: const Color(0xFFF6F7F9),
                  side: BorderSide(
                    color: selected ? _orange : const Color(0xFFE9EDF1),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : const Color(0xFF465160),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSelected: (_) {
                    setState(() {
                      _nameController.text = label;
                      _nameError = null;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 14),

            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              onChanged: (_) => setState(() => _nameError = null),
              decoration: _fieldDecoration(
                label: 'Address name',
                hint: 'Home, Work, etc.',
                icon: Icons.label_outline,
                error: _nameError,
              ),
            ),

            const SizedBox(height: 14),

            TextField(
              controller: _addressController,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) => setState(() => _addressError = null),
              decoration: _fieldDecoration(
                label: 'Full address',
                hint: 'House no., street, area, city, pincode',
                icon: Icons.location_on_outlined,
                error: _addressError,
              ),
            ),

            const SizedBox(height: 22),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF465160),
                      side: const BorderSide(color: Color(0xFFE0E4E9)),
                      minimumSize: const Size.fromHeight(46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _orange,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size.fromHeight(46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Save Address',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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