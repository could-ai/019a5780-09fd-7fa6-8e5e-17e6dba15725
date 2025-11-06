import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../widgets/signal_indicator.dart';
import '../widgets/bot_status_card.dart';
import '../widgets/control_buttons.dart';
import '../models/bot_state.dart';

class QBotScreen extends StatefulWidget {
  const QBotScreen({super.key});

  @override
  State<QBotScreen> createState() => _QBotScreenState();
}

class _QBotScreenState extends State<QBotScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  
  BotState botState = BotState(
    isActive: false,
    signalStrength: 75.0,
    mode: 'Standby',
    connectionStatus: 'Connected',
  );

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void _toggleBot() {
    setState(() {
      botState = botState.copyWith(
        isActive: !botState.isActive,
        mode: !botState.isActive ? 'Active' : 'Standby',
      );
    });
  }

  void _resetBot() {
    setState(() {
      botState = BotState(
        isActive: false,
        signalStrength: 75.0,
        mode: 'Standby',
        connectionStatus: 'Connected',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0A0E27),
              const Color(0xFF1A1F3A),
              const Color(0xFF0A0E27),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Q-bot 2.0',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00D9FF),
                            shadows: [
                              Shadow(
                                color: const Color(0xFF00D9FF).withOpacity(0.5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Advanced AI System',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.6),
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    SignalIndicator(strength: botState.signalStrength),
                  ],
                ),
              ),
              
              // Main Bot Visual
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer rotating ring
                      AnimatedBuilder(
                        animation: _rotationController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _rotationController.value * 2 * math.pi,
                            child: Container(
                              width: 280,
                              height: 280,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF00D9FF).withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: Stack(
                                children: List.generate(8, (index) {
                                  final angle = (index * math.pi * 2) / 8;
                                  return Positioned(
                                    left: 135 + 130 * math.cos(angle),
                                    top: 135 + 130 * math.sin(angle),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF00D9FF),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF00D9FF).withOpacity(0.6),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          );
                        },
                      ),
                      
                      // Pulsing core
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          final scale = 1.0 + (_pulseController.value * 0.1);
                          return Transform.scale(
                            scale: botState.isActive ? scale : 1.0,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    botState.isActive 
                                        ? const Color(0xFF00D9FF)
                                        : const Color(0xFF00D9FF).withOpacity(0.3),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      
                      // Center bot icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF1A1F3A),
                          border: Border.all(
                            color: const Color(0xFF00D9FF),
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00D9FF).withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.smart_toy_outlined,
                          size: 60,
                          color: botState.isActive 
                              ? const Color(0xFF00D9FF)
                              : const Color(0xFF00D9FF).withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Status Card
              BotStatusCard(botState: botState),
              
              // Control Buttons
              ControlButtons(
                isActive: botState.isActive,
                onToggle: _toggleBot,
                onReset: _resetBot,
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
