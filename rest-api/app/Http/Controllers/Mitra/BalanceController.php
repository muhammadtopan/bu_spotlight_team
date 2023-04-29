<?php

namespace App\Http\Controllers\Mitra;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class BalanceController extends Controller
{
    public function fetch(){
        $bank = \App\Models\Bank::get();
        $balance = [];
        $i = 0;
        foreach($bank as $b){
            $cek = 0;
            $cek = \App\Models\Balance::where('user_id', auth()->user()->id)
                    ->where('bank_id', $b->id)
                    ->count();
            if($cek>0){
                $balance[$i++] = [
                                    'sum' => \App\Models\Balance::where('user_id', auth()->user()->id)
                                            ->where('bank_id', $b->id)
                                            ->sum('amount'),
                                    'bank' => $b->bank,
                                    'logo' => $b->logo
                                ];
            }
        }
        return [
            'data' => $balance,
            'status' => 'success'
        ];
    }

    public function detailFetch(Request $r){
        $bank = \App\Models\Bank::where('bank', $r->bank)->first();
        $balance = \App\Models\Balance::where('user_id', auth()->user()->id)
                            ->where('bank_id', $bank->id)
                            ->get();
        $sum = \App\Models\Balance::where('user_id', auth()->user()->id)
                ->where('bank_id', $bank->id)
                ->sum('amount');
        unset($balance[0]);
        return [
            'data' => [
                'mutation' => $balance,
                'sum' => $sum
            ],
            'status' => 'success'
        ];
    }

    public function submitAdd(Request $r){
        $bank = \App\Models\Bank::where('bank', $r->bank)->first();
        \App\Models\Balance::create([
            'user_id' => auth()->user()->id,
            'bank_id' => $bank->id,
            'amount' => $r->price>0 ? $r->price : NULL,
            'title' => 'Debit',
            'description' => 'Tambah saldo Rp '.number_format($r->price,0,',','.').' dari admin',
            'created_at' => $r->date
        ]);
        return [
            'data' => 'Berhasil tambah saldo dalam keadaan pending',
            'status' => 'success'
        ];
    }
}
