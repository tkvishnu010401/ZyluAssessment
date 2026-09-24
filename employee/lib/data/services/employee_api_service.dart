// import 'package:dio/dio.dart';
// import '../../core/constants/api_urls.dart';
// import '../../core/network/dio_client.dart';
// import '../models/employee_model.dart';
//
// class EmployeeApiService {
//   final Dio _dio = DioClient.instance.dio;
//
//   /// Fetches employees list from Laravel backend API
//   Future<List<EmployeeModel>> fetchEmployees({
//     String? search,
//     String? department,
//     bool? flaggedGreenOnly,
//     bool? isActive,
//   }) async {
//     try {
//       final queryParams = <String, dynamic>{};
//
//       if (search != null && search.trim().isNotEmpty) {
//         queryParams['search'] = search.trim();
//       }
//       if (department != null && department.isNotEmpty && department != 'All') {
//         queryParams['department'] = department;
//       }
//       if (flaggedGreenOnly == true) {
//         queryParams['flagged_green'] = '1';
//       }
//       if (isActive != null) {
//         queryParams['is_active'] = isActive ? '1' : '0';
//       }
//
//       final response = await _dio.get(
//         ApiUrls.employees,
//         queryParameters: queryParams,
//       );
//
//       if (response.statusCode == 200 && response.data != null) {
//         final data = response.data;
//         final List list = data is Map ? (data['data'] ?? []) : data;
//
//         return list.map((item) => EmployeeModel.fromJson(item)).toList();
//       } else {
//         throw Exception('Server returned status ${response.statusCode}');
//       }
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionError ||
//           e.type == DioExceptionType.connectionTimeout) {
//         throw Exception(
//           'Cannot connect to backend at ${ApiUrls.baseUrl}.\n\n'
//           'Make sure "php artisan serve" is running on your computer!',
//         );
//       }
//       throw Exception(e.response?.data?['message'] ?? e.message ?? 'Network error occurred');
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   /// Fetches summary stats for dashboard counters
//   Future<Map<String, dynamic>> fetchSummary() async {
//     try {
//       final response = await _dio.get(ApiUrls.summary);
//       if (response.statusCode == 200 && response.data != null) {
//         return Map<String, dynamic>.from(response.data['data'] ?? {});
//       }
//       return {};
//     } catch (_) {
//       return {};
//     }
//   }
// }
import 'package:dio/dio.dart';
import '../../core/constants/api_urls.dart';
import '../../core/network/dio_client.dart';
import '../models/employee_model.dart';

class EmployeeApiService {
  final Dio _dio = DioClient.instance.dio;

  /// Fetches employees list from Laravel backend API
  Future<List<EmployeeModel>> fetchEmployees({
    String? search,
    String? department,
    bool? flaggedGreenOnly,
    bool? isActive,
  }) async {
    try {
      final queryParams = <String, dynamic>{};

      if (search != null && search.trim().isNotEmpty) {
        queryParams['search'] = search.trim();
      }
      if (department != null && department.isNotEmpty && department != 'All') {
        queryParams['department'] = department;
      }
      if (flaggedGreenOnly == true) {
        queryParams['flagged_green'] = '1';
      }
      if (isActive != null) {
        queryParams['is_active'] = isActive ? '1' : '0';
      }

      final response = await _dio.get(
        ApiUrls.employees,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        final List list = data is Map ? (data['data'] ?? []) : data;

        return list.map((item) => EmployeeModel.fromJson(item)).toList();
      } else {
        throw Exception('Server returned status ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception(
          'Cannot connect to backend at ${ApiUrls.baseUrl}.\n\n'
              'Make sure "php artisan serve" is running on your computer!',
        );
      }
      throw Exception(e.response?.data?['message'] ?? e.message ?? 'Network error occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Fetches summary stats for dashboard counters
  Future<Map<String, dynamic>> fetchSummary() async {
    try {
      final response = await _dio.get(ApiUrls.summary);
      if (response.statusCode == 200 && response.data != null) {
        return Map<String, dynamic>.from(response.data['data'] ?? {});
      }
      return {};
    } catch (_) {
      return {};
    }
  }

  /// Creates a new employee record and stores in MySQL via Laravel API
  Future<EmployeeModel> createEmployee(Map<String, dynamic> employeeData) async {
    try {
      final response = await _dio.post(
        ApiUrls.employees,
        data: employeeData,
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        final data = response.data['data'];
        return EmployeeModel.fromJson(data);
      } else {
        throw Exception('Failed to create employee: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final serverMsg = e.response?.data?['message'];
      if (e.response?.data?['errors'] != null) {
        final errors = e.response?.data['errors'] as Map;
        final firstError = errors.values.first;
        final errorMsg = firstError is List ? firstError.first : firstError.toString();
        throw Exception(errorMsg);
      }
      throw Exception(serverMsg ?? e.message ?? 'Failed to save employee');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

