class BotState {
  final bool isActive;
  final double signalStrength;
  final String mode;
  final String connectionStatus;

  BotState({
    required this.isActive,
    required this.signalStrength,
    required this.mode,
    required this.connectionStatus,
  });

  BotState copyWith({
    bool? isActive,
    double? signalStrength,
    String? mode,
    String? connectionStatus,
  }) {
    return BotState(
      isActive: isActive ?? this.isActive,
      signalStrength: signalStrength ?? this.signalStrength,
      mode: mode ?? this.mode,
      connectionStatus: connectionStatus ?? this.connectionStatus,
    );
  }
}
