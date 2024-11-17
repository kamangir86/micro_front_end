import 'package:core/core.dart';

class NavigationEvent extends CoreEvent {
  final String route;
  final bool replace;
  final Object? arguments;

  NavigationEvent(this.route, {this.replace = false, this.arguments});
}