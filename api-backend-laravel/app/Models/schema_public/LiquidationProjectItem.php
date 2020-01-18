<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class LiquidationProjectItem extends Model
{
    protected $table = 'biz_liquidationprojectitem';
    protected $primaryKey = 'idliquidationprojectitem';

    public function biz_project()
    {
        return $this->belongsTo('App\Models\schema_public\Project', 'idproject');
    }

    public function biz_item()
    {
        return $this->belongsTo('App\Models\schema_public\Item', 'iditem');
    }
}
