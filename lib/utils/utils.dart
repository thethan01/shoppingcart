import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

const double paddingDefault = 12.0;
const double borderRadiusDefault = 12.0;

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

double parseDouble(dynamic data, [double defaultValue = 0]) {
  if (data is num && (data.isNaN || data.isInfinite)) {
    return 0.0;
  }
  if (data is int) {
    return (data * 1.0);
  }
  if (data is double) return data;
  if (data is String && data != '') {
    try {
      return double.parse(data);
    } catch (e) {
      return defaultValue;
    }
  }
  return defaultValue;
}

int parseInt(dynamic data) {
  if (data is num && (data.isNaN || data.isInfinite)) {
    return 0;
  }
  if (data is int) {
    return data;
  }
  if (data is double) {
    return data.ceil();
  }
  if (data is String && RegExp(r'^\d+$').hasMatch(data)) {
    try {
      return int.parse(data);
    } catch (e) {
      return 0;
    }
  }
  return 0;
}

String currency(dynamic value) {
  if (value is! num && value != null && !(value == '0' || value == '0.0')) {
    return value.toString();
  }
  double? value0;
  if (value == null || value == '0' || value == '0.0') {
    value = 0.0;
  }
  if (value is double) {
    double? mod = parseDouble(pow(10.0, 2));
    value = ((value * mod).round().toDouble() / mod);
  }
  if (value != null) {
    value0 = parseDouble(value);
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    var result = formatter.format((double.tryParse(value0.toString())) ?? 0.0);
    return result.toString();
  }
  return '';
}
