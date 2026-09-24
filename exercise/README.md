# Employee Directory - PHP Laravel Backend API

A robust, production-ready REST API backend built with **PHP Laravel** to power the **Flutter Employee Directory App**.

---

## 📋 Business Logic & Requirements

> **Core Requirement**: Any employee who has been with the organization for **more than 5 years** AND is **currently active** must be flagged in **green color** in the UI.

The API handles this calculation server-side and exposes both raw fields and convenient computed attributes in the JSON payload:
- `is_active` (`bool`): Whether the employee is actively employed.
- `joining_date` (`string` YYYY-MM-DD): The date the employee joined the company.
- `tenure_years` (`float`): Exact tenure in decimal years.
- `tenure_display` (`string`): Human-readable tenure (e.g., `"6 yrs 8 mos"`).
- `is_flagged_green` (`bool`): Precomputed flag (`true` if `is_active == true` **and** tenure > 5 years).

---

## 🚀 Quick Start Guide

### 1. Prerequisites
- **PHP** >= 8.2 (with `pdo_sqlite` or `pdo_mysql`, `curl`, `mbstring`, `openssl` extensions enabled)
- **Composer** (PHP package manager)

### 2. Installation & Setup

Open your terminal in this directory (`e:\exercise`):

```bash
# 1. Create environment file from template
copy .env.example .env      # On Windows (cmd)
# or: cp .env.example .env   # On PowerShell / Linux / macOS

# 2. Install PHP dependencies
composer install

# 3. Generate application encryption key
php artisan key:generate

# 4. Run migrations and seed sample test data
php artisan migrate --seed

# 5. Start the local development server
php artisan serve
```

The server will start at: **`http://127.0.0.1:8000`**

---

## 🗄️ Database & Pre-Seeded Test Scenarios

The backend is configured out of the box with **SQLite** (`database/database.sqlite`), requiring **zero database server setup**. You can also switch to MySQL or PostgreSQL at any time by editing `.env`.

When you run `php artisan migrate --seed`, the database is populated with realistic employees covering all 4 test permutations:

| Group | Condition | Count | Expected `is_flagged_green` | Flutter UI Treatment |
|---|---|:---:|:---:|---|
| **1** | **Active & > 5 yrs tenure** | 5 | `true` | **Flagged in Green** 🟢 |
| **2** | **Active & < 5 yrs tenure** | 5 | `false` | Normal card / default color ⚪ |
| **3** | **Inactive & > 5 yrs tenure** | 2 | `false` | Normal card / inactive badge ⚪ |
| **4** | **Inactive & < 5 yrs tenure** | 1 | `false` | Normal card / inactive badge ⚪ |

---

## 📡 API Endpoints

### Base URL: `http://localhost:8000/api`

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/employees` | List all employees (supports filtering and search) |
| `GET` | `/api/employees/summary` | Dashboard summary metrics (counts of total, active, green flagged) |
| `GET` | `/api/employees/{id}` | Retrieve details of a single employee |
| `POST` | `/api/employees` | Create a new employee record |
| `PUT` | `/api/employees/{id}` | Update an existing employee record |
| `DELETE` | `/api/employees/{id}` | Delete an employee record |

---

### Query Parameters for `GET /api/employees`

- `flagged_green=1`: Filter only employees eligible for green highlighting.
- `is_active=1` or `is_active=0`: Filter by active or inactive status.
- `department=Engineering`: Filter by specific department.
- `search=Sophia`: Search by name, email, or designation.
- `sort_by=joining_date` (`name`, `joining_date`, `department`, `id`): Sort column.
- `sort_order=desc` (`asc` or `desc`): Sort direction.

---

### Sample Response (`GET /api/employees`)

```json
{
  "success": true,
  "message": "Employees retrieved successfully.",
  "total_count": 13,
  "green_flagged_count": 5,
  "data": [
    {
      "id": 1,
      "name": "Sophia Rodriguez",
      "email": "sophia.rodriguez@example.com",
      "phone": "+1-555-0101",
      "department": "Engineering",
      "designation": "VP of Engineering",
      "avatar_url": "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&auto=format&fit=crop&q=80",
      "joining_date": "2019-06-23",
      "is_active": true,
      "tenure_years": 7.3,
      "tenure_display": "7 yrs 3 mos",
      "is_flagged_green": true,
      "created_at": "2026-09-23T14:35:00.000000Z",
      "updated_at": "2026-09-23T14:35:00.000000Z"
    },
    {
      "id": 6,
      "name": "Ethan Brown",
      "email": "ethan.brown@example.com",
      "phone": "+1-555-0106",
      "department": "Engineering",
      "designation": "Senior Flutter Engineer",
      "avatar_url": "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=150&auto=format&fit=crop&q=80",
      "joining_date": "2024-05-23",
      "is_active": true,
      "tenure_years": 2.3,
      "tenure_display": "2 yrs 4 mos",
      "is_flagged_green": false,
      "created_at": "2026-09-23T14:35:00.000000Z",
      "updated_at": "2026-09-23T14:35:00.000000Z"
    }
  ]
}
```

---

## 📱 Flutter Client Integration Guide

### 1. Network Host Notes for Flutter
Depending on your Flutter target, adjust the API host URL:
- **Android Emulator**: `http://10.0.2.2:8000/api` (points to your PC host)
- **iOS Simulator / macOS / Windows / Flutter Web**: `http://127.0.0.1:8000/api`
- **Physical Device**: `http://<YOUR_LOCAL_IP>:8000/api` (e.g. `http://192.168.1.100:8000/api`)

