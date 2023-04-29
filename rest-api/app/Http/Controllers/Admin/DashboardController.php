<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(){
        try {
            $user = \App\Models\User::count();
            $user_active = \App\Models\User::where('status','active')->count();
            $user_inactive = \App\Models\User::where('status','inactive')->count();
            $user_request = \App\Models\User::where('status','request')->count();
            $user_distributor = \App\Models\User::where([
                                    ['status','active'],
                                    ['role','distributor']
                                ])->count();
            $product = \App\Models\Product::count();
            return [
                'data' => [
                    'users' => $user,
                    'user_active' => $user_active,
                    'user_inactive' => $user_inactive,
                    'user_request' => $user_request,
                    'user_distributor' => $user_distributor,
                    'product' => $product
                ], 
                'status' => 'success'
            ];
        } catch (\Throwable $th) {
            return [
                'data' => $th->getMessage(), 
                'status' => 'error'
            ];
        }
    }
}
