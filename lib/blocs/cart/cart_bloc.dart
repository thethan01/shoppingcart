import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/models/cart_model.dart';
import 'package:shopping_cart/models/product_model.dart';
import 'package:shopping_cart/widgets/card_product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on(_onAddProduct);
    on(_onOrder);
    on(_onRemoveFromCart);
    on(_onChangeQuantityProduct);
  }
  Future<void> _onAddProduct(
    AddToCart event,
    Emitter<CartState> emit,
  ) async {
    int quantity = state.quantity + event.quantity;
    int totalPrice = state.totalPrice + event.quantity * event.product.price;
    final Map<String, CartModel> listCardProduct =
        Map.from(state.listCartProduct);
    if (listCardProduct.containsKey(event.product.id)) {
      final totalQuantity =
          (listCardProduct['event.product.id']?.quantity ?? 0) + quantity;
      listCardProduct[event.product.id] = CartModel(
        product: event.product,
        quantity: totalQuantity > 999 ? 999 : totalQuantity,
      );
    } else {
      listCardProduct.addEntries({
        event.product.id: CartModel(
          product: event.product,
          quantity: event.quantity,
        )
      }.entries);
    }

    emit(state.copyWith(
        quantity: quantity,
        listCartProduct: listCardProduct,
        totalPrice: totalPrice));
  }

  Future<void> _onOrder(
    OrderCart event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(quantity: 0, listCartProduct: {}, totalPrice: 0));
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    final quantity =
        state.quantity - state.listCartProduct[event.product.id]!.quantity;
    final totalPrice = state.totalPrice -
        (state.listCartProduct[event.product.id]!.quantity *
            state.listCartProduct[event.product.id]!.product.price);
    final Map<String, CartModel> listCardProduct =
        Map.from(state.listCartProduct)..remove(event.product.id);
    emit(state.copyWith(
        quantity: quantity,
        listCartProduct: listCardProduct,
        totalPrice: totalPrice));
  }

  Future<void> _onChangeQuantityProduct(
    ChangeQuantityProduct event,
    Emitter<CartState> emit,
  ) async {
    int quantity = 0;
    int totalPrice = 0;
    if (event.quantity != null) {
      int value =
          event.quantity! - state.listCartProduct[event.product.id]!.quantity;
      quantity = state.quantity + value;
      totalPrice = state.totalPrice +
          (value * state.listCartProduct[event.product.id]!.product.price);
    } else {
      quantity = state.quantity + event.value;
      totalPrice = state.totalPrice +
          (event.value *
              state.listCartProduct[event.product.id]!.product.price);
    }

    final Map<String, CartModel> listCardProduct =
        Map.from(state.listCartProduct);
    listCardProduct[event.product.id] = CartModel(
      product: event.product,
      quantity: event.quantity != null
          ? event.quantity!
          : listCardProduct[event.product.id]!.quantity + event.value,
    );
    emit(state.copyWith(
        quantity: quantity,
        listCartProduct: listCardProduct,
        totalPrice: totalPrice));
  }
}
