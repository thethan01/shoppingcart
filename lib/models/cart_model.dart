import 'product_model.dart';

class CartModel {
  final ProductModel product;
  final int quantity;

  const CartModel(
      {required this.product, this.quantity = 0});
}
