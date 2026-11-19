import 'dart:developer' as developer;

class AppLogger {
  static void info(String message) {
    developer.log(
      message,
      name: 'FoodPoison.INFO',
    );
  }

  static void warning(String message) {
    developer.log(
      message,
      name: 'FoodPoison.WARNING',
    );
  }

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: 'FoodPoison.ERROR',
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }
}
