import 'package:shopping_cart/blocs/cart/cart_bloc.dart';
import 'package:shopping_cart/blocs/home/home_bloc.dart';
import 'package:shopping_cart/import.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()..add(InitProducts())),
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: MaterialApp(
        title: 'Shopping Cart',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/cart': (context) => const CartScreen(),
        },
        initialRoute: '/',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xffef890c),
            secondary: const Color(0xffda5a0a),
          ),
          useMaterial3: false,
          primaryColor: const Color(0xffef890c),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadiusDefault),
                borderSide: const BorderSide(color: Color(0xffD0D5DD))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadiusDefault),
                borderSide: const BorderSide(color: Color(0xffD0D5DD))),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xffef890c),
              foregroundColor: Colors.white,
              elevation: 1),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xffef890c)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusDefault),
                  ),
                ),
                textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold))),
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
