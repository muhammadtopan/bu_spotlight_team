<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TransactionNote extends Model
{
    protected $guarded = [];
    public $timestamps = false;

    public function transaction(){
        return $this->belongsTo(Transaction::class);
    }
}
