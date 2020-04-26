import 'package:flutter_device_type/flutter_device_type.dart';

class Dimens {
  static final double fontSize = isTablet() ? 20 : 16;

  static final double movieCardMargin = isTablet() ? 10 : 8;
  static final double movieFontSize = isTablet() ? 25 : 20;
  static final double movieGenreFontSize = isTablet() ? 20 : 16;
  static final double movieContentPadding = isTablet() ? 12.5 : 10;
  static final double movieRatingStarSize = isTablet() ? 31.25 : 25;

  static bool isTablet() => Device.get().isTablet;
}
