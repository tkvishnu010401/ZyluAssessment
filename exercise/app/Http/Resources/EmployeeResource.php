<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class EmployeeResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => (int) $this->id,
            'name' => (string) $this->name,
            'email' => (string) $this->email,
            'phone' => $this->phone ? (string) $this->phone : null,
            'department' => (string) $this->department,
            'designation' => (string) $this->designation,
            'avatar_url' => $this->avatar_url ? (string) $this->avatar_url : null,
            'joining_date' => $this->joining_date ? $this->joining_date->format('Y-m-d') : null,
            'is_active' => (bool) $this->is_active,
            'tenure_years' => (float) $this->tenure_years,
            'tenure_display' => (string) $this->tenure_display,
            'is_flagged_green' => (bool) $this->is_flagged_green,
            'created_at' => $this->created_at ? $this->created_at->toIso8601String() : null,
            'updated_at' => $this->updated_at ? $this->updated_at->toIso8601String() : null,
        ];
    }
}
