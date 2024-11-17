import 'package:core/core.dart';

class NavigationEvent extends CoreEvent {
  final String route;

  NavigationEvent(this.route);
}