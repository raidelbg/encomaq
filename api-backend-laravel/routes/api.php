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
    Route::resource('country', 'catalogue\CountryController');
});

Route::group(['middleware' => 'auth:api'], function () {
    Route::resource('paymentresident', 'catalogue\PaymentResidentController');
});

Route::group(['middleware' => 'auth:api'], function () {
    Route::resource('typevoucher', 'catalogue\TypeVoucherController');
});
