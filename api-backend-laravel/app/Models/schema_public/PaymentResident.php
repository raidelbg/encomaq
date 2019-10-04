<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PaymentResident extends Model
{
    use SoftDeletes;

    protected $table = 'tax_paymentresident';
    protected $primaryKey = 'id_paymentresident';
    protected $dates = ['deleted_at'];
}
