import 'package:shimmer/shimmer.dart';
import 'package:shopping_cart/import.dart';

class ProductLoading extends StatelessWidget {
  final double? width;
  final int responsive;
  const ProductLoading(
      {super.key, this.width, this.responsive = 2});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[500]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(paddingDefault),
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: responsive,
            childAspectRatio: 3 / 4,
            mainAxisSpacing: paddingDefault,
            crossAxisSpacing: paddingDefault,
          ),
          itemBuilder: (context, index) => SizedBox(
            width: width,
            child: Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ));
  }
}
