class WaterLog {
  final String id;
  final DateTime date;
  final int amount; // in milliliters
  final DateTime timestamp;

  WaterLog({
    required this.id,
    required this.date,
    required this.amount,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory WaterLog.fromJson(Map<String, dynamic> json) {
    return WaterLog(
      id: json['id'],
      date: DateTime.parse(json['date']),
      amount: json['amount'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
