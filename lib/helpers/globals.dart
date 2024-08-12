import 'package:flutter/cupertino.dart';

double paddingDefault = 12;
double borderRadiusDefault = 12;

SizedBox h(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox w(double width) {
  return SizedBox(
    width: width,
  );
}
double widthScreen(BuildContext context) => MediaQuery.of(context).size.width;
double heightScreen(BuildContext context) => MediaQuery.of(context).size.height;
