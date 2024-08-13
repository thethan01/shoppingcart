

import 'dart:convert';

import 'cart_model.dart';

class CartListModel {
  final Map<String, CartModel> listCartProduct;
  final int quantity;
  final int totalPrice;

  CartListModel({
    required this.listCartProduct,
    required this.quantity,
    required this.totalPrice,
  });

  factory CartListModel.fromMap(Map<String, dynamic> json) => CartListModel(
    listCartProduct: (jsonDecode(json["listCartProduct"]) as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, CartModel.fromMap(value)),
    ),
    totalPrice: json["totalPrice"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toMap() => {
    "listCartProduct": jsonEncode(listCartProduct.map((key, value) => MapEntry(key, value.toMap()))),
    "totalPrice": totalPrice,
    "quantity": quantity,
  };
}