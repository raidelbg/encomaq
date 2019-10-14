<?php

namespace App\Http\Controllers\workflow;

use App\Models\schema_public\Warehouse;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class WarehouseController extends Controller
{

    private const SUCCESS = 'success';
    private const MESSAGE = 'message';
    private const FIELD_DUPLICATE = 'warehousename';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Warehouse::orderBy('warehousename', 'asc')->get();
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
        $item = new Warehouse();
        if ($this->notExists($request->input(self::FIELD_DUPLICATE), null)) {
            return $this->action($item, $request, 'add');
        } else {
            return response()->json([
                self::SUCCESS => false,
                self::MESSAGE => 'Ha ocurrido un error al intentar agregar, ya se encuentra registrado.'
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
        $item = Warehouse::find($id);
        if ($this->notExists($request->input(self::FIELD_DUPLICATE), $id)) {
            return $this->action($item, $request, 'update');
        } else {
            return response()->json([
                self::SUCCESS => false,
                self::MESSAGE => 'Ha ocurrido un error al intentar editar, ya se encuentra registrado.'
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
        $item = Warehouse::find($id);

        if ($item->delete()) {
            return response()->json([self::SUCCESS => true, self::MESSAGE => 'Se eliminó satisfactoriamente' ]);
        } else {
            return response()->json([self::SUCCESS => false, self::MESSAGE => 'Ha ocurrido un error al intentar eliminar' ]);
        }
    }

    private function notExists($item, $id)
    {
        $count = Warehouse::where('warehousename', $item);
        if ($id != null) {
            $count = $count->where('idwarehouse', '!=' , $id);
        }
        $count = $count->count();
        return ($count === 0);
    }

    private function action(Warehouse $item, Request $request, $typeAction)
    {
        $item->idcompany = 2;
        $item->warehousename = $request->input('warehousename');
        $item->address = $request->input('address');
        $item->phone = $request->input('phone');
        $item->email = $request->input('email');
        $item->state = ($request->input('state') === true || $request->input('state') === 1) ? 1 : 0;

        if ($item->save()) {
            return response()->json([
                self::SUCCESS => true,
                self::MESSAGE => ($typeAction === 'add') ? 'Se agregó satisfactoriamente' : 'Se editó satisfactoriamente'
            ]);
        } else {
            return response()->json([
                self::SUCCESS => false,
                self::MESSAGE => ($typeAction === 'add') ? 'Ha ocurrido un error al intentar agregar' : 'Ha ocurrido un error al intentar editar'
            ]);
        }
    }

}
