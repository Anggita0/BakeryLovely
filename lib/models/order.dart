class Order {
  final int? id;
  final int productId;
  final String customerName;
  final int quantity;
  final double latitude;
  final double longitude;

  Order({
    this.id,
    required this.productId,
    required this.customerName,
    required this.quantity,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'product_id': productId,
      'customer_name': customerName,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      productId: map['product_id'],
      customerName: map['customer_name'],
      quantity: map['quantity'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}