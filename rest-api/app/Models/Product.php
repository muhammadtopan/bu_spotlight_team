<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Product extends Model
{
    use HasFactory;
    protected $guarded = [];

    public function product_user(){
        return $this->belongsTo(ProductUser::class, 'id', 'product_id');
    }

    public function product_user_in_out()
    {
        return $this->belongsTo(ProductUserInOut::class);
    }
}
