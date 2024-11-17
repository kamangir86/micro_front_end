import 'package:core/core.dart';

class ThemeChangeEvent extends CoreEvent {
  final bool isDarkMode;

  ThemeChangeEvent(this.isDarkMode);
}