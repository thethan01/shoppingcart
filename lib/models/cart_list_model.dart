import 'cart_model.dart';

import 'dart:convert';

CartListModel cartListModelFromMap(String str) =>
    CartListModel.fromMap(json.decode(str));

String cartListModelToMap(CartListModel data) => json.encode(data.toMap());

class CartListModel {
  final Map<String, CartModel> listCartProduct;
  final int totalPrice;
  final int quantity;

  const CartListModel({
    required this.listCartProduct,
    required this.totalPrice,
    required this.quantity,
  });

  CartListModel copyWith({
    Map<String, CartModel>? listCartProduct,
    int? totalPrice,
    int? quantity,
  }) =>
      CartListModel(
        totalPrice: totalPrice ?? this.totalPrice,
        quantity: quantity ?? this.quantity,
        listCartProduct: listCartProduct ?? this.listCartProduct,
      );

  factory CartListModel.fromMap(Map<String, dynamic> json) => CartListModel(
        totalPrice: json["totalPrice"],
        quantity: json["quantity"],
        listCartProduct: (json['listCartProduct'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, CartModel.fromMap(value)),
        ),
      );

  Map<String, dynamic> toMap() => {
        "listCartProduct":
            listCartProduct.map((key, value) => MapEntry(key, value.toMap())),
        "totalPrice": totalPrice,
        "quantity": quantity,
      };
}
