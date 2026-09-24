import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/employee_controller.dart';

class AddEmployeeSheet extends StatefulWidget {
  const AddEmployeeSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddEmployeeSheet(),
    );
  }

  @override
  State<AddEmployeeSheet> createState() => _AddEmployeeSheetState();
}

class _AddEmployeeSheetState extends State<AddEmployeeSheet> {
  final _formKey = GlobalKey<FormState>();
  final EmployeeController controller = Get.find<EmployeeController>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();

  String _selectedDepartment = 'Engineering';
  DateTime _selectedDate = DateTime.now();
  bool _isActive = true;

  final List<String> _departments = [
    'Engineering',
    'Product',
    'Design',
    'Human Resources',
    'Sales',
    'Marketing',
    'DevOps & Cloud',
    'Quality Assurance',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _designationController.dispose();
    super.dispose();
  }

  bool get _willBeGreenFlagged {
    final fiveYearsAgo = DateTime.now().subtract(const Duration(days: 5 * 365 + 1));
    return _isActive && _selectedDate.isBefore(fiveYearsAgo);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

    final success = await controller.addNewEmployee(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      department: _selectedDepartment,
      designation: _designationController.text,
      joiningDate: formattedDate,
      isActive: _isActive,
    );

    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      padding: EdgeInsets.fromLTRB(20, 16, 20, 20 + bottomInset),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.person_add_alt_1, color: AppColors.primary, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add New Employee',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Enter employee details and tenure information',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Full Name
              _buildTextField(
                controller: _nameController,
                label: 'Full Name *',
                hint: 'e.g. Alexander Hamilton',
                icon: Icons.person_outline,
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter name' : null,
              ),
              const SizedBox(height: 12),

              // Email
              _buildTextField(
                controller: _emailController,
                label: 'Work Email *',
                hint: 'e.g. alexander@company.com',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Please enter email';
                  if (!val.contains('@') || !val.contains('.')) return 'Invalid email address';
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Department Dropdown
              Text(
                'Department *',
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedDepartment,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                    items: _departments.map((dept) {
                      return DropdownMenuItem(
                        value: dept,
                        child: Text(dept, style: GoogleFonts.inter(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedDepartment = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Designation
              _buildTextField(
                controller: _designationController,
                label: 'Designation / Role *',
                hint: 'e.g. Senior Backend Architect',
                icon: Icons.work_outline,
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter role' : null,
              ),
              const SizedBox(height: 12),

              // Phone
              _buildTextField(
                controller: _phoneController,
                label: 'Phone Number (Optional)',
                hint: '+1-555-0123',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),

              // Date of Joining Picker
              Text(
                'Joining Date *',
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                  decoration: BoxDecoration(
                    color: AppColors.inputBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined, size: 20, color: AppColors.textSecondary),
                      const SizedBox(width: 10),
                      Text(
                        DateFormat('yyyy-MM-dd (EEEE)').format(_selectedDate),
                        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                      ),
                      const Spacer(),
                      Text('Change', style: GoogleFonts.inter(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Active Switch
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isActive ? Icons.check_circle_outline : Icons.cancel_outlined,
                      color: _isActive ? AppColors.greenFlag : AppColors.statusInactive,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Currently Active', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                        Text(_isActive ? 'Active team member' : 'Inactive / Former employee', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    ),
                    const Spacer(),
                    Switch(
                      value: _isActive,
                      activeColor: AppColors.greenFlag,
                      onChanged: (val) => setState(() => _isActive = val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Real-Time Green Flag Preview Notice!
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _willBeGreenFlagged ? AppColors.greenFlagLight : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _willBeGreenFlagged ? AppColors.greenFlagBorder : Colors.blue.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _willBeGreenFlagged ? Icons.verified : Icons.info_outline,
                      color: _willBeGreenFlagged ? AppColors.greenFlag : Colors.blue.shade700,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _willBeGreenFlagged
                            ? '🟢 This employee will be FLAGGED IN GREEN! (Tenure > 5 years & Currently Active)'
                            : '⚪ This employee will be shown in normal style (Tenure < 5 years or Inactive).',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _willBeGreenFlagged ? AppColors.greenFlagBadge : Colors.blue.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Obx(
                          () => ElevatedButton(
                        onPressed: controller.isSaving.value ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: controller.isSaving.value
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                            : Text(
                          'Save Employee',
                          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.inter(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textMuted),
            prefixIcon: Icon(icon, size: 20, color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.inputBackground,
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
          ),
        ),
      ],
    );
  }
}
