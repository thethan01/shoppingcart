import 'package:shopping_cart/import.dart';

class ButtonElevated extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  const ButtonElevated({super.key, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed, child: Text(title ?? '')),
    );
  }
}
