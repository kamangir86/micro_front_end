import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

abstract class MicroApp{
  String get microAppName;

  /// Navigation
  String get initialRoute;
  Map<String, WidgetBuilder> get routes;

  /// Optional: Middleware or logic to execute before route navigation.
  /// Useful for authentication, logging, or dynamic routing.
  ///
  /// Returns the new route path to navigate to or `null` to proceed as-is.
  Future<String?> onRouteRequested(String route, BuildContext context);

  /// Dependencies
  Future<void> registerDependencies();

  /// Event handling
  Future<void> registerEventHandlers(CoreEventBusService eventBus);

  /// Optional: Analytics
  Map<String, dynamic>? get analyticsSettings;

  /// Optional: Cleanup logic for the micro-app.
  /// Can be used to release resources or clear dependency injections.
  void dispose();
}