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
  }
  Future<void> _onAddProduct(
    AddToCart event,
    Emitter<CartState> emit,
  ) async {
    int quantity = state.quantity + event.quantity;
    final Map<String, CartModel> listCardProduct =
        Map.from(state.listCardProduct);
    if (listCardProduct.containsKey(event.product.id)) {
      final total = (listCardProduct['event.product.id']?.quantity ?? 0) + quantity;
      listCardProduct['event.product.id'] =
          CartModel(product: event.product, quantity: total);
    } else {
      listCardProduct.addEntries({
        event.product.id:
            CartModel(product: event.product, quantity: event.quantity)
      }.entries);
    }
    emit(state.copyWith(quantity: quantity, listCardProduct: listCardProduct));
  }
}
