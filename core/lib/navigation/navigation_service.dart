import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class NavigationService {
  final CoreEventBusService _eventBus;
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationService(this._eventBus) : navigatorKey = GlobalKey<NavigatorState>() {
    _eventBus.subscribe<NavigationEvent>(_handleNavigation);
  }

  void _handleNavigation(NavigationEvent event) {
    if (event.replace) {
      navigatorKey.currentState?.pushReplacementNamed(
        event.route,
        arguments: event.arguments,
      );
    } else {
      navigatorKey.currentState?.pushNamed(
        event.route,
        arguments: event.arguments,
      );
    }
  }

  Future<T?> navigateTo<T>(String route, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed<T>(route, arguments: arguments);
  }
}