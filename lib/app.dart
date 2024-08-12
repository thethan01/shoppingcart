import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/blocs/home/home_bloc.dart';
import 'package:shopping_cart/import.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()..add(InitProducts())),
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
