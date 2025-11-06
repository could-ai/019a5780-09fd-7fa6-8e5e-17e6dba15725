import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final bool isActive;
  final VoidCallback onToggle;
  final VoidCallback onReset;

  const ControlButtons({
    super.key,
    required this.isActive,
    required this.onToggle,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildButton(
              label: isActive ? 'DEACTIVATE' : 'ACTIVATE',
              icon: isActive ? Icons.pause_circle_outline : Icons.play_circle_outline,
              color: isActive ? const Color(0xFFFF3366) : const Color(0xFF00FF88),
              onPressed: onToggle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildButton(
              label: 'RESET',
              icon: Icons.refresh,
              color: const Color(0xFF00D9FF),
              onPressed: onReset,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
