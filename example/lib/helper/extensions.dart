import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double smartWidth() => MediaQuery.sizeOf(this).width;
  double smartHeight() => MediaQuery.sizeOf(this).height;
}

extension IntExtensions on int? {
  Widget get height => SizedBox(height: this?.toDouble());
  Widget get width => SizedBox(width: this?.toDouble());
}
