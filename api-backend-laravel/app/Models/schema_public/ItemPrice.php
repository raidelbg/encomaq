<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class ItemPrice extends Model
{
    protected $table = 'biz_itemprice';
    protected $primaryKey = 'iditemprice';

    public function biz_item()
    {
        return $this->belongsTo('App\Models\schema_public\Item','iditem');
    }
}
