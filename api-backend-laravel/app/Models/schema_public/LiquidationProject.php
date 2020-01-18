<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class LiquidationProject extends Model
{
    protected $table = 'biz_liquidation_project';

    protected $primaryKey = null;
    public $incrementing = false;
    public $timestamps = false;

    public function biz_liquidation()
    {
        return $this->belongsTo('App\Models\schema_public\Liquidation', 'idliquidation');
    }

    public function biz_project()
    {
        return $this->belongsTo('App\Models\schema_public\Project', 'idproject');
    }
}
