<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('signin', 'AuthController@signin');
Route::post('create', 'AuthController@create');

Route::group(['middleware' => 'auth:api'], function () {
    Route::resource('typeidentification', 'catalogue\TypeIdentificationController');
});

Route::group(['middleware' => 'auth:api'], function () {
    Route::resource('category-item', 'catalogue\CategoryItemController');
});

Route::group(['middleware' => 'auth:api'], function () {
    Route::resource('unit-type', 'catalogue\UnitTypeController');
});

Route::group(['middleware' => 'auth:api'], function () {
    Route::resource('payment-form', 'workflow\PaymentFormController');
});

Route::group(['middleware' => 'auth:api'], function () {
    Route::resource('warehouse', 'workflow\WarehouseController');
});

Route::group(['middleware' => 'auth:api'], function () {
    Route::get('transfer-reason/type-reason', 'workflow\TransferReasonController@getTypeTransferReason');
    Route::resource('transfer-reason', 'workflow\TransferReasonController');
});

