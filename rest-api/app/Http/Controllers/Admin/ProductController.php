<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function fetch()
    {
        $products = \App\Models\Product::all();
        return [
            'data' => $products,
            'status' => 'success'
        ];
    }

    public function add(Request $r){
        try {
            $product = new \App\Models\Product;
            $product->name = $r->name;
            $product->unit = $r->unit;
            $product->price = $r->price;
            $product->save();
            return [
                'data' => $product,
                'status' => 'success'
            ];
        } catch (\Throwable $th) {
            return [
                'data' => $th->getMessage(), 
                'status' => 'error'
            ];
        }
    }
    public function edit(Request $r){
        try {
            $product = \App\Models\Product::find($r->id);
            $product->name = $r->name;
            $product->unit = $r->unit;
            $product->price = $r->price;
            $product->save();
            return [
                'data' => $product,
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
            $product = \App\Models\Product::find($r->id);
            $product->delete();
            return [
                'data' => "Success delete product ".$product->name,
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
