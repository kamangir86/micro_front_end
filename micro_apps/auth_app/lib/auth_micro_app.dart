import 'package:auth_app/auth_app.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:core/core.dart';

class AuthMicroApp implements MicroApp {
  @override
  String get microAppName => 'auth';

  @override
  String get initialRoute => '/auth/login';

  @override
  Map<String, WidgetBuilder> get routes => {
    '/auth/login': (context) => LoginPage(),
    '/auth/register': (context) => RegisterPage(),
  };

  @override
  Future<void> registerDependencies() async {
    final getIt = GetIt.instance;

    // Register auth dependencies
    // getIt.registerSingleton<AuthRepository>(AuthRepository());
    // getIt.registerFactory<AuthBloc>(() => AuthBloc(
    //   repository: getIt<AuthRepository>(),
    //   eventBus: getIt<CoreEventBusService>(),
    // ));
  }

  @override
  Future<void> registerEventHandlers(CoreEventBusService eventBus) async {
    eventBus.subscribe<UserLogoutEvent>((event) {
      // Handle logout event
    });
  }

  @override
  Future<String?> onRouteRequested(String route, BuildContext context) {
    // TODO: implement onRouteRequested
    throw UnimplementedError();
  }


  @override
  // TODO: implement analyticsSettings
  Map<String, dynamic>? get analyticsSettings => throw UnimplementedError();

  @override
  void dispose() {
    // TODO: implement dispose
  }
}