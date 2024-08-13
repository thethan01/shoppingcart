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
  final int quantity;
  ChangeQuantityProduct(this.product, this.quantity);
}

class OrderCart extends CartEvent {}
