<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Employee extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'phone',
        'department',
        'designation',
        'avatar_url',
        'joining_date',
        'is_active',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'joining_date' => 'date:Y-m-d',
        'is_active' => 'boolean',
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array<int, string>
     */
    protected $appends = [
        'is_flagged_green',
        'tenure_years',
        'tenure_display',
    ];

    /**
     * Determine if employee is eligible to be flagged in green color.
     * Rule: Must be active AND have tenure of more than 5 years.
     *
     * @return bool
     */
    public function getIsFlaggedGreenAttribute(): bool
    {
        if (!$this->is_active || !$this->joining_date) {
            return false;
        }

        // Must be more than 5 years (joining date is on or before exactly 5 years ago)
        return $this->joining_date->lte(Carbon::now()->subYears(5));
    }

    /**
     * Calculate tenure in decimal years.
     *
     * @return float
     */
    public function getTenureYearsAttribute(): float
    {
        if (!$this->joining_date) {
            return 0.0;
        }

        return round($this->joining_date->diffInDays(Carbon::now()) / 365.25, 1);
    }

    /**
     * Format tenure as human-readable string (e.g., "5 yrs 3 mos").
     *
     * @return string
     */
    public function getTenureDisplayAttribute(): string
    {
        if (!$this->joining_date) {
            return '';
        }

        $diff = $this->joining_date->diff(Carbon::now());
        $parts = [];

        if ($diff->y > 0) {
            $parts[] = "{$diff->y} " . ($diff->y === 1 ? 'yr' : 'yrs');
        }

        if ($diff->m > 0 || empty($parts)) {
            $parts[] = "{$diff->m} " . ($diff->m === 1 ? 'mo' : 'mos');
        }

        return implode(' ', $parts);
    }

    /**
     * Scope query to only active employees.
     */
    public function scopeActive(Builder $query): Builder
    {
        return $query->where('is_active', true);
    }

    /**
     * Scope query to employees flagged in green (>5 years tenure and active).
     */
    public function scopeFlaggedGreen(Builder $query): Builder
    {
        $fiveYearsAgo = Carbon::now()->subYears(5)->toDateString();

        return $query->where('is_active', true)
                     ->where('joining_date', '<=', $fiveYearsAgo);
    }

    /**
     * Scope query by department.
     */
    public function scopeDepartment(Builder $query, ?string $department): Builder
    {
        if (!empty($department)) {
            return $query->where('department', $department);
        }

        return $query;
    }

    /**
     * Scope query by search term across name, email, or designation.
     */
    public function scopeSearch(Builder $query, ?string $term): Builder
    {
        if (!empty($term)) {
            return $query->where(function (Builder $q) use ($term) {
                $q->where('name', 'like', "%{$term}%")
                  ->orWhere('email', 'like', "%{$term}%")
                  ->orWhere('designation', 'like', "%{$term}%");
            });
        }

        return $query;
    }
}
