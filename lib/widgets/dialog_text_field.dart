import 'package:flutter/services.dart';
import 'package:shopping_cart/import.dart';

class DialogTextField extends StatefulWidget {
  final ProductModel product;
  final int quantity;
  const DialogTextField({super.key, required this.product, this.quantity = 1});

  @override
  State<DialogTextField> createState() => _DialogTextFieldState();
}

class _DialogTextFieldState extends State<DialogTextField> {
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    textController.text = widget.quantity.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(paddingDefault),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.product.name,
              style: StyleUtils.title,
            ),
            h(paddingDefault),
            TextField(
              controller: textController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[^0-9]')),
              ],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  errorText: parseInt(textController.text) > 999
                      ? 'Quantity cannot exceed 999'
                      : null),
              onChanged: (value) {
                setState(() {

                });
              },
            ),
            h(paddingDefault),
            ButtonElevated(
                onPressed: parseInt(textController.text) > 999
                    ? null
                    : () {
                        Navigator.of(context)
                            .pop(parseInt(textController.text));
                      },
                title: 'Submit')
          ],
        ),
      ),
    );
  }
}
