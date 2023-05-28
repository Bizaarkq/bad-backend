<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group([
    'middleware' => 'api',
    'prefix' => 'auth'
], function ($router) {

    Route::post('/login', 'App\Http\Controllers\AuthController@login');
    Route::post('/logout', 'App\Http\Controllers\AuthController@logout');
    Route::post('/refresh', 'App\Http\Controllers\AuthController@refresh');
    Route::post('/me', 'App\Http\Controllers\AuthController@me');

});

Route::group([
    'middleware' => [
        'api',
        'auth.role:logistica'
    ],
    'prefix' => 'pedidos'
], function ($router) {

    Route::get('/', 'App\Http\Controllers\PedidoController@getPedidos');
    Route::post('/', 'App\Http\Controllers\PedidoController@createPedido');
    Route::put('/{id}', 'App\Http\Controllers\PedidoController@updatePedido');
    Route::delete('/{id}', 'App\Http\Controllers\PedidoController@deletePedido');

});