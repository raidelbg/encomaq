<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class Carrier extends Model
{
    protected $table = 'biz_carrier';
    protected $primaryKey = 'idcarrier';

    public function nom_identifytype()
    {
        return $this->belongsTo('app\Models\schema_public\TypeIdentification','ididentifytype');
    }
}
