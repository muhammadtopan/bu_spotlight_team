<?php

namespace App\Http\Controllers\Mitra;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class StockController extends Controller
{
    public function fetch()
    {
        $stock = \App\Models\ProductUser::with('product')->where('user_id', auth()->user()->id)->get();
        return [
            'data' => $stock,
            'status' => 'success'
        ];
    }

    public function fetchFirstMonth(){
        try {
            $c = new \Carbon\Carbon;
            $c = $c->now();
    
            $cek = \App\Models\ProductUserHistory::where([
                            ['user_id', auth()->user()->id],
                            ['type', 'first']
                        ])
                    ->orderBy('created_at','desc')
                    ->limit(1)
                    ->get()[0];
    
            $date = $cek->created_at;
            $year = date('Y', strtotime($date));
            $month = date('m', strtotime($date));
            $stock = \App\Models\ProductUserHistory::with('product')->where([
                            ['user_id', auth()->user()->id],
                            ['type', 'first']
                        ])
                    ->whereYear('created_at', $year)
                    ->whereMonth('created_at', $month)
                    ->get();
    
            return [
                'data' => $stock,
                'status' => 'success'
            ];
        } catch (\Throwable $th) {
            return [
                'message' => $th->getMessage(),
                'status' => 'error'
            ];
        }
    }

    private function verificationLastStock(){
        $c = new \Carbon\Carbon;
        $c = $c->now();

        $cek = \App\Models\ProductUserHistory::where('user_id', auth()->user()->id)->whereMonth('created_at', $c->month)->whereYear('created_at', $c->year)->count();
        // ### testing ###
        if(((4 - $c->day) < 3) && ($cek == 0)){
    
        // ### production ###
        // if((($c->daysInMonth - $c->day) < 3) && ($cek == 0)){
            return true;
        }
        return false;
    }

    public function fetchLastMonth(){
        $c = new \Carbon\Carbon;
        $c = $c->now();

        $stock = \App\Models\ProductUser::with('product')->where('user_id', auth()->user()->id)->get();

        $verification = $this->verificationLastStock();

        return [
            'data' => [
                'stock' => $stock,
                'verification' => $verification
            ],
            'status' => 'success'
        ];
    }

    public function addStockLastMonth(Request $r){
        try {
            $verification = $this->verificationLastStock();
            if($verification == false || $verification == 0){
                return [
                    'status' => 'failed',
                    'message' => 'Anda tidak dapat menambahkan stock last month ini'
                ];
            }

            // return $r->all();
            foreach ($r->all() as $data_r) {   
                $pu = \App\Models\ProductUser::where('user_id', auth()->user()->id)->where('product_id', $data_r['product_id'])->first();

                \App\Models\ProductUserHistory::create([
                    'product_id' => $pu->product_id,
                    'user_id' => $pu->user_id,
                    'price' => $pu->price,
                    'stock' => $pu->stock,
                    'type' => 'last'
                ]);

                $pu->stock = $data_r['edit_stock'];
                $pu->save();

                \App\Models\ProductUserHistory::create([
                    'product_id' => $pu->product_id,
                    'user_id' => $pu->user_id,
                    'price' => $pu->price,
                    'stock' => $pu->stock,
                    'type' => 'first'
                ]);
            }

            return [
                'data' => 'Berhasil menambah stok last month!',
                'status' => 'success'
            ]; 
        } catch (\Throwable $th) {
            return [
                'status' => 'error',
                'message' => $th->getMessage()
            ];
        }
    }

