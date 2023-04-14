class CartItem {
  final String? id;
  final String title;
  final int quantity;
  final String imageUrl;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.imageUrl,
    required this.price,
  });

  CartItem copyWith({
    String? id,
    String? title,
    int? quantity,
    double? price,
    String? imageUrl,
  }) {
    return CartItem(
        id: id ?? this.id,
        title: title ?? this.title,
        quantity: quantity ?? this.quantity,
        imageUrl: imageUrl ?? this.imageUrl,
        price: price ?? this.price);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  static CartItem fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      title: json['title'],
      quantity: json['quantity'],
      imageUrl: json['imageUrl'],
      price: json['price'],
    );
  }
}
