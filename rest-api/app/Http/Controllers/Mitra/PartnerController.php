<?php

namespace App\Http\Controllers\Mitra;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class PartnerController extends Controller
{
    private function multySeries($id){
        $partner = [];
        $user = \App\Models\User::with('user_profile')->where('relation_id', $id)->get();
        foreach($user as $u){
            if ($u->count() > 0 && count($this->multySeries($u->id)) > 0){
                foreach ($this->multySeries($u->id) as $ms) {
                    array_push($partner, $ms);
                }
            }
            array_push($partner, $u);
        }
        return $partner;
    }

    public function fetch(){
        $partner = $this->multySeries(auth()->user()->id);
        return [
            'data' => $partner,
            'status' => 'success'
        ];
    }

    public function add(Request $r){
        try {
            \DB::beginTransaction();
            $r->phone = str_replace(' ', '', $r->phone);
            $r->phone = str_replace('-', '', $r->phone);
            $r->phone = str_replace('+', '', $r->phone);
            $r->phone = str_replace('(', '', $r->phone);
            $r->phone = str_replace(')', '', $r->phone);
            if (substr($r->phone,0,2) == '08') {
                $r->phone = '628'.substr($r->phone,2);
            }
            $user = \App\Models\User::create([
                'email' => strtolower($r->email),
                'name' => ucwords(strtolower($r->name)),
                'password' => \Illuminate\Support\Facades\Hash::make('team45'),
                'role' => $r->role,
                'status' => 'request',
                'level' => (auth()->user()->level+1),
                'relation_id' => auth()->user()->id
            ]);
            $user->user_profile()->create([
                'user_id' => $user->id,
                'name' => ucwords(strtolower($r->name)),
                'phone' => $r->phone,
                'domicile' => $r->domicile
            ]);
            
            $data = \App\Models\User::with('user_profile')->where('id', $user->id)->first();
            \DB::commit();
            return [
                // 'data'=>$r->all(),
                'data' => $data,
                'status' => 'success'
            ]; 
        } catch (\Throwable $th) {
            \DB::rollback();
            return [
                'status' => 'error',
                'message' => $th->getMessage()
            ];
        }
    }
}
