import 'package:shopping_cart/blocs/cart/cart_bloc.dart';
import 'package:shopping_cart/import.dart';

class BottomAddCart extends StatefulWidget {
  final ProductModel product;
  const BottomAddCart({super.key, required this.product});

  @override
  State<BottomAddCart> createState() => _BottomAddCartState();
}

class _BottomAddCartState extends State<BottomAddCart> {
  int quantity = 1;
  int price = 0;
  @override
  void initState() {
    price = widget.product.price * quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(paddingDefault),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProductInfo(
            product: widget.product,
            quantity: quantity,
            price: price,
            onTapMinus: (_) {
              if (quantity > 1) {
                setState(() {
                  quantity--;
                  price = widget.product.price * quantity;
                });
              }
            },
            onTapPlus: (product) {
              if (quantity < 999) {
                setState(() {
                  quantity++;
                  price = widget.product.price * quantity;
                });
              }
            },
            onTapX: (_) => Navigator.of(context).pop(),
            onTapQuantity: (product, value) {
              setState(() {
                quantity = value;
                price = widget.product.price * quantity;
              });
            },
          ),
          h(paddingDefault),
          ButtonElevated(
            onPressed: () {
              context.read<CartBloc>().add(AddToCart(widget.product, quantity));
              Navigator.of(context).pop();
            },
            title: 'Add to cart',
          )
        ],
      ),
    );
  }
}
