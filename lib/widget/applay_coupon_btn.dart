import 'package:flutter/material.dart';

class ApplyCouponButton extends StatelessWidget {
  final Function() onPressed;

  const ApplyCouponButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF9b59b6),
        elevation: 2,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      child: const Text('Apply'),
    );
  }
}
