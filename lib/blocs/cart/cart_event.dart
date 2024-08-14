part of 'cart_bloc.dart';

@immutable
class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitCart extends CartEvent {
  InitCart();
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final ProductModel product;
  final int quantity;
  AddToCart(this.product, this.quantity);
  @override
  List<Object?> get props => [product, quantity];
}

class RemoveFromCart extends CartEvent {
  final ProductModel product;

  RemoveFromCart(this.product);
  @override
  List<Object?> get props => [product];
}

class ChangeQuantityProduct extends CartEvent {
  final ProductModel product;
  final int value;
  final int? quantity;
  ChangeQuantityProduct({this.quantity, required this.product, this.value = 0});
  @override
  List<Object?> get props => [product, quantity, value];
}

class OrderCart extends CartEvent {}
