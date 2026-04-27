class Stock {
  final String name;
  final String type;
  final double price;
  final double change;
  final String? exchangeCode;

  Stock({
    required this.name,
    required this.type,
    required this.price,
    required this.change,
    this.exchangeCode,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      name: json['name'] ?? '',
      type: json['type'] ?? 'EQ',
      price: (json['price'] ?? 0.0).toDouble(),
      change: (json['change'] ?? 0.0).toDouble(),
      exchangeCode: json['exchangeCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'price': price,
      'change': change,
      'exchangeCode': exchangeCode,
    };
  }

  Stock copyWith({
    String? name,
    String? type,
    double? price,
    double? change,
    String? exchangeCode,
  }) {
    return Stock(
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      change: change ?? this.change,
      exchangeCode: exchangeCode ?? this.exchangeCode,
    );
  }

  @override
  String toString() {
    return 'Stock(name: $name, price: $price, change: $change)';
  }
}