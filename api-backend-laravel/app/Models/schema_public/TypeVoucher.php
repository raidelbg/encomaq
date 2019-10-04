<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class TypeVoucher extends Model
{
    use SoftDeletes;

    protected $table = 'tax_typevoucher';
    protected $primaryKey = 'id_typevoucher';
    protected $dates = ['deleted_at'];
}
