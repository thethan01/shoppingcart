import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/app.dart';
import 'package:shopping_cart/blocs/cart/cart_bloc.dart';
import 'package:shopping_cart/import.dart';

import 'bottom_add_cart.dart';

class CardProduct extends StatelessWidget {
  final double width;
  final ProductModel product;
  final bool isHot;
  final int coefficient;
  const CardProduct(
      {super.key,
      this.width = 100,
      required this.product,
      this.isHot = false,
      this.coefficient = 2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusDefault),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage(product.image),
                    isAntiAlias: false,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (frame == null) {
                        return const CircularProgressIndicator();
                      }
                      return child;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Text(product.name),
                          Text(currency(product.price)),
                        ],
                      )),
                      IconButton(
                          onPressed: () {
                            showBottomSheet(
                              context: context,
                              builder: (context) => BottomAddCart(
                                product: product,
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.add_shopping_cart_outlined,
                            color: Theme.of(context).primaryColor,
                          ))
                    ],
                  )
                ],
              ),
              if (isHot)
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    Icons.local_fire_department_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
