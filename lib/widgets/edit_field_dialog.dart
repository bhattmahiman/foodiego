import 'package:flutter/material.dart';

/// Reusable dialog (same look as AddAddressDialog) for editing a single
/// profile field such as name or email. Pops with the new trimmed value.
class EditFieldDialog extends StatefulWidget {
  final String title; // e.g. "Name" or "Email"
  final String subtitle;
  final String initialValue;
  final IconData icon;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  /// Return an error message, or null if the value is valid.
  final String? Function(String value)? validator;

  const EditFieldDialog({
    super.key,
    required this.title,
    required this.initialValue,
    required this.icon,
    this.subtitle = '',
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
  });

  @override
  State<EditFieldDialog> createState() => _EditFieldDialogState();
}

class _EditFieldDialogState extends State<EditFieldDialog> {
  static const Color _orange = Color(0xFFFF641F);

  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final value = _controller.text.trim();

    String? error;
    if (value.isEmpty) {
      error = 'Please enter your ${widget.title.toLowerCase()}';
    } else {
      error = widget.validator?.call(value);
    }

    if (error != null) {
      setState(() => _error = error);
      return;
    }

    Navigator.pop(context, value);
  }

  OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
                  child: Icon(widget.icon, color: _orange, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Change ${widget.title}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF303846),
                        ),
                      ),
                      if (widget.subtitle.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          widget.subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF77818D),
                          ),
                        ),
                      ],
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

            TextField(
              controller: _controller,
              autofocus: true,
              keyboardType: widget.keyboardType,
              textCapitalization: widget.textCapitalization,
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
              onSubmitted: (_) => _save(),
              decoration: InputDecoration(
                labelText: widget.title,
                errorText: _error,
                prefixIcon: Icon(widget.icon,
                    size: 20, color: const Color(0xFF77818D)),
                filled: true,
                fillColor: const Color(0xFFF6F7F9),
                labelStyle:
                const TextStyle(fontSize: 13, color: Color(0xFF77818D)),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                enabledBorder: _border(const Color(0xFFE9EDF1)),
                focusedBorder: _border(_orange, 1.5),
                errorBorder: _border(Colors.red.shade400),
                focusedErrorBorder: _border(Colors.red.shade400, 1.5),
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
                      'Save',
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