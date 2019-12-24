<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class ContractItem extends Model
{
    protected $table = 'biz_contractitem';
    protected $primaryKey = 'idcontractitem';

    public function biz_item()
    {
        return $this->belongsTo('App\Models\schema_public\Item','iditem');
    }

}
