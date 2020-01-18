<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class LiquidationItemSurplus extends Model
{
    protected $table = 'biz_liquidationitemsurplus';

    protected $primaryKey = 'idliquidationitemsurplus';

    public function biz_project()
    {
        return $this->belongsTo('App\Models\schema_public\Project', 'idproject');
    }

    public function biz_item()
    {
        return $this->belongsTo('App\Models\schema_public\Item','iditem');
    }
}
