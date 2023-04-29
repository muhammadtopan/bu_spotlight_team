<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});
$router->group(['prefix' => 'api'], function () use ($router){
    $router->get('/tes', 'Admin\DashboardController@index');
    $router->post('/login', 'AuthController@login');
    $router->post('/register', 'AuthController@register');
    $router->post('/logout', 'AuthController@logout');

    $router->get('/users', 'AuthController@index');
    $router->get('/users/{id}', 'AuthController@show');
    $router->post('/users', 'AuthController@store');
    $router->put('/users/{id}', 'AuthController@update');
    $router->delete('/users/{id}', 'AuthController@destroy');

    // $router->get('admin', ['middleware' => 'auth', function () {
    //     // $router->get('/', 'DashboardController@index');
    //     return "Admin DashboardController index";
    // }]);
    $router->group(['prefix' => 'auth', 'middleware' => ['auth']],  function () use ($router){
        $router->get('/user', 'AuthController@getUserAuth');
    });

    $router->group(['prefix' => 'verify', 'middleware' => ['isVerify']],  function () use ($router){
        $router->post('/verify-form', 'AuthController@verifyForm');
    });

    $router->group(['prefix' => 'admin', 'middleware' => ['isAdmin']],  function () use ($router){
        $router->get('/', 'Admin\DashboardController@index');

        $router->get('/product/fetch', 'Admin\ProductController@fetch');
        $router->post('/product/add', 'Admin\ProductController@add');
        $router->post('/product/edit', 'Admin\ProductController@edit');
        $router->post('/product/delete', 'Admin\ProductController@delete');

        $router->get('/distributor/fetch', 'Admin\DuController@fetch');
        $router->post('/distributor/add', 'Admin\DuController@add');
        $router->post('/distributor/update-status', 'Admin\DuController@updateStatus');
        $router->post('/distributor/delete', 'Admin\DuController@delete');
        
        $router->get('/user/fetch', 'Admin\UserController@fetch');
        $router->post('/user/update-view-admin', 'Admin\UserController@updateViewAdmin');
        $router->post('/user/update-status', 'Admin\UserController@updateStatus');
    });

    $router->group(['prefix' => 'mitra', 'middleware' => ['isAgen']],  function () use ($router){
        $router->get('/', 'Mitra\HomeController@index');

        $router->get('/stock/fetch', 'Mitra\StockController@fetch');
        $router->get('/stock/leader/fetch', 'Mitra\StockController@leaderFetch');
        $router->post('/stock/add', 'Mitra\StockController@add');
        $router->get('/stock/last-month/fetch', 'Mitra\StockController@fetchLastMonth');
        $router->post('/stock/last-month/add', 'Mitra\StockController@addStockLastMonth');
        $router->get('/stock/first-month/fetch', 'Mitra\StockController@fetchFirstMonth');
        
        $router->get('/expenses/fetch', 'Mitra\ExpensesController@fetch');
        $router->post('/expenses/filter', 'Mitra\ExpensesController@filter');
        $router->post('/expenses/update', 'Mitra\ExpensesController@update');
        $router->post('/expenses/delete', 'Mitra\ExpensesController@delete');
        $router->post('/expenses/add', 'Mitra\ExpensesController@addExpenses');
        
        $router->get('/partner/fetch', 'Mitra\PartnerController@fetch');
        $router->post('/partner/add', 'Mitra\PartnerController@add');

        $router->get('/sales/fetch', 'Mitra\SalesController@fetch');
        $router->post('/sales/list/filter', 'Mitra\SalesController@listFilter');
        $router->post('/sales/submit-accept', 'Mitra\SalesController@submitAccept');
        $router->post('/sales/submit-order-success', 'Mitra\SalesController@submitOrderSuccess');
        $router->post('/sales/submit-cancel', 'Mitra\SalesController@submitCancel');
        $router->get('/sales/print-nota/{id}', 'Mitra\SalesController@printNota');

        $router->get('/sales/add/fetch-product', 'Mitra\SalesController@fetchProduct');
        $router->post('/sales/add/submit-add', 'Mitra\SalesController@addSubmitAdd');
        
        $router->get('/balance/fetch', 'Mitra\BalanceController@fetch');
        $router->post('/balance/detail', 'Mitra\BalanceController@detailFetch');
        $router->post('/balance/add/submit-add', 'Mitra\BalanceController@submitAdd');

        $router->post('/report/fetch/product', 'Mitra\ReportController@fetchProduct');
    });
});

