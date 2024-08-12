import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/models/product.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<Product> allProducts = [];
  final List<Product> hotProducts = [];

  HomeBloc() : super(const HomeState()) {
    on(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    InitProducts event,
    Emitter<HomeState> emit,
  ) async {
    emit(
        state.copyWith(isAllProductsLoading: true, isHotProductsLoading: true));
    await Future.delayed(const Duration(seconds: 2));

    allProducts.addAll(List.generate(
      20,
      (index) {
        final temp = index + 1;
        return Product(
          id: '$temp',
          name: 'Product #$temp',
          price: temp * 10000,
          image:
              'assets/images/product_${temp.toString()[temp.toString().length - 1]}.jpg',
        );
      },
    ));
    hotProducts.addAll(List.generate(
      20,
      (index) {
        final temp = index + 15;
        return Product(
          id: '$temp',
          name: 'Product #$temp',
          price: temp * 10000,
          image:
              'assets/images/product_${temp.toString()[temp.toString().length - 1]}.jpg',
        );
      },
    ));

    emit(state.copyWith(
        allProducts: allProducts,
        hotProducts: hotProducts,
        isAllProductsLoading: false,
        isHotProductsLoading: false));
  }
}
