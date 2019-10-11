<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class Client extends Model
{
    protected $table = 'biz_client';
    protected $primaryKey = 'idclient';

    public function nom_identifytype()
    {
        return $this->belongsTo('App\Models\schema_public\TypeIdentification','ididentifytype');
    }
}
