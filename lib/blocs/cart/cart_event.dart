part of 'cart_bloc.dart';

@immutable
class CartEvent {}

class AddToCart extends CartEvent {
  final ProductModel product;
  final int quantity;
  AddToCart(this.product, this.quantity);
}

class RemoveFromCart extends CartEvent {
  final ProductModel product;
  RemoveFromCart(this.product);
}

class ChangeQuantityProduct extends CartEvent {
  final ProductModel product;
  final int value;
  final int? quantity;
  ChangeQuantityProduct(
      {this.quantity, required this.product, this.value = 0});
}

class OrderCart extends CartEvent {}
