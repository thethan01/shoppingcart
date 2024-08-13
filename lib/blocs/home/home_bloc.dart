import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/models/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on(_onInitProducts);
    on(_onLoadMoreAllProducts);
    on(_onLoadMoreHotProducts);
  }

  Future<void> _onInitProducts(
    InitProducts event,
    Emitter<HomeState> emit,
  ) async {
    final List<ProductModel> allProducts = [];
    final List<ProductModel> hotProducts = [];
    // goi khi khoi tao va khi refresh
    emit(state.copyWith(
        hotProducts: hotProducts,
        allProducts: allProducts,
        isAllProductsLoading: true,
        isHotProductsLoading: true));
    await Future.delayed(const Duration(seconds: 2));
    allProducts.addAll(List.generate(
      20,
          (index) {
        final temp = index + 1;
        return ProductModel(
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
        return ProductModel(
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

  Future<void> _onLoadMoreAllProducts(
    LoadMoreAllProducts event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isAllProductsLoading: true));
    final int lengthAllProduct = state.allProducts.length;
    final listNewProduct = List.generate(
      10,
      (index) {
        final temp = index + lengthAllProduct;
        return ProductModel(
          id: '$temp',
          name: 'Product #$temp',
          price: temp * 10000,
          image:
              'assets/images/product_${temp.toString()[temp.toString().length - 1]}.jpg',
        );
      },
    );
    final List<ProductModel> allProducts = List.from(state.allProducts)
      ..addAll(listNewProduct);
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
      allProducts: allProducts,
      isAllProductsLoading: false,
    ));
  }

  Future<void> _onLoadMoreHotProducts(
    LoadMoreHotProducts event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isHotProductsLoading: true));
    final int lengthAllProduct = state.hotProducts.length;
    final listNewProduct = List.generate(
      10,
      (index) {
        final temp = index + lengthAllProduct;
        return ProductModel(
          id: '$temp',
          name: 'Product #$temp',
          price: temp * 10000,
          image:
              'assets/images/product_${temp.toString()[temp.toString().length - 1]}.jpg',
        );
      },
    );
    final List<ProductModel> hotProducts = List.from(state.hotProducts)
      ..addAll(listNewProduct);
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
      hotProducts: hotProducts,
      isHotProductsLoading: false,
    ));
  }
}
