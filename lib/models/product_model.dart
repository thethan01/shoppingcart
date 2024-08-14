import 'dart:convert';

ProductModel productModelFromMap(String str) =>
    ProductModel.fromMap(json.decode(str));

String productModelToMap(ProductModel data) => json.encode(data.toMap());

class ProductModel {
  final String id;
  final String name;
  final int price;
  final String image;

  const ProductModel({
    required this.id,
    required this.name,
    this.price = 0,
    this.image = "",
  });

  ProductModel copyWith({
    String? id,
    String? name,
    int? price,
    String? image,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        image: image ?? this.image,
      );

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
      };
}
