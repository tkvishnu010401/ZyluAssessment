import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiUrls {
  ApiUrls._();

  /// Your computer's Wi-Fi IP address (from ipconfig):
  static const String hostIp = '192.168.29.129';

  /// Automatically resolves:
  /// - Web / Chrome: http://127.0.0.1:8000/api
  /// - Real Phone / Android: http://192.168.29.129:8000/api
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:8000/api';
    }
    return 'http://$hostIp:8000/api';
  }

  // Endpoints
  static String get employees => '$baseUrl/employees';
  static String get summary => '$baseUrl/employees/summary';
  static String employeeById(int id) => '$baseUrl/employees/$id';
}