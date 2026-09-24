<?php

namespace Database\Seeders;

use App\Models\Employee;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class EmployeeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     * Generates a realistic set of employees covering:
     * 1. Active & > 5 yrs tenure  -> Flagged in Green (True)
     * 2. Active & < 5 yrs tenure  -> Not Flagged (False)
     * 3. Inactive & > 5 yrs tenure -> Not Flagged (False)
     * 4. Inactive & < 5 yrs tenure -> Not Flagged (False)
     */
    public function run(): void
    {
        $now = Carbon::now();

        $employees = [
            // -----------------------------------------------------------
            // GROUP 1: Active & > 5 years tenure (SHOULD BE FLAGGED GREEN)
            // -----------------------------------------------------------
            [
                'name' => 'Sophia Rodriguez',
                'email' => 'sophia.rodriguez@example.com',
                'phone' => '+1-555-0101',
                'department' => 'Engineering',
                'designation' => 'VP of Engineering',
                'avatar_url' => 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subYears(7)->subMonths(3)->toDateString(), // ~7.25 yrs
                'is_active' => true,
            ],
            [
                'name' => 'Liam Chen',
                'email' => 'liam.chen@example.com',
                'phone' => '+1-555-0102',
                'department' => 'Engineering',
                'designation' => 'Staff Backend Architect',
                'avatar_url' => 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subYears(6)->subMonths(8)->toDateString(), // ~6.6 yrs
                'is_active' => true,
            ],
            [
                'name' => 'Olivia Smith',
                'email' => 'olivia.smith@example.com',
                'phone' => '+1-555-0103',
                'department' => 'Human Resources',
                'designation' => 'HR Director',
                'avatar_url' => 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subYears(8)->subMonths(1)->toDateString(), // ~8.1 yrs
                'is_active' => true,
            ],
            [
                'name' => 'Noah Williams',
                'email' => 'noah.williams@example.com',
                'phone' => '+1-555-0104',
                'department' => 'DevOps & Cloud',
                'designation' => 'Lead Infrastructure Engineer',
                'avatar_url' => 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subYears(5)->subMonths(6)->toDateString(), // ~5.5 yrs
                'is_active' => true,
            ],
            [
                'name' => 'Emma Johnson',
                'email' => 'emma.johnson@example.com',
                'phone' => '+1-555-0105',
                'department' => 'Product',
                'designation' => 'Head of Product',
                'avatar_url' => 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subYears(9)->toDateString(), // 9.0 yrs
                'is_active' => true,
            ],

            // -----------------------------------------------------------
            // GROUP 2: Active & < 5 years tenure (NOT FLAGGED)
            // -----------------------------------------------------------
            [
                'name' => 'Ethan Brown',
                'email' => 'ethan.brown@example.com',
                'phone' => '+1-555-0106',
                'department' => 'Engineering',
                'designation' => 'Senior Flutter Engineer',
                'avatar_url' => 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subYears(2)->subMonths(4)->toDateString(), // ~2.3 yrs
                'is_active' => true,
            ],
            [
                'name' => 'Ava Davis',
                'email' => 'ava.davis@example.com',
                'phone' => '+1-555-0107',
                'department' => 'Design',
                'designation' => 'Lead UI/UX Designer',
                'avatar_url' => 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subYears(1)->subMonths(9)->toDateString(), // ~1.75 yrs
                'is_active' => true,
            ],
            [
                'name' => 'Mason Miller',
                'email' => 'mason.miller@example.com',
                'phone' => '+1-555-0108',
                'department' => 'Engineering',
                'designation' => 'Full Stack Developer',
                'avatar_url' => 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subYears(3)->subMonths(11)->toDateString(), // ~3.9 yrs
                'is_active' => true,
            ],
            [
                'name' => 'Isabella Wilson',
                'email' => 'isabella.wilson@example.com',
                'phone' => '+1-555-0109',
                'department' => 'Product',
                'designation' => 'Product Manager',
                'avatar_url' => 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subYears(4)->subMonths(2)->toDateString(), // ~4.1 yrs
                'is_active' => true,
            ],
            [
                'name' => 'Lucas Martinez',
                'email' => 'lucas.martinez@example.com',
                'phone' => '+1-555-0110',
                'department' => 'Quality Assurance',
                'designation' => 'QA Automation Engineer',
                'avatar_url' => 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subMonths(7)->toDateString(), // ~0.6 yrs
                'is_active' => true,
            ],

            // -----------------------------------------------------------
            // GROUP 3: Inactive & > 5 years tenure (NOT FLAGGED - Left Company)
            // -----------------------------------------------------------
            [
                'name' => 'Alexander Taylor',
                'email' => 'alexander.taylor@example.com',
                'phone' => '+1-555-0111',
                'department' => 'Engineering',
                'designation' => 'Former Principal Architect',
                'avatar_url' => 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subYears(7)->toDateString(), // 7 yrs, but inactive
                'is_active' => false,
            ],
            [
                'name' => 'Mia Anderson',
                'email' => 'mia.anderson@example.com',
                'phone' => '+1-555-0112',
                'department' => 'Marketing',
                'designation' => 'Former Growth Lead',
                'avatar_url' => 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subYears(6)->subMonths(3)->toDateString(), // 6.2 yrs, but inactive
                'is_active' => false,
            ],

            // -----------------------------------------------------------
            // GROUP 4: Inactive & < 5 years tenure (NOT FLAGGED)
            // -----------------------------------------------------------
            [
                'name' => 'Benjamin Thomas',
                'email' => 'benjamin.thomas@example.com',
                'phone' => '+1-555-0113',
                'department' => 'Sales',
                'designation' => 'Former Account Executive',
                'avatar_url' => 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150&auto=format&fit=crop&q=80',
                'joining_date' => $now->copy()->subYears(1)->subMonths(2)->toDateString(),
                'is_active' => false,
            ],
        ];

        foreach ($employees as $data) {
            Employee::updateOrCreate(
                ['email' => $data['email']],
                $data
            );
        }
    }
}
