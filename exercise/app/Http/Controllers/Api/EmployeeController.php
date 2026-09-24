<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\EmployeeResource;
use App\Models\Employee;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Validation\Rule;

class EmployeeController extends Controller
{
    /**
     * Display a listing of employees.
     * Supports search, department filter, active filter, and green flag filter.
     */
    public function index(Request $request): JsonResponse
    {
        $query = Employee::query();

        // Optional search term
        if ($request->filled('search')) {
            $query->search($request->input('search'));
        }

        // Optional department filter
        if ($request->filled('department')) {
            $query->department($request->input('department'));
        }

        // Optional active status filter (e.g. ?is_active=1 or ?is_active=0)
        if ($request->has('is_active')) {
            $query->where('is_active', filter_var($request->input('is_active'), FILTER_VALIDATE_BOOLEAN));
        }

        // Optional green flag filter (?flagged_green=1)
        if ($request->boolean('flagged_green')) {
            $query->flaggedGreen();
        }

        // Sorting
        $sortBy = in_array($request->input('sort_by'), ['name', 'joining_date', 'department', 'id'])
            ? $request->input('sort_by')
            : 'name';
        $sortOrder = strtolower($request->input('sort_order', 'asc')) === 'desc' ? 'desc' : 'asc';
        $query->orderBy($sortBy, $sortOrder);

        $employees = $query->get();

        $greenFlaggedCount = $employees->where('is_flagged_green', true)->count();

        return response()->json([
            'success' => true,
            'message' => 'Employees retrieved successfully.',
            'total_count' => $employees->count(),
            'green_flagged_count' => $greenFlaggedCount,
            'data' => EmployeeResource::collection($employees),
        ]);
    }

    /**
     * Display the specified employee.
     */
    public function show(int $id): JsonResponse
    {
        $employee = Employee::find($id);

        if (!$employee) {
            return response()->json([
                'success' => false,
                'message' => 'Employee not found.',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => new EmployeeResource($employee),
        ]);
    }

    /**
     * Store a newly created employee.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255|unique:employees,email',
            'phone' => 'nullable|string|max:50',
            'department' => 'required|string|max:100',
            'designation' => 'required|string|max:100',
            'avatar_url' => 'nullable|url|max:500',
            'joining_date' => 'required|date|before_or_equal:today',
            'is_active' => 'nullable|boolean',
        ]);

        $employee = Employee::create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'phone' => $validated['phone'] ?? null,
            'department' => $validated['department'],
            'designation' => $validated['designation'],
            'avatar_url' => $validated['avatar_url'] ?? null,
            'joining_date' => $validated['joining_date'],
            'is_active' => $validated['is_active'] ?? true,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Employee created successfully.',
            'data' => new EmployeeResource($employee),
        ], 201);
    }

    /**
     * Update the specified employee.
     */
    public function update(Request $request, int $id): JsonResponse
    {
        $employee = Employee::find($id);

        if (!$employee) {
            return response()->json([
                'success' => false,
                'message' => 'Employee not found.',
            ], 404);
        }

        $validated = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'email' => ['sometimes', 'required', 'email', 'max:255', Rule::unique('employees')->ignore($employee->id)],
            'phone' => 'nullable|string|max:50',
            'department' => 'sometimes|required|string|max:100',
            'designation' => 'sometimes|required|string|max:100',
            'avatar_url' => 'nullable|url|max:500',
            'joining_date' => 'sometimes|required|date|before_or_equal:today',
            'is_active' => 'sometimes|required|boolean',
        ]);

        $employee->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Employee updated successfully.',
            'data' => new EmployeeResource($employee),
        ]);
    }

    /**
     * Remove the specified employee.
     */
    public function destroy(int $id): JsonResponse
    {
        $employee = Employee::find($id);

        if (!$employee) {
            return response()->json([
                'success' => false,
                'message' => 'Employee not found.',
            ], 404);
        }

        $employee->delete();

        return response()->json([
            'success' => true,
            'message' => 'Employee deleted successfully.',
        ]);
    }

    /**
     * Return summary metrics for Flutter dashboard widgets.
     */
    public function summary(): JsonResponse
    {
        $total = Employee::count();
        $active = Employee::where('is_active', true)->count();
        $inactive = Employee::where('is_active', false)->count();
        $flaggedGreen = Employee::flaggedGreen()->count();

        return response()->json([
            'success' => true,
            'data' => [
                'total_employees' => $total,
                'active_employees' => $active,
                'inactive_employees' => $inactive,
                'flagged_green_employees' => $flaggedGreen,
            ],
        ]);
    }
}
