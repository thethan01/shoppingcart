import 'package:shopping_cart/blocs/cart/cart_bloc.dart';
import 'package:shopping_cart/blocs/home/home_bloc.dart';
import 'package:shopping_cart/import.dart';
import 'package:shopping_cart/widgets/card_product.dart';
import 'package:shopping_cart/widgets/product_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final hotProductScrollController = ScrollController();
  final allProductScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    hotProductScrollController.addListener(_onHotScroll);
    allProductScrollController.addListener(_onAllScroll);
  }

  @override
  void dispose() {
    allProductScrollController
      ..removeListener(_onAllScroll)
      ..dispose();
    hotProductScrollController
      ..removeListener(_onHotScroll)
      ..dispose();
    super.dispose();
  }

  void _onAllScroll() {
    if (_isAllBottom) context.read<HomeBloc>().add((LoadMoreAllProducts()));
  }

  void _onHotScroll() {
    if (_isHotBottom) context.read<HomeBloc>().add((LoadMoreHotProducts()));
  }

  bool get _isAllBottom {
    if (!allProductScrollController.hasClients) return false;
    final maxScroll = allProductScrollController.position.maxScrollExtent;
    final currentScroll = allProductScrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  bool get _isHotBottom {
    if (!hotProductScrollController.hasClients) return false;
    final maxScroll = hotProductScrollController.position.maxScrollExtent;
    final currentScroll = hotProductScrollController.offset;
    return currentScroll >= maxScroll;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/cart');
          }, icon: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Badge(
                label: Text('${state.quantity > 99 ? '99+' : state.quantity}'),
                isLabelVisible: state.quantity > 0,
                child: const Icon(Icons.shopping_cart),
              );
            },
          ))
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final int responsive = widthScreen(context) > 900
              ? 4
              : widthScreen(context) > 600
                  ? 3
                  : 2;
          final widthHotItem =
              (widthScreen(context) - paddingDefault * 3) / (responsive + 0.5);

          return RefreshIndicator(
            onRefresh: () async {
              hotProductScrollController.jumpTo(0);
              context.read<HomeBloc>().add(InitProducts());
            },
            child: CustomScrollView(
              controller: allProductScrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(paddingDefault),
                        child: Row(
                          children: [
                            Text(
                              'Hot product'.toUpperCase(),
                              style: StyleUtils.categoryTitle,
                            ),
                            Icon(
                              Icons.local_fire_department,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widthHotItem * 1.5,
                        child: Row(
                          children: [
                            if (state.hotProducts.isNotEmpty)
                              Expanded(
                                child: ListView.separated(
                                  controller: hotProductScrollController,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: paddingDefault),
                                  itemBuilder: (context, index) {
                                    final product = state.hotProducts[index];
                                    return CardProduct(
                                      product: product,
                                      width: widthHotItem,
                                      isHot: true,
                                    );
                                  },
                                  separatorBuilder: (context, index) => w(12),
                                  itemCount: state.hotProducts.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            if (state.isHotProductsLoading)
                              const Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(paddingDefault),
                    child: Text(
                      'All product'.toUpperCase(),
                      style: StyleUtils.categoryTitle,
                    ),
                  ),
                ),
                if (state.allProducts.isNotEmpty)
                  SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: paddingDefault),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: responsive,
                        mainAxisSpacing: paddingDefault,
                        crossAxisSpacing: paddingDefault,
                        childAspectRatio: 3 / 4,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = state.allProducts[index];
                          return CardProduct(
                            product: product,
                            width: widthHotItem,
                          );
                        },
                        childCount: state.allProducts.length,
                      ),
                    ),
                  ),
                if (state.isAllProductsLoading)
                  SliverToBoxAdapter(
                    child: ProductLoading(
                      width: widthHotItem,
                      responsive: responsive,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
