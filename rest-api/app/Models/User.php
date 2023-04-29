<?php

namespace App\Models;

use Illuminate\Auth\Authenticatable;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Lumen\Auth\Authorizable;
use Laravel\Passport\HasApiTokens;

class User extends Model implements AuthenticatableContract, AuthorizableContract
{
    use Authenticatable, Authorizable, HasFactory, HasApiTokens;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id',
        'name', 
        'phone', 
        'email', 
        'password', 
        'status', 
        'role', 
        'relation_id', 
        'level', 
        'view_admin', 
        'night_mode', 
        'activated_at',
        'created_at',
        'updated_at'
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        'password',
    ];

    public function user_profile(){
        return $this->belongsTo(UserProfile::class, 'id', 'user_id');
    }

    public function product_user(){
        return $this->belongsTo(ProductUser::class, 'id', 'user_id');
    }

    public function product_user_in_out(){
        return $this->belongsTo(ProductUserInOut::class, 'id', 'user_id');
    }

    public function role_discount(){
        return $this->hasOne(RoleDiscount::class, 'name', 'role');
    }

    public function transaction(){
        return $this->hasMany(Transaction::class, 'seller_id', 'id');
    }
}
