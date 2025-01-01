import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget(
      {required this.mobile, required this.desktop, super.key,});
  final Widget mobile;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 600 ? mobile : desktop;
  }
}
