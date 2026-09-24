// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../core/constants/app_colors.dart';
// import '../controllers/employee_controller.dart';
// import '../widgets/employee_card.dart';
// import '../widgets/filter_chip_bar.dart';
//
// class EmployeeListView extends GetView<EmployeeController> {
//   const EmployeeListView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryBackground,
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//         centerTitle: false,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Employee Directory',
//               style: GoogleFonts.poppins(
//                 fontSize: 19,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               'Active & 5+ Years Tenure Tracker',
//               style: GoogleFonts.inter(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.white.withOpacity(0.85),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Colors.white),
//             tooltip: 'Refresh',
//             onPressed: controller.refreshAll,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Header Stats Counter Banner
//           _buildStatsBanner(),
//
//           // Search Bar
//           _buildSearchBar(),
//
//           // Quick Filter Chips
//           const FilterChipBar(),
//
//           // Employee List / States
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value && controller.employees.isEmpty) {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
//                   ),
//                 );
//               }
//
//               if (controller.errorMessage.isNotEmpty && controller.employees.isEmpty) {
//                 return _buildErrorState();
//               }
//
//               if (controller.employees.isEmpty) {
//                 return _buildEmptyState();
//               }
//
//               return RefreshIndicator(
//                 color: AppColors.primary,
//                 onRefresh: controller.refreshAll,
//                 child: ListView.builder(
//                   padding: const EdgeInsets.only(top: 4, bottom: 24),
//                   itemCount: controller.employees.length,
//                   itemBuilder: (context, index) {
//                     final employee = controller.employees[index];
//                     return EmployeeCard(
//                       employee: employee,
//                       onTap: () => _showEmployeeDetailsModal(context, employee),
//                     );
//                   },
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatsBanner() {
//     return Container(
//       color: AppColors.primary,
//       padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
//       child: Obx(() {
//         final total = controller.employees.length;
//         final greenCount = controller.greenFlaggedCount;
//
//         return Row(
//           children: [
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.12),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.people, color: Colors.white, size: 20),
//                     const SizedBox(width: 8),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Total Shown',
//                           style: GoogleFonts.inter(
//                             fontSize: 11,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                         ),
//                         Text(
//                           '$total',
//                           style: GoogleFonts.poppins(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: AppColors.greenFlag.withOpacity(0.85),
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: AppColors.greenFlagBorder.withOpacity(0.5),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.verified, color: Colors.white, size: 20),
//                     const SizedBox(width: 8),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Flagged Green (>5y)',
//                           style: GoogleFonts.inter(
//                             fontSize: 11,
//                             color: Colors.white.withOpacity(0.9),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Text(
//                           '$greenCount',
//                           style: GoogleFonts.poppins(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: TextField(
//         controller: controller.searchTextController,
//         onSubmitted: controller.onSearchSubmitted,
//         textInputAction: TextInputAction.search,
//         decoration: InputDecoration(
//           hintText: 'Search by name, role, or department...',
//           hintStyle: GoogleFonts.inter(
//             fontSize: 13,
//             color: AppColors.textMuted,
//           ),
//           prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
//           suffixIcon: Obx(
//             () => controller.searchQuery.isNotEmpty
//                 ? IconButton(
//                     icon: const Icon(Icons.clear, size: 18),
//                     onPressed: controller.clearSearch,
//                   )
//                 : const SizedBox.shrink(),
//           ),
//           filled: true,
//           fillColor: AppColors.inputBackground,
//           contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: AppColors.cardBorder),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: AppColors.cardBorder),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.person_search_outlined, size: 64, color: AppColors.textMuted),
//             const SizedBox(height: 16),
//             Text(
//               'No Employees Found',
//               style: GoogleFonts.poppins(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               'Try changing your search keywords or filter selection.',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.inter(
//                 fontSize: 13,
//                 color: AppColors.textSecondary,
//               ),
//             ),
//             const SizedBox(height: 18),
//             ElevatedButton(
//               onPressed: () {
//                 controller.clearSearch();
//                 controller.onFilterChanged('all');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: const Text('Reset Filters'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorState() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.cloud_off, size: 60, color: Colors.redAccent),
//             const SizedBox(height: 16),
//             Text(
//               'Connection Error',
//               style: GoogleFonts.poppins(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               controller.errorMessage.value,
//               textAlign: TextAlign.center,
//               style: GoogleFonts.inter(
//                 fontSize: 13,
//                 color: AppColors.textSecondary,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: controller.loadEmployees,
//               icon: const Icon(Icons.refresh, size: 18),
//               label: const Text('Retry Connection'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showEmployeeDetailsModal(BuildContext context, dynamic employee) {
//     Get.bottomSheet(
//       Container(
//         padding: const EdgeInsets.all(24),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Container(
//                 width: 40,
//                 height: 4,
//                 margin: const EdgeInsets.only(bottom: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundColor: employee.isFlaggedGreen
//                       ? AppColors.greenFlag
//                       : AppColors.primary,
//                   child: Text(
//                     employee.name.isNotEmpty ? employee.name[0] : 'E',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         employee.name,
//                         style: GoogleFonts.poppins(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       Text(
//                         '${employee.designation} • ${employee.department}',
//                         style: GoogleFonts.inter(
//                           fontSize: 13,
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Divider(),
//             const SizedBox(height: 12),
//             _buildDetailRow(Icons.email_outlined, 'Email', employee.email),
//             _buildDetailRow(Icons.phone_outlined, 'Phone', employee.phone ?? 'N/A'),
//             _buildDetailRow(
//               Icons.calendar_month_outlined,
//               'Joined Date',
//               employee.joiningDate?.toString().substring(0, 10) ?? 'N/A',
//             ),
//             _buildDetailRow(
//               Icons.timer_outlined,
//               'Tenure',
//               '${employee.tenureDisplay} (${employee.tenureYears.toStringAsFixed(1)} years)',
//             ),
//             _buildDetailRow(
//               Icons.verified_outlined,
//               'Green Flag Status',
//               employee.isFlaggedGreen
//                   ? 'Eligible (Active & > 5 Years)'
//                   : 'Not Eligible',
//               textColor: employee.isFlaggedGreen ? AppColors.greenFlag : AppColors.textSecondary,
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       isScrollControlled: true,
//     );
//   }
//
//   Widget _buildDetailRow(IconData icon, String label, String value, {Color? textColor}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: AppColors.textSecondary),
//           const SizedBox(width: 12),
//           Text(
//             '$label: ',
//             style: GoogleFonts.inter(
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//               color: AppColors.textSecondary,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.inter(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: textColor ?? AppColors.textPrimary,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

