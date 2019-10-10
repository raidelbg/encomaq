<?php

namespace App\Http\Controllers\workflow;

use App\Models\schema_public\TransferReason;
use App\Models\schema_public\TypeTransferReason;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class TransferReasonController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return TransferReason[]|\Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection
     */
    public function index()
    {
        return TransferReason::with('biz_typetransferreason')
                                    ->orderBy('transferreasonname', 'asc')->get();
    }

    public function getTypeTransferReason()
    {
        return TypeTransferReason::where('state', 1)->orderBy('nametypetransferreason', 'asc')->get();
    }


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $item = new TransferReason();

        if ($this->existTransfer($request->input('transferreasonname'), null) ==  false) {
            return $this->action($item, $request, 'add');
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Ha ocurrido un error al intentar agregar, ya existe registrado.'
            ]);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $item = new TransferReason();

        if ($this->existTransfer($request->input('transferreasonname'), $id) ==  false) {
            return $this->action($item, $request, 'update');
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Ha ocurrido un error al intentar editar, ya existe registrado.'
            ]);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $item = TransferReason::find($id);

        if ($item->delete()) {
            return response()->json(['success' => true, 'message' => 'Se eliminó satisfactoriamente' ]);
        } else {
            return response()->json(['success' => false, 'message' => 'Ha ocurrido un error al intentar eliminar' ]);
        }
    }


    private function existTransfer($transferreasonname, $id)
    {
        $count = TransferReason::where('transferreasonname', $transferreasonname);
        if ($id != null) {
            $count = $count->where('idtransferreason', '!=' , $id);
        }
        $count = $count->count();
        return ($count == 0) ? false : true;
    }

    private function action(TransferReason $item, Request $request, $typeAction)
    {
        $item->transferreasonname = $request->input('transferreasonname');
        $item->idtypetransferreason = $request->input('idtypetransferreason');
        $item->state = ($request->input('state') === true || $request->input('state') === 1) ? 1 : 0;

        if ($item->save()) {
            return response()->json([
                'success' => true,
                'message' => ($typeAction === 'add') ? 'Se agregó satisfactoriamente' : 'Se editó satisfactoriamente'
            ]);
        } else {
            return response()->json([
                'success' => false,
                'message' => ($typeAction === 'add') ? 'Ha ocurrido un error al intentar agregar' : 'Ha ocurrido un error al intentar editar'
            ]);
        }
    }
}
