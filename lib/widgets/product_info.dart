import 'package:flutter/cupertino.dart';
import 'package:shopping_cart/import.dart';
import 'package:shopping_cart/widgets/dialog_text_field.dart';

class ProductInfo extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  final int price;
  final VoidCallback? onTapX;
  final Function(ProductModel product)? onTapPlus;
  final Function(ProductModel product)? onTapMinus;
  final Function(ProductModel product, int value)? onTapQuantity;
  const ProductInfo(
      {super.key,
      required this.product,
      this.quantity = 1,
      this.onTapX,
      this.onTapPlus,
      this.onTapMinus,
      this.price = 0,
      this.onTapQuantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusDefault),
      ),
      child: Padding(
        padding: const EdgeInsets.all(paddingDefault),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadiusDefault),
                  child: Image(
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
                ),
              ),
            ),
            w(paddingDefault),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      product.name,
                      style: StyleUtils.title,
                    )),
                    w(12),
                    InkWell(
                      onTap: () {
                        onTapX?.call();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey)),
                        child: const Icon(Icons.close),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          buttonChange(
                            onTap: () {
                              if (quantity > 0) {
                                onTapMinus?.call(product);
                              }
                            },
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final temp = await showDialog(
                                  context: context,
                                  builder: (context) => DialogTextField(
                                    product: product,
                                    quantity: quantity,
                                  ),
                                );
                                if (temp != null && temp is int) {
                                  onTapQuantity?.call(product, temp);
                                }
                              },
                              child: Container(
                                height: 40,
                                decoration: const BoxDecoration(
                                    border: Border.symmetric(
                                        vertical:
                                            BorderSide(color: Colors.grey))),
                                alignment: Alignment.center,
                                child: Text('$quantity'),
                              ),
                            ),
                          ),
                          buttonChange(
                              onTap: () {
                                if (quantity < 1000) {
                                  onTapPlus?.call(product);
                                }
                              },
                              icon: CupertinoIcons.plus),
                        ],
                      ),
                    ),
                    w(12),
                    Expanded(
                        child: Text(
                      currency(price),
                      textAlign: TextAlign.end,
                      style: StyleUtils.bold,
                    )),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  InkWell buttonChange({IconData? icon, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon ?? CupertinoIcons.minus),
      ),
    );
  }
}
