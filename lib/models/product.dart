class Product {
  int id;
  String name;
  double price;
  int quantity;
  String image;
  String description;

  Product(this.id, this.name, this.price, this.quantity, this.image,
      this.description);

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Product && runtimeType == other.runtimeType && id == other.id;
  }
}
