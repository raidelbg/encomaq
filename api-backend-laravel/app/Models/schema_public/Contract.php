<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class Contract extends Model
{
    protected $table = 'biz_contract';
    protected $primaryKey = 'idcontract';

    public function biz_client()
    {
        return $this->belongsTo('App\Models\schema_public\Client','idclient');
    }

    public function nom_categoryitem()
    {
        return $this->belongsTo('App\Models\schema_public\CategoryItem','idcategoryitem');
    }

    public function biz_period()
    {
        return $this->belongsTo('App\Models\schema_public\Period','idperiod');
    }

    public function biz_contractpaymentform()
    {
        return $this->hasMany('App\Models\schema_public\ContractPaymentForm','idcontract');
    }

    public function biz_contractitem()
    {
        return $this->hasMany('App\Models\schema_public\ContractItem',"idcontract");
    }

}
