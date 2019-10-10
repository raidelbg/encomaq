<?php

namespace App\Models\schema_public;

use Illuminate\Database\Eloquent\Model;

class TransferReason extends Model
{
    protected $table = 'nom_transferreason';
    protected $primaryKey = 'idtransferreason';


    public function nom_typetransferreason()
    {
        return $this->belongsTo('App\Models\schema_public\TypeTransferReason','idtypetransferreason');
    }
}
