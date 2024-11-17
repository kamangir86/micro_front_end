import 'dart:async';

import 'events/core_events.dart';

/// CoreEventBusService for handling global event communication.
class CoreEventBusService {
  // Singleton instance
  static final CoreEventBusService _instance = CoreEventBusService._internal();

  factory CoreEventBusService() => _instance;

  CoreEventBusService._internal();

  // Stream controllers for managing events
  final Map<Type, StreamController<CoreEvent>> _eventControllers = {};

  /// Publishes an event to all listeners of that event type.
  void publish<T extends CoreEvent>(T event) {
    final controller = _eventControllers[T];
    if (controller != null) {
      controller.add(event);
    } else {
      throw Exception("No listeners registered for event type $T.");
    }
  }

  /// Subscribes to events of a specific type.
  /// Returns a [StreamSubscription] to allow unsubscription if needed.
  StreamSubscription<T> subscribe<T extends CoreEvent>(
      void Function(T event) onEvent,
      ) {
    _eventControllers.putIfAbsent(
      T,
          () => StreamController<CoreEvent>.broadcast(),
    );
    return _eventControllers[T]!.stream
        .where((event) => event is T)
        .cast<T>()
        .listen(onEvent);
  }

  /// Disposes of all event controllers when no longer needed.
  void dispose() {
    for (var controller in _eventControllers.values) {
      controller.close();
    }
    _eventControllers.clear();
  }
}