import '../controllers/employee_controller.dart';
import '../widgets/add_employee_sheet.dart';
import '../widgets/employee_card.dart';
import '../widgets/filter_chip_bar.dart';

class EmployeeListView extends GetView<EmployeeController> {
  const EmployeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                        Text(
              'Employee Directory',
              style: GoogleFonts.poppins(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              'Active & 5+ Years Tenure Tracker',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.85),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Refresh',
            onPressed: controller.refreshAll,
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Stats Counter Banner
          _buildStatsBanner(),

          // Search Bar
          _buildSearchBar(),

          // Quick Filter Chips
          const FilterChipBar(),

          // Employee List / States
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.employees.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                );
              }

              if (controller.errorMessage.isNotEmpty && controller.employees.isEmpty) {
                return _buildErrorState();
              }

              if (controller.employees.isEmpty) {
                return _buildEmptyState();
              }

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: controller.refreshAll,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 4, bottom: 24),
                  itemCount: controller.employees.length,
                  itemBuilder: (context, index) {
                    final employee = controller.employees[index];
                    return EmployeeCard(
                      employee: employee,
                      onTap: () => _showEmployeeDetailsModal(context, employee),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AddEmployeeSheet.show(context),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.person_add),
        label: Text(
          'Add Employee',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildStatsBanner() {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
      child: Obx(() {
        final total = controller.employees.length;
        final greenCount = controller.greenFlaggedCount;

        return Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.people, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Shown',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        Text(
                          '$total',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.greenFlag.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.greenFlagBorder.withOpacity(0.5),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Flagged Green (>5y)',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '$greenCount',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        controller: controller.searchTextController,
        onSubmitted: controller.onSearchSubmitted,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search by name, role, or department...',
          hintStyle: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.textMuted,
          ),
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
          suffixIcon: Obx(
                () => controller.searchQuery.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear, size: 18),
              onPressed: controller.clearSearch,
            )
                : const SizedBox.shrink(),
          ),
          filled: true,
          fillColor: AppColors.inputBackground,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.cardBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.cardBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_search_outlined, size: 64, color: AppColors.textMuted),
            const SizedBox(height: 16),
            Text(
              'No Employees Found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Try changing your search keywords or filter selection.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                controller.clearSearch();
                controller.onFilterChanged('all');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Reset Filters'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 60, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              'Connection Error',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: controller.loadEmployees,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Retry Connection'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEmployeeDetailsModal(BuildContext context, dynamic employee) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: employee.isFlaggedGreen
                      ? AppColors.greenFlag
                      : AppColors.primary,
                  child: Text(
                    employee.name.isNotEmpty ? employee.name[0] : 'E',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.name,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${employee.designation} • ${employee.department}',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.email_outlined, 'Email', employee.email),
            _buildDetailRow(Icons.phone_outlined, 'Phone', employee.phone ?? 'N/A'),
            _buildDetailRow(
              Icons.calendar_month_outlined,
              'Joined Date',
              employee.joiningDate?.toString().substring(0, 10) ?? 'N/A',
            ),
            _buildDetailRow(
              Icons.timer_outlined,
              'Tenure',
              '${employee.tenureDisplay} (${employee.tenureYears.toStringAsFixed(1)} years)',
            ),
            _buildDetailRow(
              Icons.verified_outlined,
              'Green Flag Status',
              employee.isFlaggedGreen
                  ? 'Eligible (Active & > 5 Years)'
                  : 'Not Eligible',
              textColor: employee.isFlaggedGreen ? AppColors.greenFlag : AppColors.textSecondary,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: textColor ?? AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
