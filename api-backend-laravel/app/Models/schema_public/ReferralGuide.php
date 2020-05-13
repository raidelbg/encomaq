<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class ReferralGuide extends Model
{
    protected $table = 'biz_referralguide';
    protected $primaryKey = 'idreferralguide';

    public function biz_Referralguideitem()
    {
        return $this->hasMany('App\Models\schema_public\Referralguideitem','idreferralguide');
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
        return $this->belongsTo('App\Models\schema_public\Carrier', 'idcarrier');
    }

    public function nom_transferreason()
    {
        return $this->belongsTo('App\Models\schema_public\TransferReason', 'idtransferreason');
    }

    public function biz_warehouse()
    {
        return $this->belongsTo('App\Models\schema_public\Warehouse', 'idwarehouse');
    }

    public function biz_project()
    {
        return $this->belongsTo('App\Models\schema_public\Project', 'idproject');
    }
}
