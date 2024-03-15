
import 'package:flutter/material.dart';

// Context Extension
extension ContextExt on BuildContext {
  // Getting the theme
  // this = context
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;

  double get width => size.width;
  double get height => size.height;

}
