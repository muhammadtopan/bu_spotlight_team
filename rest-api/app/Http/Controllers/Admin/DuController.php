<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class DuController extends Controller
{
    public function fetch()
    {
        $user = \App\Models\User::with('user_profile')->where('role','distributor')->get();
        return [
            'data' => $user,
            'status' => 'success'
        ];
    }

    public function add(Request $r){
        try {
            $r->phone = str_replace(' ', '', $r->phone);
            $r->phone = str_replace('-', '', $r->phone);
            $r->phone = str_replace('+', '', $r->phone);
            $r->phone = str_replace('(', '', $r->phone);
            $r->phone = str_replace(')', '', $r->phone);
            if (substr($r->phone,0,2) == '08') {
                $r->phone = '628'.substr($r->phone,2);
            }
            
            $dt = \Carbon\Carbon::now();

            $cek_user = \App\Models\User::whereDate('created_at', '=', $dt->format('Y-m-d'))->count()+1;
            $make_id = $dt->format('Ymd').(strlen($cek_user) < 2 ? '0' : '').$cek_user;

            $user = new \App\Models\User;
            $user->id = $make_id;
            $user->name = ucwords(strtolower($r->name));
            $user->password = \Illuminate\Support\Facades\Hash::make('team45');
            $user->role = 'distributor';
            $user->level = 0;
            $user->save();

            $user_profile = new \App\Models\UserProfile;
            $user_profile->user_id = $user->id;
            $user_profile->name = $user->name;
            $user_profile->phone = $r->phone;
            $user_profile->save();

            return [
                'data' => [
                    'user' => $user,
                    'user_profile' => $user_profile
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
    public function updateStatus(Request $r){
        try {
            $user = \App\Models\User::find($r->id);
            if($user->status == 'request'){
                if($r->status == 'active'){
                    $user->status = 'active';
                    $user->relation_id = 1;
                    $user->activated_at = date('Y-m-d H:i:s');
                    $user->save();
                    return [
                        'data' => 'Distributor '.$user->name.' berhasil diaktifkan', 
                        'status' => 'success'
                    ];
                }
                if($r->status == 'inactive'){
                    $user->status = 'inactive';
                    $user->save();
                    return [
                        'data' => 'Distributor '.$user->name.' berhasil ditolak', 
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
    public function delete(Request $r){
        try {
            $user = \App\Models\User::find($r->id);
            $user->delete();
            return [
                'data' => "Success delete user ".$user->name,
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
