import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/employee_controller.dart';

class FilterChipBar extends GetView<EmployeeController> {
  const FilterChipBar({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'key': 'all', 'label': 'All'},
      {'key': 'flagged_green', 'label': '🟢 5+ Yrs Active'},
      {'key': 'active', 'label': 'Active Only'},
      {'key': 'inactive', 'label': 'Inactive'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Obx(
        () => Row(
          children: filters.map((filter) {
            final isSelected = controller.selectedFilter.value == filter['key'];
            final isGreenFilter = filter['key'] == 'flagged_green';

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                selected: isSelected,
                label: Text(
                  filter['label']!,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? (isGreenFilter ? Colors.white : Colors.white)
                        : (isGreenFilter ? AppColors.greenFlag : AppColors.textPrimary),
                  ),
                ),
                backgroundColor: isGreenFilter
                    ? AppColors.greenFlagLight
                    : AppColors.inputBackground,
                selectedColor: isGreenFilter
                    ? AppColors.greenFlag
                    : AppColors.primary,
                checkmarkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? Colors.transparent
                        : (isGreenFilter ? AppColors.greenFlagBorder : AppColors.cardBorder),
                  ),
                ),
                onSelected: (_) => controller.onFilterChanged(filter['key']!),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
