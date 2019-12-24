<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class ContractPaymentForm extends Model
{
    protected $table = 'biz_contract_paymentform';
    protected $primaryKey = 'idcontract_paymentform';

    public function biz_paymentform()
    {
        return $this->belongsTo('App\Models\schema_public\PaymentForm','idpaymentform');
    }
}
