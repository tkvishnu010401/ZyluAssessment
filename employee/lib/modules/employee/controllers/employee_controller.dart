// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../data/models/employee_model.dart';
// import '../../../data/services/employee_api_service.dart';
//
// class EmployeeController extends GetxController {
//   final EmployeeApiService _apiService = EmployeeApiService();
//
//   // Observable state
//   final RxList<EmployeeModel> employees = <EmployeeModel>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxString errorMessage = ''.obs;
//   final RxString searchQuery = ''.obs;
//
//   // Filter options: 'all', 'flagged_green', 'active', 'inactive'
//   final RxString selectedFilter = 'all'.obs;
//   final RxMap<String, dynamic> summary = <String, dynamic>{}.obs;
//
//   final TextEditingController searchTextController = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadEmployees();
//     loadSummary();
//   }
//
//   @override
//   void onClose() {
//     searchTextController.dispose();
//     super.onClose();
//   }
//
//   /// Fetches employees based on current filter & search
//   Future<void> loadEmployees() async {
//     isLoading.value = true;
//     errorMessage.value = '';
//
//     try {
//       bool? isGreen;
//       bool? isActive;
//
//       switch (selectedFilter.value) {
//         case 'flagged_green':
//           isGreen = true;
//           break;
//         case 'active':
//           isActive = true;
//           break;
//         case 'inactive':
//           isActive = false;
//           break;
//         default:
//           break;
//       }
//
//       final result = await _apiService.fetchEmployees(
//         search: searchQuery.value,
//         flaggedGreenOnly: isGreen,
//         isActive: isActive,
//       );
//
//       employees.assignAll(result);
//     } catch (e) {
//       errorMessage.value = e.toString().replaceFirst('Exception: ', '');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> loadSummary() async {
//     try {
//       final data = await _apiService.fetchSummary();
//       summary.assignAll(data);
//     } catch (_) {}
//   }
//
//   void onFilterChanged(String filter) {
//     if (selectedFilter.value != filter) {
//       selectedFilter.value = filter;
//       loadEmployees();
//     }
//   }
//
//   void onSearchSubmitted(String query) {
//     searchQuery.value = query;
//     loadEmployees();
//   }
//
//   void clearSearch() {
//     searchTextController.clear();
//     searchQuery.value = '';
//     loadEmployees();
//   }
//
//   Future<void> refreshAll() async {
//     await Future.wait([
//       loadEmployees(),
//       loadSummary(),
//     ]);
//   }
//
//   int get greenFlaggedCount =>
//       employees.where((e) => e.isFlaggedGreen).length;
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/employee_model.dart';
import '../../../data/services/employee_api_service.dart';

class EmployeeController extends GetxController {
  final EmployeeApiService _apiService = EmployeeApiService();

  // Observable state
  final RxList<EmployeeModel> employees = <EmployeeModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  // Filter options: 'all', 'flagged_green', 'active', 'inactive'
  final RxString selectedFilter = 'all'.obs;
  final RxMap<String, dynamic> summary = <String, dynamic>{}.obs;

  final TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadEmployees();
    loadSummary();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  /// Fetches employees based on current filter & search
  Future<void> loadEmployees() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      bool? isGreen;
      bool? isActive;

      switch (selectedFilter.value) {
        case 'flagged_green':
          isGreen = true;
          break;
        case 'active':
          isActive = true;
          break;
        case 'inactive':
          isActive = false;
          break;
        default:
          break;
      }

      final result = await _apiService.fetchEmployees(
        search: searchQuery.value,
        flaggedGreenOnly: isGreen,
        isActive: isActive,
      );

      employees.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadSummary() async {
    try {
      final data = await _apiService.fetchSummary();
      summary.assignAll(data);
    } catch (_) {}
  }

  void onFilterChanged(String filter) {
    if (selectedFilter.value != filter) {
      selectedFilter.value = filter;
      loadEmployees();
    }
  }

  void onSearchSubmitted(String query) {
    searchQuery.value = query;
    loadEmployees();
  }

  void clearSearch() {
    searchTextController.clear();
    searchQuery.value = '';
    loadEmployees();
  }

  Future<void> refreshAll() async {
    await Future.wait([
      loadEmployees(),
      loadSummary(),
    ]);
  }

  int get greenFlaggedCount =>
      employees.where((e) => e.isFlaggedGreen).length;

  final RxBool isSaving = false.obs;

  /// Creates a new employee via API and automatically adds to the active list
  Future<bool> addNewEmployee({
    required String name,
    required String email,
    required String department,
    required String designation,
    required String joiningDate,
    String? phone,
    bool isActive = true,
  }) async {
    isSaving.value = true;
    try {
      final payload = {
        'name': name.trim(),
        'email': email.trim(),
        'department': department.trim(),
        'designation': designation.trim(),
        'joining_date': joiningDate,
        'phone': phone?.trim().isEmpty ?? true ? null : phone!.trim(),
        'is_active': isActive,
      };

      final newEmployee = await _apiService.createEmployee(payload);

      // Insert at the top of the list so user immediately sees it
      employees.insert(0, newEmployee);
      loadSummary();

      Get.snackbar(
        'Success',
        '${newEmployee.name} added! ${newEmployee.isFlaggedGreen ? "🟢 Flagged Green (>5 yrs active)" : ""}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: newEmployee.isFlaggedGreen
            ? const Color(0xFF15803D)
            : const Color(0xFF1E3A8A),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        icon: Icon(
          newEmployee.isFlaggedGreen ? Icons.verified : Icons.check_circle,
          color: Colors.white,
        ),
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Failed to Add',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      return false;
    } finally {
      isSaving.value = false;
    }
  }
}