    public function leaderFetch(){
        $relation = auth()->user()->relation_id;

        $cek_leader = 0;
        \DB::select("DROP PROCEDURE IF EXISTS cekLeader;");
        \DB::select("CREATE PROCEDURE cekLeader() 
        BEGIN 
            DECLARE data_id BIGINT; 
            DECLARE data_relation BIGINT DEFAULT 0; 
            DECLARE cek INT DEFAULT 0; 
            DECLARE hasil INT DEFAULT 0; 
            SET data_id = 2022082701003; 
            WHILE cek < 1 DO 
                SELECT level, relation_id INTO hasil, data_relation FROM `users` WHERE id=data_id; 
                IF hasil != 0 THEN 
                    SET data_id = data_relation; 
                ELSE 
                    SELECT id, level FROM `users` WHERE id=data_id; 
                    SET cek = cek + 1; 
                END IF; 
            END WHILE; 
        END;");  
        $distributor_id = \DB::select("CALL cekLeader();")[0]->id;
        \DB::select("DROP PROCEDURE IF EXISTS cekLeader;");
        $leader_data = \App\Models\User::where('id', $distributor_id)->get()[0];
        $disc = \App\Models\RoleDiscount::get();
        
        // $level = auth()->user()->level;
        // for ($i=0; $i<$level; $i++) { 
        //     $new_leader = \App\Models\User::where('id', $relation)->get()[0];
        //     $relation = $new_leader->relation_id;
        //     if ($new_leader->role == 'distributor') {
        //         $i = $level;    
        //     }
        // }

        $stock_distributor = \App\Models\ProductUser::with('product')->where('user_id', $distributor_id)->get();
        $bank = \App\Models\Bank::where('id','!=',1)->get();

        return [
            'data' => [
                'leader' => $leader_data,
                'stock' => $stock_distributor,
                'disc' => $disc,
                'bank' => $bank
            ],
            'status' => 'success'
        ]; 
    }

    public function add(Request $r){
        try {
            $cek = 0;
            foreach($r->data['stock'] as $d){
                if($d['ro']>0){
                    $cek = 1;
                }
            }
            if($cek == 0){
                return [
                    'status' => 'failed',
                    'message' => 'Tidak ada data yang diinput'
                ];
            }

            $discount = \App\Models\RoleDiscount::orderBy('discount_up','desc')->get();
            
            // $discount = $leader->discount;
            $subtotal = 0;
            $total = 0;

            try{
                \DB::beginTransaction();
                $transaction = \App\Models\Transaction::create([
                    'user_id' => auth()->user()->id,
                    'seller_id' => $r->data['leader']['id'],
                    'type' => $r->type,
                    'bank_id' => $r->bank=='transfer'? $r->bank:1,
                    'status' => 'pending',
                    'subtotal' => 0,
                    'discount' => 0,
                    'total' => 0,
                ]);
                foreach($r->data['stock'] as $d){
                    if($d['ro']>0){
                        $product_leader = \App\Models\ProductUser::where([
                                        ['user_id',$r->data['leader']['id']],
                                        ['product_id',$d['product_id']]
                                    ])->first();
                        if($d['ro'] <= $product_leader->stock){
                            $subtotal_unit = $d['ro']*$product_leader->price;
    
                            $transaction_detail = \App\Models\TransactionDetail::create([
                                'transaction_id' => $transaction->id,
                                'product_user_id' => $product_leader->id,
                                'ro' => $d['ro'],
                                'subtotal' => $subtotal_unit
                            ]);
    
                            $subtotal += $subtotal_unit;
                        }
                    }
                }
                foreach($discount as $d){
                    if($subtotal > $d->price_discount_up){
                        $discount = $d->discount_up;
                        break 1;
                    }
                }

                $total = $subtotal - ($subtotal*$discount);
    
                $transaction->subtotal = $subtotal;
                $transaction->discount = $discount;
                $transaction->total = $total;
                $transaction->save();
                \DB::commit();
                return [
                    'data' => 'Berhasil menambah stok!',
                    'status' => 'success'
                ];
            }
            catch(\Exception $e){
                \DB::rollback();
                // throw $e;
                return [
                    // 'data' => $subtotal,
                    'data' => $e,
                    'status' => 'error'
                ];
            }
        } catch (\Throwable $th) {
            return [
                'data' => $th->getMessage(),
                'status' => 'error'
            ];
        }
        
    }
}
