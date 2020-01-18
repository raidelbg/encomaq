<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class ReferralGuideLiquidation extends Model
{
    protected $table = 'biz_referralguide_liquidation';

    protected $primaryKey = null;
    public $incrementing = false;
    public $timestamps = false;

    public function biz_referralguide()
    {
        return $this->belongsTo('App\Models\schema_public\ReferralGuide', 'idreferralguide');
    }

    public function biz_liquidation()
    {
        return $this->belongsTo('App\Models\schema_public\Liquidation', 'idliquidation');
    }
}
