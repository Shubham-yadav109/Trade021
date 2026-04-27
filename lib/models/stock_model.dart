class Stock {
  final String name;
  final String type;
  final double price;
  final double change;
  Stock({
    required this.name,
    required this.type,
    required this.price,
    required this.change,
  });
  Stock copyWith({
    String? name,
    String? type,
    double? price,
    double? change,
  }) {
    return Stock(
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      change: change ?? this.change,
    );
  }
  @override
  String toString() {
    return 'Stock(name: $name, price: $price, change: $change)';
  }
}