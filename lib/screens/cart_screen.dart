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
          bottomNavigationBar: Padding(
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
                        builder: (context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(paddingDefault),
                            child: Column(
                              children: [
                                Text(
                                  'Order successfully',
                                  style: StyleUtils.title,
                                ),
                                h(paddingDefault),
                                ButtonElevated(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
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
          body: ListView.builder(
            padding: const EdgeInsets.all(paddingDefault),
            itemCount: state.listCartProduct.length,
            itemBuilder: (context, index) {
              final item = state.listCartProduct.values.elementAt(index);
              return ProductInfo(
                product: item.product,
                quantity: item.quantity,
                onTapX: () {},
              );
            },
          ),
        );
      },
    );
  }
}
