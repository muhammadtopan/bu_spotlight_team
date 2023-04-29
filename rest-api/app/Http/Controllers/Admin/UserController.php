<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function fetch()
    {
        $user = \App\Models\User::with('user_profile')->get();
        $total = \App\Models\User::count();
        $request = \App\Models\User::where('status', 'request')->count();
        $active = \App\Models\User::where('status', 'active')->count();
        $inactive = \App\Models\User::where('status', 'inactive')->count();

        return [
            'data' => [
                'user' => $user,
                'total' => $total,
                'request' => $request,
                'active' => $active,
                'inactive' => $inactive
            ],
            'status' => 'success'
        ];
    }

    public function updateViewAdmin(Request $r){
        $user = \App\Models\User::find($r->id);
        $user->view_admin = 1;
        $user->save();

        return [
            'data' => $user,
            'status' => 'success'
        ];
    }

    public function updateStatus(Request $r){
        try {
            $user = \App\Models\User::find($r->id);
            if($user->status == 'request'){
                if($r->status == 'active'){
                    $user->status = 'active';
                    $user->activated_at = date('Y-m-d H:i:s');
                    $user->save();
                    return [
                        'data' => $user->role.' '.$user->name.' berhasil diaktifkan', 
                        'status' => 'success'
                    ];
                }
                if($r->status == 'inactive'){
                    $user->status = 'inactive';
                    $user->save();
                    return [
                        'data' => $user->role.' '.$user->name.' berhasil ditolak', 
                        'status' => 'success'
                    ];
                }
            }
            return [
                'data' => 'no action', 
                'status' => 'error'
            ];
        } catch (\Throwable $th) {
            return [
                'data' => $th->getMessage(), 
                'status' => 'error'
            ];
        }
    }
}
