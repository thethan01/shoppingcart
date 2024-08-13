part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<ProductModel> hotProducts;
  final List<ProductModel> allProducts;
  final bool isHotProductsLoading;
  final bool isAllProductsLoading;
  const HomeState(
      {this.hotProducts = const [],
      this.allProducts = const [],
      this.isHotProductsLoading = false,
      this.isAllProductsLoading = false});

  @override
  List<Object> get props =>
      [hotProducts, allProducts, isHotProductsLoading, isAllProductsLoading];

  HomeState copyWith({
    List<ProductModel>? hotProducts,
    List<ProductModel>? allProducts,
    bool? isAllProductsLoading,
    bool? isHotProductsLoading,
  }) {
    return HomeState(
      hotProducts: hotProducts ?? this.hotProducts,
      allProducts: allProducts ?? this.allProducts,
      isHotProductsLoading: isHotProductsLoading ?? this.isHotProductsLoading,
      isAllProductsLoading: isAllProductsLoading ?? this.isAllProductsLoading,
    );
  }
}
