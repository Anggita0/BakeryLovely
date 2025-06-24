class Transaction {
  final int? id;
  final int orderId;
  final DateTime date;
  final String status;

  Transaction({
    this.id,
    required this.orderId,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      orderId: map['order_id'],
      date: DateTime.parse(map['date']),
      status: map['status'],
    );
  }
}
