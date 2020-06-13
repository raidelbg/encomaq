<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;
use App\Models\schema_public\ReferralGuideItem;
use App\Models\schema_public\Carrier;
use App\Models\schema_public\TransferReason;
use App\Models\schema_public\Warehouse;

class ReferralGuide extends Model
{
    protected $table = 'biz_referralguide';
    protected $primaryKey = 'idreferralguide';

    public function biz_ReferralGuideItem(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(ReferralGuideItem::class,'idreferralguide');
    }

    public function biz_referralguide_place()
    {
        return $this->hasMany('App\Models\schema_public\ReferralGuidePlace','idreferralguide');
    }

    public function biz_contract()
    {
        return $this->belongsTo('App\Models\schema_public\Contract', 'idcontract');
    }

    public function biz_carrier()
    {
        return $this->belongsTo(Carrier::class, 'idcarrier');
    }

    public function nom_transferreason()
    {
        return $this->belongsTo(TransferReason::class, 'idtransferreason');
    }

    public function biz_warehouse()
    {
        return $this->belongsTo(Warehouse::class, 'idwarehouse');
    }

    public function biz_project()
    {
        return $this->belongsTo('App\Models\schema_public\Project', 'idproject');
    }
}
