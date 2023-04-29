<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductUser extends Model
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

    public function transaction_detail()
    {
        return $this->belongsTo(TransactionDetail::class);
    }
}
