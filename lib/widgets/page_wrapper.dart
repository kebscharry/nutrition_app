import 'package:flutter/material.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget mobileView;
  final Widget tabletView;
  final Widget desktopView;

  const ResponsiveWrapper({
    Key? key,
    required this.mobileView,
    required this.tabletView,
    required this.desktopView,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return desktopView;
    } else if (isTablet(context)) {
      return tabletView;
    } else {
      return mobileView;
    }
  }
}
