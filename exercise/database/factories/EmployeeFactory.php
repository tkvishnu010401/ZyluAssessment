<?php

namespace Database\Factories;

use App\Models\Employee;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Employee>
 */
class EmployeeFactory extends Factory
{
    protected $model = Employee::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $departments = ['Engineering', 'Product', 'Design', 'Human Resources', 'Sales', 'Marketing', 'DevOps & Cloud'];
        $designations = [
            'Software Engineer', 'Senior Software Engineer', 'Lead Architect',
            'Product Manager', 'UI/UX Designer', 'HR Specialist',
            'DevOps Engineer', 'QA Specialist', 'Account Executive',
        ];

        return [
            'name' => fake()->name(),
            'email' => fake()->unique()->safeEmail(),
            'phone' => fake()->phoneNumber(),
            'department' => fake()->randomElement($departments),
            'designation' => fake()->randomElement($designations),
            'avatar_url' => 'https://i.pravatar.cc/150?u=' . fake()->unique()->numberBetween(1, 1000),
            'joining_date' => fake()->dateTimeBetween('-10 years', 'now')->format('Y-m-d'),
            'is_active' => fake()->boolean(85), // 85% active
        ];
    }

    /**
     * Indicate that the employee is active and has served more than 5 years (Green Flagged).
     */
    public function flaggedGreen(): static
    {
        return $this->state(fn (array $attributes) => [
            'is_active' => true,
            'joining_date' => Carbon::now()->subYears(fake()->numberBetween(5, 12))->subDays(fake()->numberBetween(1, 365))->format('Y-m-d'),
        ]);
    }

    /**
     * Indicate that the employee is active but recent (< 5 years).
     */
    public function recent(): static
    {
        return $this->state(fn (array $attributes) => [
            'is_active' => true,
            'joining_date' => Carbon::now()->subYears(fake()->numberBetween(0, 4))->subDays(fake()->numberBetween(1, 364))->format('Y-m-d'),
        ]);
    }
}
