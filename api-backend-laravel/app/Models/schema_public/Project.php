<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class Project extends Model
{
    protected $table = 'biz_project';
    protected $primaryKey = 'idproject';

    public function biz_client()
    {
        return $this->belongsTo('App\Models\schema_public\Client','idclient');
    }
}
