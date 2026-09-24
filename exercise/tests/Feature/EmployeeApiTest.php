<?php

namespace Tests\Feature;

use App\Models\Employee;
use Carbon\Carbon;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class EmployeeApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_api_returns_all_employees(): void
    {
        Employee::factory()->count(5)->create();

        $response = $this->getJson('/api/employees');

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'success',
                     'total_count',
                     'green_flagged_count',
                     'data' => [
                         '*' => [
                             'id',
                             'name',
                             'email',
                             'department',
                             'designation',
                             'joining_date',
                             'is_active',
                             'tenure_years',
                             'tenure_display',
                             'is_flagged_green',
                         ],
                     ],
                 ]);
    }

    public function test_active_employee_with_more_than_5_years_is_flagged_green(): void
    {
        $employee = Employee::create([
            'name' => 'Veteran Active Employee',
            'email' => 'veteran@example.com',
            'department' => 'Engineering',
            'designation' => 'Staff Architect',
            'joining_date' => Carbon::now()->subYears(6)->toDateString(),
            'is_active' => true,
        ]);

        $this->assertTrue($employee->is_flagged_green);

        $response = $this->getJson("/api/employees/{$employee->id}");
        $response->assertStatus(200)
                 ->assertJsonPath('data.is_flagged_green', true);
    }

    public function test_active_employee_with_less_than_5_years_is_not_flagged_green(): void
    {
        $employee = Employee::create([
            'name' => 'Junior Active Employee',
            'email' => 'junior@example.com',
            'department' => 'Engineering',
            'designation' => 'Software Engineer',
            'joining_date' => Carbon::now()->subYears(2)->toDateString(),
            'is_active' => true,
        ]);

        $this->assertFalse($employee->is_flagged_green);

        $response = $this->getJson("/api/employees/{$employee->id}");
        $response->assertStatus(200)
                 ->assertJsonPath('data.is_flagged_green', false);
    }

    public function test_inactive_employee_with_more_than_5_years_is_not_flagged_green(): void
    {
        $employee = Employee::create([
            'name' => 'Inactive Veteran',
            'email' => 'inactive.veteran@example.com',
            'department' => 'Product',
            'designation' => 'Former Director',
            'joining_date' => Carbon::now()->subYears(7)->toDateString(),
            'is_active' => false, // Inactive!
        ]);

        $this->assertFalse($employee->is_flagged_green);

        $response = $this->getJson("/api/employees/{$employee->id}");
        $response->assertStatus(200)
                 ->assertJsonPath('data.is_flagged_green', false);
    }

    public function test_can_filter_only_green_flagged_employees(): void
    {
        // 2 flagged green
        Employee::create([
            'name' => 'Green One',
            'email' => 'g1@example.com',
            'department' => 'Engineering',
            'designation' => 'Lead',
            'joining_date' => Carbon::now()->subYears(6)->toDateString(),
            'is_active' => true,
        ]);
        Employee::create([
            'name' => 'Green Two',
            'email' => 'g2@example.com',
            'department' => 'Design',
            'designation' => 'Lead',
            'joining_date' => Carbon::now()->subYears(8)->toDateString(),
            'is_active' => true,
        ]);

        // 1 active < 5 yrs
        Employee::create([
            'name' => 'Non Green',
            'email' => 'ng1@example.com',
            'department' => 'Sales',
            'designation' => 'Rep',
            'joining_date' => Carbon::now()->subYears(2)->toDateString(),
            'is_active' => true,
        ]);

        // 1 inactive > 5 yrs
        Employee::create([
            'name' => 'Inactive Old',
            'email' => 'inactive@example.com',
            'department' => 'Sales',
            'designation' => 'Rep',
            'joining_date' => Carbon::now()->subYears(10)->toDateString(),
            'is_active' => false,
        ]);

        $response = $this->getJson('/api/employees?flagged_green=1');

        $response->assertStatus(200)
                 ->assertJsonCount(2, 'data');
    }
}
