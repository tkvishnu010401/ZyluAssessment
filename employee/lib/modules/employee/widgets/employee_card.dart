import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/employee_model.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeModel employee;
  final VoidCallback? onTap;

  const EmployeeCard({
    super.key,
    required this.employee,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isGreen = employee.isFlaggedGreen;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: BoxDecoration(
        // HIGHLIGHT IN GREEN: Soft emerald background for > 5 yrs active employees
        color: isGreen ? AppColors.greenFlagLight : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          // HIGHLIGHT IN GREEN: Prominent emerald border
          color: isGreen ? AppColors.greenFlagBorder : AppColors.cardBorder,
          width: isGreen ? 2.0 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isGreen ? AppColors.greenFlagShadow : Colors.black.withOpacity(0.04),
            blurRadius: isGreen ? 12 : 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Avatar + Name + Green Badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar with conditional green border
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isGreen ? AppColors.greenFlag : AppColors.primaryLight,
                          width: 2.5,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: isGreen
                            ? AppColors.greenFlag.withOpacity(0.15)
                            : AppColors.primary.withOpacity(0.1),
                        backgroundImage: employee.avatarUrl != null &&
                                employee.avatarUrl!.isNotEmpty
                            ? NetworkImage(employee.avatarUrl!)
                            : null,
                        child: employee.avatarUrl == null ||
                                employee.avatarUrl!.isEmpty
                            ? Text(
                                employee.name.isNotEmpty
                                    ? employee.name[0].toUpperCase()
                                    : 'E',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: isGreen
                                      ? AppColors.greenFlag
                                      : AppColors.primary,
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Name & Designation
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employee.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: isGreen
                                  ? AppColors.greenFlagBadge
                                  : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            employee.designation,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            employee.department,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 🟢 GREEN FLAG BADGE (Only for Active & > 5 Years Tenure)
                    if (isGreen)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.greenFlag,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greenFlag.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.verified,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '5+ Yrs Active',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 14),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: isGreen
                      ? AppColors.greenFlagBorder.withOpacity(0.3)
                      : AppColors.cardBorder,
                ),
                const SizedBox(height: 12),

                // Bottom row: Joining Date / Tenure & Active Status
                Row(
                  children: [
                    Icon(
                      Icons.history_toggle_off,
                      size: 16,
                      color: isGreen ? AppColors.greenFlag : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Tenure: ',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      employee.tenureDisplay.isNotEmpty
                          ? employee.tenureDisplay
                          : '${employee.tenureYears.toStringAsFixed(1)} yrs',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isGreen ? AppColors.greenFlag : AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),

                    // Active / Inactive Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: employee.isActive
                            ? AppColors.statusActiveBg
                            : AppColors.statusInactiveBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: employee.isActive
                                  ? AppColors.statusActive
                                  : AppColors.statusInactive,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            employee.isActive ? 'Active' : 'Inactive',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: employee.isActive
                                  ? AppColors.statusActive
                                  : AppColors.statusInactive,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
