import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/blocs/home/home_bloc.dart';
import 'package:shopping_cart/import.dart';
import 'package:shopping_cart/widgets/card_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Home'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Column(
              children: [
                if(state.isHotProductsLoading)
                  CircularProgressIndicator()else
                Row(
                  children: [
                    Builder(builder: (context) {
                      final width =
                          (widthScreen(context) - paddingDefault * 3) / 2.5;
                      return Expanded(
                        child: SizedBox(
                          height: width * 1.5,
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                                horizontal: paddingDefault),
                            itemBuilder: (context, index) => CardProduct(
                              product: Product(
                                  id: 'id',
                                  name: 'name',
                                  price: 1,
                                  image:
                                      'assets/images/product_${index.toString()[index.toString().length - 1]}.jpg'),
                              width: width,
                            ),
                            separatorBuilder: (context, index) => w(12),
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      );
                    })
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
