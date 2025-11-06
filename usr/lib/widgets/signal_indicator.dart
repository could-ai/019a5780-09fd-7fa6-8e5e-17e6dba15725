import 'package:flutter/material.dart';

class SignalIndicator extends StatelessWidget {
  final double strength;

  const SignalIndicator({super.key, required this.strength});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F3A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00D9FF).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.signal_cellular_alt,
            color: _getSignalColor(),
            size: 20,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Signal',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              Text(
                '${strength.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _getSignalColor(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getSignalColor() {
    if (strength >= 70) {
      return const Color(0xFF00FF88);
    } else if (strength >= 40) {
      return const Color(0xFFFFAA00);
    } else {
      return const Color(0xFFFF3366);
    }
  }
}
