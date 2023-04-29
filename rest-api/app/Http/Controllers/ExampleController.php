<?php

namespace App\Http\Controllers;

use App\Models\User;

class ExampleController extends Controller
{
    public function index()
    {
        $cek = true;
        $compare_user = [];
        $skip = 0;
        $take = 2;
        while ($cek) {
            $user_get = User::skip($skip)->limit($take)->get();
            $user_count = User::skip($skip)->limit(($take+1))->get()->count();
            // array_push($compare_user,$user_get);
            $merged = $user_get->merge($compare_user);
            $compare_user = $merged->all();
            
            if($user_count==$take){
                $cek = false;
            }else{
                $skip+=$take;
            }
        }

        return $compare_user;
    }
}
