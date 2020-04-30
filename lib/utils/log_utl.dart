import 'package:logger/logger.dart';

class LogUtil {
  static Logger _logger = Logger();

  static void d(String message) {
    _logger.d(message);
  }

  static void e(message) {
    _logger.e(message);
  }

  static void v(message) {
    _logger.v(message);
  }

  static void i(message) {
    _logger.i(message);
  }

  static void w(message) {
    _logger.w(message);
  }
}
