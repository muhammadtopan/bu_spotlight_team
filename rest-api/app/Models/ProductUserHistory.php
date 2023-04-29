<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductUserHistory extends Model
{
    protected $guarded = [];
    
    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    public function user()
    {
        return $this->hasMany(User::class);
    }
}
