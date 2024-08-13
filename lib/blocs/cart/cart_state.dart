part of 'cart_bloc.dart';

class CartState extends Equatable {
  final Map<String, CartModel> listCartProduct;
  final int quantity;
  final int totalPrice;
  const CartState({
    this.listCartProduct = const {},
    this.quantity = 0,
    this.totalPrice = 0,
  });

  @override
  List<Object> get props => [listCartProduct, quantity, totalPrice];

  CartState copyWith({
    Map<String, CartModel>? listCartProduct,
    int? quantity,
    int? totalPrice,
  }) {
    return CartState(
      listCartProduct: listCartProduct ?? this.listCartProduct,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
