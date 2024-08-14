import 'product_model.dart';
//
// class CartModel {
//   final ProductModel product;
//   final int quantity;
//
//   const CartModel(
//       {required this.product, this.quantity = 0});
//
// }

import 'dart:convert';

CartModel cartModelFromMap(String str) => CartModel.fromMap(json.decode(str));

String cartModelToMap(CartModel data) => json.encode(data.toMap());

class CartModel {
  final ProductModel product;
  final int quantity;

  const CartModel({
    required this.product,
    required this.quantity,
  });

  CartModel copyWith({
    ProductModel? product,
    int? quantity,
  }) =>
      CartModel(
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
      );

  factory CartModel.fromMap(Map<String, dynamic> json) => CartModel(
        product: ProductModel.fromMap(json["product"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "product": product.toMap(),
        "quantity": quantity,
      };
}
