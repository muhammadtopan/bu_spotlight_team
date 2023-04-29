<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TransactionDetail extends Model
{
    protected $guarded = [];
    public $timestamps = false;

    public function transaction(){
        return $this->belongsTo(Transaction::class);
    }

    public function product_user(){
        return $this->belongsTo(ProductUser::class);
    }
}
