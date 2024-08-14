import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_cart/blocs/cart/cart_bloc.dart';
import 'package:shopping_cart/import.dart';
import 'package:shopping_cart/models/cart_model.dart';

void main() {
  group('CartBloc Unit Test', () {
    late CartBloc cartBloc;

    setUp(() {
      cartBloc = CartBloc();
    });

    tearDown(() {
      cartBloc.close();
    });

    test('init CartState', () {
      expect(cartBloc.state, equals(const CartState()));
    });

    const product =
        ProductModel(id: '1', name: 'Test Product', price: 100, image: 'image');
    const quantity = 1;

    blocTest<CartBloc, CartState>(
      'Event AddToCart',
      build: () => cartBloc,
      act: (bloc) => bloc.add(AddToCart(product, quantity)),
      expect: () => [
        isA<CartState>()
            .having((s) => s.quantity, 'quantity', 1)
            .having((s) => s.totalPrice, 'totalPrice', 100)
            .having(
                (s) => s.listCartProduct['1']!.quantity, 'quantity in cart', 1)
            .having((s) => s.listCartProduct['1']!.product, 'list product',
                product),
      ],
    );

    blocTest<CartBloc, CartState>(
      'Event OrderCart',
      build: () => cartBloc,
      seed: () => const CartState(
        quantity: 2,
        totalPrice: 200,
        listCartProduct: {
          '1': CartModel(product: product, quantity: 2),
        },
      ),
      act: (bloc) => bloc.add(OrderCart()),
      expect: () => [
        const CartState(
          quantity: 0,
          totalPrice: 0,
          listCartProduct: {},
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'Event RemoveFromCart',
      build: () => cartBloc,
      seed: () => const CartState(
        quantity: 2,
        totalPrice: 200,
        listCartProduct: {
          '1': CartModel(product: product, quantity: 2),
        },
      ),
      act: (bloc) => bloc.add(RemoveFromCart(product)),
      expect: () => [
        const CartState(
          quantity: 0,
          totalPrice: 0,
          listCartProduct: {},
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'Event ChangeQuantityProduct',
      build: () => cartBloc,
      seed: () => const CartState(
        quantity: 2,
        totalPrice: 200,
        listCartProduct: {
          '1': CartModel(product: product, quantity: 2),
        },
      ),
      act: (bloc) =>
          bloc.add(ChangeQuantityProduct(product: product, value: 1)),
      expect: () => [
        isA<CartState>()
            .having((s) => s.quantity, 'quantity', 3)
            .having((s) => s.totalPrice, 'totalPrice', 300)
            .having(
                (s) => s.listCartProduct['1']!.quantity, 'quantity in cart', 3)
            .having((s) => s.listCartProduct['1']!.product, 'product in cart',
                product),
      ],
    );
  });
  group('CartBloc Widget Test', () {
    const product = ProductModel(
        id: '1',
        name: 'Test Product',
        price: 100,
        image: "assets/images/product_0.jpg");
    testWidgets('Adding a product', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => CartBloc(),
            child: const CartScreen(),
          ),
        ),
      );
      expect(find.text('No item'), findsOneWidget);

      final cartBloc =
          BlocProvider.of<CartBloc>(tester.element(find.byType(CartScreen)));
      cartBloc.add(AddToCart(product, 1));

      await tester.pump();

      expect(find.text('Total price'), findsOneWidget);
      expect(find.text('Total price'),
          findsOneWidget); // co san pham moi hien Total price
    });

    testWidgets('Removing product', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => CartBloc()..add(AddToCart(product, 1)),
            child: const CartScreen(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Total price'),
          findsOneWidget); // co san pham moi hien Total price

      final cartBloc =
          BlocProvider.of<CartBloc>(tester.element(find.byType(CartScreen)));
      cartBloc.add(RemoveFromCart(product));

      await tester.pump();
      expect(find.text('No item'), findsOneWidget);
    });
    testWidgets('Change quantity product', (WidgetTester tester) async {});
  });
}
