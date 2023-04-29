<?php

namespace App\Http\Controllers\Mitra;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class SalesController extends Controller
{
    // private function multySeries($id){
    //     $partner = [];
    //     $user = \App\Models\User::with('transaction','transaction.transaction_detail')->where('relation_id', $id)->get();
    //     foreach($user as $u){
    //         if ($u->count() > 0 && count($this->multySeries($u->id)) > 0){
    //             foreach ($this->multySeries($u->id) as $ms) {
    //                 array_push($partner, $ms);
    //             }
    //         }
    //         array_push($partner, $u);
    //     }
    //     return $partner;
    // }

    private function multyTransactionSeries($id, $get_cek_relation = []){
        $get_transactions = [];
        $cek_relation = [];
        $cek_relation = array_merge($cek_relation, $get_cek_relation);
        $transaction = \App\Models\Transaction::with('transaction_detail', 'transaction_detail.product_user.product')
                ->join('users', 'transactions.user_id', '=', 'users.id')
                ->where('users.relation_id', $id)
                ->select('*', 'transactions.id as id_t', 'transactions.created_at as created_at_t')
                ->get();
        foreach($transaction as $t){
            $count_cek_relation = true;
            foreach($cek_relation as $cr){
                if ($cr == $t->id){
                    $count_cek_relation = false;
                }
            }
            if($count_cek_relation == true){
                array_push($cek_relation, $t->id);
                $multy_transaction_series = $this->multyTransactionSeries($t->id, $cek_relation);
                if ($t->count() > 0 && count($multy_transaction_series) > 0 ){
                    foreach ($multy_transaction_series as $mts) {
                        array_push($get_transactions, $mts);
                    }
                }
            }
            array_push($get_transactions, $t);
        }
        return $get_transactions;
    }

    // public function fetch(){
    //     $get_transactions = $this->multyTransactionSeries(auth()->user()->id);

    //     return [
    //         'data' => $get_transactions,
    //         'status' => 'success'
    //     ];
    // }

    public function fetch($filter=NULL){
        if($filter==NULL){
            $transactions = \App\Models\Transaction::with('user',
                                                          'seller',
                                                          'transaction_detail',
                                                          'transaction_detail.product_user',
                                                          'transaction_detail.product_user.product',
                                                          'transaction_note')
                                ->where('seller_id', auth()->user()->id)
                                ->where('status','!=','cancel')
                                ->orderByDesc('user_id','created_at')
                                ->get();
        }else{
            $transactions = \App\Models\Transaction::with('user',
                                                          'seller',
                                                          'transaction_detail',
                                                          'transaction_detail.product_user',
                                                          'transaction_detail.product_user.product',
                                                          'transaction_note')
                                ->where('seller_id', auth()->user()->id)
                                ->where('status','!=','cancel')
                                ->whereMonth('ordered_at',$filter[0])
                                ->whereYear('ordered_at',$filter[1])
                                ->orderByDesc('user_id','created_at')
                                ->get();
        }

        // $transactions = \App\Models\Transaction::where('seller_id', auth()->user()->id)
        //                     ->where('status','!=','cancel')
        //                     ->orderByDesc('user_id','created_at')
        //                     ->get();
        

        $cek_user = null;
        $get_transactions = [];
        $no_get_transactions = 0;
        foreach ($transactions as $d) {
            if($cek_user==null){
                $cek_user = $d->user_id;
                array_push($get_transactions,
                    (object)[
                        'user' => \App\Models\User::where('id',$cek_user)->first(),
                        'transaction' => [
                            $d
                        ], 
                    ]
                );
            }
            else{
                if($cek_user == $d->user_id){
                    foreach ($get_transactions as $d2) {
                        if($d2->user->id == $cek_user){
                            array_push($get_transactions[$no_get_transactions]->transaction,$d);
                            break;
                        }
                    }
                }else{
                    $cek_user = $d->user_id;
                    array_push($get_transactions,(object)[
                        'user' => \App\Models\User::where('id',$cek_user)->first(),
                        'transaction' => [
                            $d
                        ], 
                    ]);
                    $no_get_transactions++;
                }
            }
        }

        $year_start = \App\Models\Transaction::where('seller_id', auth()->user()->id)
                            ->where('status','!=','cancel')
                            ->orderBy('ordered_at','ASC')
                            ->first();
        if(!isset($year_start->ordered_at)){
            $year_start = 2022;
            $year_end = 2022;
            return [
                'data' => $get_transactions,
                'year_start' => $year_start,
                'year_end' => $year_end,
                'status' => 'success'
            ];
        }
        $year_start = (new \Carbon\Carbon($year_start->ordered_at))->year;
        
        $year_end = \App\Models\Transaction::where('seller_id', auth()->user()->id)
                            ->where('status','!=','cancel')
                            ->orderBy('ordered_at','DESC')
                            ->first();
        $year_end = (new \Carbon\Carbon($year_end->ordered_at))->year;

        return [
            'data' => $get_transactions,
            'year_start' => $year_start,
            'year_end' => $year_end,
            'status' => 'success'
        ];
    }

