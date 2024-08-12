import 'package:shopping_cart/import.dart';

class CardProduct extends StatelessWidget {
  final double width;
  final Product product;
  final bool isHot;
  final int coefficient;
  const CardProduct(
      {super.key,
      this.width = 100,
      required this.product,
      this.isHot = true,
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
                    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
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
                          Text('${product.price}'),
                        ],
                      )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_shopping_cart_outlined,
                            color: Theme.of(context).primaryColor,
                          ))
                    ],
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Icon(Icons.local_fire_department_rounded, color: Theme.of(context).primaryColor,),
              )
            ],
          ),
        ),
      ),
    );
  }


}
