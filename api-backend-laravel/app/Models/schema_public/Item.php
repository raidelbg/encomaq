<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class Item extends Model
{

    protected $table = 'biz_item';
    protected $primaryKey = 'iditem';

    public function nom_category()
    {
        return $this->belongsTo('App\Models\schema_public\CategoryItem','idcategoryitem');
    }

    public function nom_unit()
    {
        return $this->belongsTo('App\Models\schema_public\UnitType','idunittype');
    }

    public function biz_itemprice()
    {
        return $this->hasMany('App\Models\schema_public\ItemPrice','iditem');
    }

}