    public function listFilter(Request $r){
        $filter = [];
        array_push($filter,$r->month);
        array_push($filter,$r->year);
        return $this->fetch($filter);
    }

    public function submitAccept(Request $r){
        try {
            try{
                \DB::beginTransaction();
                // periksa saldo mitra yg memesan
                $transactions = \App\Models\Transaction::where('seller_id', auth()->user()->id)
                                ->where('id', $r->id)
                                ->first();
                $balance = \App\Models\Balance::where('user_id',$transactions->user_id)
                            ->where('bank_id',$transactions->bank_id)->sum('amount') >= $transactions->total ? true : false;
                // ubah status transaksi
                $transactions->status = 'process';
                $transactions->save();
                // // kurangi saldo mitra yg memesan
                // \App\Models\Balance::create([
                //     'user_id' => $transactions->user_id,
                //     'bank_id' => $transactions->bank_id,
                //     'amount' => -($transactions->total),
                //     'title' => 'Kredit',
                //     'description' => 'Pembayaran stok produk',
                //     'status' => 'success'
                // ]);

                \DB::commit();
                return [
                    'data' => 'status menjadi PROSES',
                    'status' => 'success'
                ];
            }
            catch(\Exception $e){
                \DB::rollback();
                // throw $e;
                return [
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

    public function submitCancel(Request $r){
        try{
            try{
                \DB::beginTransaction();
                // ubah transaksi menjadi cancel
                $transactions = \App\Models\Transaction::where('seller_id', auth()->user()->id)
                            ->where('id', $r->id)
                            ->first();
                $transactions->status = 'cancel';
                $transactions->save();
                // tambah saldo mitra yg memesan
                \App\Models\Balance::create([
                    'user_id' => $transactions->user_id,
                    'bank_id' => $transactions->bank_id,
                    'amount' => $transactions->total,
                    'title' => 'Debit',
                    'description' => 'Pembatalan stok produk',
                    'status' => 'success'
                ]);

                \DB::commit();
                return [
                    'data' => 'status menjadi CANCEL',
                    'status' => 'success'
                ];
            }
            catch(\Exception $e){
                \DB::rollback();
                // throw $e;
                return [
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

    public function submitOrderSuccess(Request $r){
        try{
            try{
                \DB::beginTransaction();
                // transaksi menjadi sukses
                $transactions = \App\Models\Transaction::with('transaction_detail','transaction_detail.product_user')->where('seller_id', auth()->user()->id)
                            ->where('id', $r->id)
                            ->first();
                if($transactions->status!='process'){
                    return [
                        'data' => "Order ini sudah diproses!",
                        'status' => 'error'
                    ];
                }
                $transactions->status = 'success';
                $transactions->save();
                // kurangi stok produk distributor
                foreach ($transactions->transaction_detail as $d) {
                    $product_d = \App\Models\ProductUser::where('user_id', $transactions->seller_id)
                                ->where('product_id', $d->product_user->product_id)
                                ->first();
                    $product_d->stock = $product_d->stock-$d->ro;
                    if($product_d->stock<0){
                        \DB::rollback();
                        return [
                            'data' => 'stock distributor tidak cukup',
                            'status' => 'error'
                        ];
                    }
                    $product_d->save();
                    // kurangi ProductUserInOut
                    \App\Models\ProductUserInOut::create([
                        'user_id' => $transactions->seller_id,
                        'product_id' => $d->product_user->product_id,
                        'stock' => -($d->ro),
                        'status' => 'success'
                    ]);
                }
                // tambah stok produk mitra
                foreach ($transactions->transaction_detail as $m) {
                    $product_m = \App\Models\ProductUser::where('user_id', $transactions->user_id)
                                ->where('product_id', $m->product_user->product_id)
                                ->first();
                    if(!$product_m){
                        // jika produk belum ada
                        $product_m = \App\Models\ProductUser::create([
                            'user_id' => $transactions->user_id,
                            'product_id' => $m->product_user->product_id,
                            'price' => config('static.PRODUCT_PRICE')[$m->product_user->product_id],
                            'stock' => 0
                        ]);
                    }
                    $product_m->stock = $product_m->stock+$m->ro;
                    $product_m->save();
                    // kurangi ProductUserInOut
                    \App\Models\ProductUserInOut::create([
                        'user_id' => $transactions->user_id,
                        'product_id' => $m->product_user->product_id,
                        'stock' => $m->ro,
                        'status' => 'success'
                    ]);
                }
                // \DB::rollback();
                \DB::commit();
                return [
                    'data' => 'status menjadi SUKSES',
                    'status' => 'success'
                ];
            }
            catch(\Exception $e){
                \DB::rollback();
                // throw $e;
                return [
                    'data' => $e,
                    // 'data' => "tes",
                    'status' => 'error'
                ];
            }
        } catch (\Throwable $th) {
            return [
                // 'data' => "tes",
                'data' => $th->getMessage(),
                'status' => 'error'
            ];
        }
    }

    public function printNota($id){
        try {
            $transactions = \App\Models\Transaction::with('user',
                            'transaction_note',
                            'user.user_profile',
                            'transaction_detail',
                            'transaction_detail.product_user',
                            'transaction_detail.product_user.product')
                            ->where('seller_id', auth()->user()->id)
                            ->where('id', $id)
                            ->first();
            return [
                'data' => $transactions,
                'status' => 'success'
            ];
        } catch (\Throwable $th) {
            return [
                'data' => $th->getMessage(),
                'status' => 'error'
            ];
        }
        
    }

    public function fetchProduct(){
        $stock = \App\Models\ProductUser::with('product')->where('user_id', auth()->user()->id)->get();
        return [
            'data' => [
                'stock' => $stock
            ],
            'status' => 'success'
        ]; 
    }

    public function addSubmitAdd(Request $r){
        try{
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
            $subtotal = 0;
            $total = 0;
            try{
                \DB::beginTransaction();

                $note = \App\Models\TransactionNote::create([
                    'name'=> $r->name,
                    'position'=> $r->position,
                    'address'=> $r->address,
                    'type'=> $r->type,
                ]);
                if($r->type == 'transfer'){
                    $note->bank = $r->bank;
                    $note->behalf_of = $r->behalf_of;
                    $note->save();
                }

                $transaction = \App\Models\Transaction::create([
                    'transaction_note_id' => $note->id,
                    'seller_id' => auth()->user()->id,
                    'status' => 'success',
                    'is_online' => 'no',
                    'subtotal' => 0,
                    'discount' => 0,
                    'total' => 0,
                ]);
                foreach($r->data['stock'] as $d){
                    if($d['ro']>0){
                        $product = \App\Models\ProductUser::where([
                                        ['user_id',auth()->user()->id],
                                        ['product_id',$d['product_id']]
                                    ])->first();
                        if($d['ro'] <= $product->stock){
                            $subtotal_unit = $d['ro']*$product->price;
    
                            $transaction_detail = \App\Models\TransactionDetail::create([
                                'transaction_id' => $transaction->id,
                                'product_user_id' => $product->id,
                                'ro' => $d['ro'],
                                'subtotal' => $subtotal_unit
                            ]);
    
                            $subtotal += $subtotal_unit;
                        }
                    }
                }
    
                $transaction->subtotal = $subtotal;
                $transaction->discount = 0;
                $transaction->total = $subtotal;
                $transaction->save();

                // \DB::rollback();
                \DB::commit();
                return [
                    'data' => $r->all(),
                    // 'data' => 'Transaksi offline sukses',
                    'status' => 'success'
                ];
            }
            catch(\Exception $e){
                \DB::rollback();
                // throw $e;
                return [
                    'data' => $e,
                    // 'data' => "tes",
                    'status' => 'error'
                ];
            }
        } catch (\Throwable $th) {
            return [
                // 'data' => "tes",
                'data' => $th->getMessage(),
                'status' => 'error'
            ];
        }
    }
}