---

### 2. Dart Model (`employee.dart`)

```dart
class Employee {
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

  Employee({
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

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      department: json['department'] as String,
      designation: json['designation'] as String,
      avatarUrl: json['avatar_url'] as String?,
      joiningDate: json['joining_date'] != null
          ? DateTime.tryParse(json['joining_date'] as String)
          : null,
      isActive: json['is_active'] == true,
      tenureYears: (json['tenure_years'] as num?)?.toDouble() ?? 0.0,
      tenureDisplay: json['tenure_display'] as String? ?? '',
      // Directly consume the server-side computed green flag or compute locally
      isFlaggedGreen: json['is_flagged_green'] == true,
    );
  }
}
```

---

### 3. Flutter API Service (`employee_service.dart`)

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'employee.dart';

class EmployeeService {
  // Replace with 10.0.2.2 for Android emulator or your computer's IP for physical devices
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<Employee>> fetchEmployees({String? search, bool? flaggedGreenOnly}) async {
    final queryParams = <String, String>{};
    if (search != null && search.isNotEmpty) queryParams['search'] = search;
    if (flaggedGreenOnly == true) queryParams['flagged_green'] = '1';

    final uri = Uri.parse('$baseUrl/employees').replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List data = jsonResponse['data'];
      return data.map((item) => Employee.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load employees: ${response.statusCode}');
    }
  }
}
```

---

### 4. Flutter UI Component (`employee_list_screen.dart`)

```dart
import 'package:flutter/material.dart';
import 'employee.dart';
import 'employee_service.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final EmployeeService _service = EmployeeService();
  late Future<List<Employee>> _employeesFuture;
  bool _filterOnlyGreen = false;

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  void _loadEmployees() {
    setState(() {
      _employeesFuture = _service.fetchEmployees(flaggedGreenOnly: _filterOnlyGreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Directory'),
        actions: [
          FilterChip(
            label: const Text('>5 Yrs Active (Green)'),
            selected: _filterOnlyGreen,
            selectedColor: Colors.green.shade200,
            onSelected: (selected) {
              setState(() {
                _filterOnlyGreen = selected;
                _loadEmployees();
              });
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _loadEmployees(),
        child: FutureBuilder<List<Employee>>(
          future: _employeesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No employees found.'));
            }

            final employees = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final emp = employees[index];
                final isGreen = emp.isFlaggedGreen;

                return Card(
                  elevation: isGreen ? 4 : 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    // Highlight green border for eligible veteran employees
                    side: BorderSide(
                      color: isGreen ? Colors.green.shade600 : Colors.grey.shade300,
                      width: isGreen ? 2.5 : 1,
                    ),
                  ),
                  // Soft green tinted background for > 5 yrs active employees
                  color: isGreen ? Colors.green.shade50 : Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: isGreen ? Colors.green.shade700 : Colors.grey.shade400,
                      backgroundImage: emp.avatarUrl != null ? NetworkImage(emp.avatarUrl!) : null,
                      child: emp.avatarUrl == null
                          ? Text(
                              emp.name.substring(0, 1),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            )
                          : null,
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            emp.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isGreen ? Colors.green.shade900 : Colors.black87,
                            ),
                          ),
                        ),
                        if (isGreen)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified, size: 14, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  '5+ Yrs Active',
                                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          '${emp.designation} • ${emp.department}',
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 13, color: Colors.grey.shade600),
                            const SizedBox(width: 4),
                            Text(
                              'Joined: ${emp.joiningDate?.toString().substring(0, 10) ?? "N/A"} (${emp.tenureDisplay})',
                              style: TextStyle(fontSize: 12, color: isGreen ? Colors.green.shade800 : Colors.grey.shade600),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: emp.isActive ? Colors.blue.shade50 : Colors.red.shade50,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                emp.isActive ? 'Active' : 'Inactive',
                                style: TextStyle(
                                  color: emp.isActive ? Colors.blue.shade700 : Colors.red.shade700,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
```

---

## 🧪 Running Automated Tests

To execute the unit and feature tests verifying green flag logic:

```bash
php artisan test
# or:
./vendor/bin/phpunit
```
