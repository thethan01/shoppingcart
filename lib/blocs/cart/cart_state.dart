part of 'cart_bloc.dart';

class CartState extends Equatable {
  final Map<String, CartModel> listCardProduct;
  final int quantity;
  const CartState({this.listCardProduct = const {}, this.quantity = 0});

  @override
  List<Object> get props => [listCardProduct, quantity];

  CartState copyWith(
      {Map<String, CartModel>? listCardProduct, int? quantity}) {
    return CartState(
      listCardProduct: listCardProduct ?? this.listCardProduct,
      quantity: quantity ?? this.quantity,
    );
  }
}
