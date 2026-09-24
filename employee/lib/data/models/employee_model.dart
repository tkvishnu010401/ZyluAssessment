class EmployeeModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String department;
  final String designation;
  final String? avatarUrl;
  final DateTime? joiningDate;
  final bool isActive;
  final double tenureYears;
  final String tenureDisplay;
  final bool isFlaggedGreen;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.department,
    required this.designation,
    this.avatarUrl,
    this.joiningDate,
    required this.isActive,
    required this.tenureYears,
    required this.tenureDisplay,
    required this.isFlaggedGreen,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    final joiningDateParsed = json['joining_date'] != null
        ? DateTime.tryParse(json['joining_date'].toString())
        : null;

    final isActive = json['is_active'] == true || json['is_active'] == 1;

    // Use backend computed flag, or compute client-side as fallback
    final serverFlag = json['is_flagged_green'];
    final computedFlag = serverFlag != null
        ? (serverFlag == true || serverFlag == 1)
        : (isActive &&
            joiningDateParsed != null &&
            DateTime.now().difference(joiningDateParsed).inDays >= (5 * 365));

    return EmployeeModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString(),
      department: json['department']?.toString() ?? 'General',
      designation: json['designation']?.toString() ?? 'Team Member',
      avatarUrl: json['avatar_url']?.toString(),
      joiningDate: joiningDateParsed,
      isActive: isActive,
      tenureYears: (json['tenure_years'] as num?)?.toDouble() ?? 0.0,
      tenureDisplay: json['tenure_display']?.toString() ?? '',
      isFlaggedGreen: computedFlag,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'department': department,
      'designation': designation,
      'avatar_url': avatarUrl,
      'joining_date': joiningDate?.toIso8601String().substring(0, 10),
      'is_active': isActive,
      'tenure_years': tenureYears,
      'tenure_display': tenureDisplay,
      'is_flagged_green': isFlaggedGreen,
    };
  }
}
