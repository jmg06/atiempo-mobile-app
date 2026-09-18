/// Shape and space tokens, which `ThemeData` has nowhere to hold.
abstract final class AppDimens {
  static const double cornerNone = 0;
  static const double cornerExtraSmall = 4;
  static const double cornerSmall = 8;
  static const double cornerMedium = 12;
  static const double cornerLarge = 16;
  static const double cornerExtraLarge = 28;
  static const double cornerFull = 999;

  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space20 = 20;
  static const double space24 = 24;
  static const double space32 = 32;
  static const double space40 = 40;
  static const double space48 = 48;
  static const double space64 = 64;

  static const double mobileMargin = 16;

  /// A 393 wide screen, less [mobileMargin] on each side.
  static const double mobileContentWidth = 361;

  static const double minTouchTarget = 48;
  static const double iconSize = 24;
  static const double iconSizeSmall = 20;
}
