<?php

namespace App\Http\Controllers\catalogue;

use App\Models\schema_public\Role;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class RoleController extends Controller
{

    private const SUCCESS = 'success';
    private const MESSAGE = 'message';
    private const FIELD_DUPLICATE = 'rolename';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Role::orderBy('rolename', 'asc')->get();
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
        $item = new Role();

        if ( ! $this->exists($request->input(self::FIELD_DUPLICATE), null) ) {
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
        $item = Role::find($id);

        if ($this->exists($request->input(self::FIELD_DUPLICATE), $id) ==  false) {
            return $this->action($item, $request, 'update');
        } else {
            return response()->json([
                self::SUCCESS => false,
                self::MESSAGE => 'Ha ocurrido un error al intentar agregar, ya se encuentra registrado.'
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
        $item = Role::find($id);

        if ($item->delete()) {
            return response()->json([self::SUCCESS => true, self::MESSAGE => 'Se eliminó satisfactoriamente' ]);
        } else {
            return response()->json([self::SUCCESS => false, self::MESSAGE => 'Ha ocurrido un error al intentar eliminar' ]);
        }
    }

    private function exists($item, $id)
    {
        $count = Role::where('rolename', $item);
        if ($id != null) {
            $count = $count->where('idrole', '!=' , $id);
        }
        $count = $count->count();
        return ($count == 0);
    }

    private function action(Role $item, Request $request, $typeAction)
    {
        $item->rolename = strtoupper($request->input('rolename'));

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
