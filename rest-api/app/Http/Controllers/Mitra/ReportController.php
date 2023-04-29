<?php

namespace App\Http\Controllers\Mitra;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function fetchProduct(Request $r){
        try {
            $product = \App\Models\Product::get();
            $transaction = \App\Models\Product::join('product_users','product_users.product_id','=','products.id')
                            ->join('transaction_details','transaction_details.product_user_id','=','product_users.id')
                            ->join('transactions','transactions.id','=','transaction_details.transaction_id')
                            ->where('transactions.seller_id', auth()->user()->id)
                            ->where('transactions.status', 'success')
                            ->select('products.name',
                                     'products.unit',
                                     'product_users.price',
                                     'transaction_details.ro',
                                     'transaction_details.subtotal',
                                     'transactions.ordered_at')
                            ->orderBy('products.name','ASC')
                            ->whereBetween('transactions.ordered_at', [$r->from_at, $r->to_at])
                            ->get();
            return [
                'data' => [
                    'product' => $product,
                    'transaction' => $transaction,
                    'req' => $r->all()
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
