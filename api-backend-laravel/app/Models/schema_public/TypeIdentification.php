<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class TypeIdentification extends Model
{
    use SoftDeletes;

    protected $table = 'tax_typeidentification';
    protected $primaryKey = 'id_typeidentification';
    protected $dates = ['deleted_at'];
}
