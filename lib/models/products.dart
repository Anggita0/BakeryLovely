class Product {
  final int? id;
  final String name;
  final int price;
  final int stock;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.stock,
  });


  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'price': price,
      'stock': stock,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      stock: map['stock'] ?? 0,
    );
  }
}
