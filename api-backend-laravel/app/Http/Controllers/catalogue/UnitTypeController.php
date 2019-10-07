<?php

namespace App\Http\Controllers\catalogue;

use App\Models\schema_public\UnitType;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class UnitTypeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return UnitType::orderBy('unittypename', 'asc')->get();
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
        $item = new UnitType();
        return $this->action($item, $request, 'add');
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
        $item = UnitType::find($id);
        return $this->action($item, $request, 'update');
    }

    private function action(UnitType $item, Request $request, $typeAction)
    {
        $item->unittypename = strtoupper($request->input('unittypename'));
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

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $item = UnitType::find($id);

        if ($item->delete()) {
            return response()->json(['success' => true, 'message' => 'Se eliminó satisfactoriamente' ]);
        } else {
            return response()->json(['success' => false, 'message' => 'Ha ocurrido un error al intentar eliminar' ]);
        }
    }
}
