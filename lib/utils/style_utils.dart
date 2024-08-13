import 'package:shopping_cart/import.dart';

class StyleUtils {
  StyleUtils._();
  static TextStyle get title =>
      const TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
  static TextStyle get bold => const TextStyle(fontWeight: FontWeight.bold);
  static TextStyle get categoryTitle => TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.secondary);
}
