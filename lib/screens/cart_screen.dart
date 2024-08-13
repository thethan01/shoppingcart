import 'package:shopping_cart/blocs/cart/cart_bloc.dart';
import 'package:shopping_cart/import.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title:
                Text('Cart${state.quantity > 0 ? '(${state.quantity})' : ''}'),
            centerTitle: true,
          ),
          bottomNavigationBar: state.listCartProduct.isEmpty
              ? null
              : Padding(
                  padding: const EdgeInsets.all(paddingDefault),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Total price',
                            style: TextStyle(fontSize: 17),
                          ),
                          Expanded(
                              child: Text(
                            currency(state.totalPrice),
                            style: const TextStyle(fontSize: 17),
                            textAlign: TextAlign.end,
                          ))
                        ],
                      ),
                      h(paddingDefault),
                      ButtonElevated(
                          onPressed: () {
                            context.read<CartBloc>().add(OrderCart());
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(paddingDefault),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Order successfully',
                                        style: StyleUtils.title,
                                      ),
                                      h(paddingDefault),
                                      ButtonElevated(
                                        onPressed: () {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/home',
                                              (Route<dynamic> route) => false);
                                        },
                                        title: 'Back to Home',
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          title: 'Order')
                    ],
                  ),
                ),
          body: state.listCartProduct.isEmpty
              ? Center(
                  child: Text(
                    'No item',
                    style: StyleUtils.title,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(paddingDefault),
                  itemCount: state.listCartProduct.length,
                  itemBuilder: (context, index) {
                    final item = state.listCartProduct.values.elementAt(index);
                    final quantity = item.quantity;
                    final price = item.quantity * item.product.price;
                    return ProductInfo(
                      product: item.product,
                      quantity: quantity,
                      price: price,
                      onTapX: (product) {
                        context.read<CartBloc>().add(RemoveFromCart(product));
                      },
                      onTapPlus: (product) {
                        if (quantity < 999) {
                          context.read<CartBloc>().add(ChangeQuantityProduct(
                              product: product, value: 1));
                        }
                      },
                      onTapMinus: (product) {
                        if (quantity == 1) {
                          context.read<CartBloc>().add(RemoveFromCart(product));
                        } else {
                          context.read<CartBloc>().add(ChangeQuantityProduct(
                              product: product, value: -1));
                        }
                      },
                      onTapQuantity: (product, value) {
                        if (value >= 1) {
                          context.read<CartBloc>().add(ChangeQuantityProduct(
                              product: product, quantity: value));
                        } else {
                          context.read<CartBloc>().add(RemoveFromCart(product));
                        }
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
