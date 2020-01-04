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
    Route::resource('category-item', 'catalogue\CategoryItemController');
    Route::resource('unit-type', 'catalogue\UnitTypeController');
    Route::resource('role', 'catalogue\RoleController');
    Route::resource('period', 'catalogue\PeriodController');
    Route::resource('user', 'catalogue\UserController');
    Route::resource('config-email', 'catalogue\ConfigEmailController');
});

Route::group(['middleware' => 'auth:api'], function () {
    Route::resource('payment-form', 'workflow\PaymentFormController');
    Route::resource('warehouse', 'workflow\WarehouseController');
    Route::get('transfer-reason/type-reason', 'workflow\TransferReasonController@getTypeTransferReason');
    Route::resource('transfer-reason', 'workflow\TransferReasonController');
    Route::resource('carrier', 'workflow\CarrierController');
    Route::get('client/exportToPDF', 'workflow\ClientController@exportToPDF');
    Route::resource('client', 'workflow\ClientController');
    Route::resource('project', 'workflow\ProjectController');
    Route::resource('item', 'workflow\ItemController');
    Route::resource('item-price', 'workflow\ItemPriceController');
    Route::resource('company', 'workflow\CompanyController');
    Route::resource('contract', 'workflow\ContractController');
    Route::resource('referral-guide', 'workflow\ReferralGuideController');
});
