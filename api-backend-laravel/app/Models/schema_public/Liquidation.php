<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class Liquidation extends Model
{
    protected $table = 'biz_liquidation';
    protected $primaryKey = 'idliquidation';

    public function biz_referralguideliquidation()
    {
        return $this->hasMany('App\Models\schema_public\ReferralGuideLiquidation','idliquidation');
    }

    public function biz_liquidationproject()
    {
        return $this->hasMany('App\Models\schema_public\LiquidationProject','idliquidation');
    }

    public function biz_liquidationitemsurplus()
    {
        return $this->hasMany('App\Models\schema_public\LiquidationItemSurplus','idliquidation');
    }

    public function biz_liquidationprojectitem()
    {
        return $this->hasMany('App\Models\schema_public\LiquidationProjectItem','idliquidation');
    }
}
