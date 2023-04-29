<?php

namespace App\Http\Controllers\Mitra;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class ExpensesController extends Controller
{
    public function fetch(){
        try {
            $c = new \Carbon\Carbon;
            $c = $c->now();
    
            $awal = \App\Models\Expenses::select('created_at')
                    ->where('user_id', auth()->user()->id)
                    ->orderBy('created_at', 'asc');
            if($awal->count()>0){
                $awal = $awal->limit(1)->get()[0];
                $count = $c->year - $awal->created_at->year;
            }else{
                $count = 0;
            }
            
            $year_old = $c->year;
            $year = array();
            for ($i=0; $i <= $count; $i++) {
                $year[$i] = $year_old;
                $year_old--;
            }
    
            $expenses = \App\Models\Expenses::where('user_id', auth()->user()->id)
                            ->whereMonth('created_at', $c->month)
                            ->whereYear('created_at', $c->year)
                            ->get();
            return [
                'data' => [
                    'expenses' => $expenses,
                    'year' => $year
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
    public function addExpenses(Request $r){
        try {
            if($r->type_trans=='transfer'){
                \App\Models\Expenses::create([
                    'user_id' => auth()->user()->id,
                    'item' => $r->item,
                    'category' => $r->category,
                    'nominal' => $r->nominal,
                    'type_trans' => $r->type_trans,
                    'bank' => $r->bank,
                    'created_at' => $r->created_at
                ]);
            }else{
                \App\Models\Expenses::create([
                    'user_id' => auth()->user()->id,
                    'item' => $r->item,
                    'category' => $r->category,
                    'nominal' => $r->nominal,
                    'type_trans' => $r->type_trans,
                    'created_at' => $r->created_at
                ]);
            }

            return [
                'data' => 'Berhasil Input Pengeluaran.',
                'status' => 'success'
            ];
        } catch (\Throwable $th) {
            return [
                'data' => $th->getMessage(),
                'status' => 'error'
            ];
        }
    }

    public function update(Request $r){
        try {
            $expenses = \App\Models\Expenses::find($r->id);
            $expenses->item = $r->item;
            $expenses->category = $r->category;
            $expenses->nominal = $r->nominal;
            $expenses->type_trans = $r->type_trans;
            if($r->type_trans=='transfer'){
                $expenses->bank = $r->bank;
            }else {
                $expenses->bank = NULL;
            }
            $expenses->created_at = $r->pre_created_at;
            $expenses->save();
            return [
                'data' => 'Berhasil Update Pengeluaran.',
                'status' => 'success'
            ];
        } catch (\Throwable $th) {
            return [
                'data' => $th->getMessage(),
                'status' => 'error'
            ];
        }
    }

    public function filter(Request $r){
        try {
            $expenses = \App\Models\Expenses::where('user_id', auth()->user()->id)
                        ->whereMonth('created_at', $r->month)
                        ->whereYear('created_at', $r->year)
                        ->get();
            return [
                'data' => $expenses,
                'status' => 'success'
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
            \App\Models\Expenses::where('id', $r->id)->delete();
            return [
                'data' => 'Berhasil Hapus Pengeluaran.',
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
