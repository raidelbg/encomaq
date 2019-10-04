<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
class Country extends Model
{
    use SoftDeletes;

    protected $table = 'tax_country';
    protected $primaryKey = 'id_country';
    protected $dates = ['deleted_at'];
}
