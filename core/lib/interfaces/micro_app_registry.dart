import 'package:flutter/widgets.dart';
import 'micro_app.dart';

class MicroAppRegistry {
  static final Map<String, MicroApp> _registeredApps = {};

  /// Registers a new micro-app and initializes its dependencies.
  void registerApp(MicroApp microApp) {
    if (_registeredApps.containsKey(microApp.microAppName)) {
      throw Exception('MicroApp with Name "${microApp.microAppName}" is already registered.');
    }
    microApp.registerDependencies();
    _registeredApps[microApp.microAppName] = microApp;
    debugPrint('MicroApp "${microApp.microAppName}" registered successfully.');
  }

  /// Retrieves a specific micro-app by its unique ID.
  static MicroApp? getMicroAppByName(String microAppName) => _registeredApps[microAppName];

  static List<MicroApp> get allMicroApps => _registeredApps.values.toList();


  /// Retrieves a combined map of all routes from the registered micro-apps.
  Map<String, WidgetBuilder> getAllRoutes() {
    final allRoutes = <String, WidgetBuilder>{};
    for (var app in _registeredApps.values) {
      allRoutes.addAll(app.routes);
    }
    return allRoutes;
  }

  /// Middleware to intercept and process route navigation.
  ///
  /// Returns a new route path if redirection is required or `null` to proceed normally.
  Future<String?> handleRouteMiddleware(String route, BuildContext context) async {
    for (var app in _registeredApps.values) {
      final newRoute = await app.onRouteRequested(route, context);
      if (newRoute != null) {
        debugPrint('Route "$route" redirected to "$newRoute" by "${app.microAppName}".');
        return newRoute;
      }
    }
    return null;
  }

  /// Disposes all registered micro-apps and cleans up their resources.
  void disposeAll() {
    for (var app in _registeredApps.values) {
      app.dispose();
    }
    _registeredApps.clear();
    debugPrint('All micro-apps disposed.');
  }
}