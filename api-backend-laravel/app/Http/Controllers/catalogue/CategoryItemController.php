<?php

namespace App\Http\Controllers\catalogue;

use App\Models\schema_public\CategoryItem;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class CategoryItemController extends Controller
{

    private const SUCCESS = 'success';
    private const MESSAGE = 'message';
    private const FIELD_DUPLICATE = 'categoryitemname';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return CategoryItem::orderBy('categoryitemname', 'asc')->get();
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
        $item = new CategoryItem();
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
        $item = CategoryItem::find($id);
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
        $item = CategoryItem::find($id);

        if ($item->delete()) {
            return response()->json([
                self::SUCCESS => true, self::MESSAGE => 'Se eliminó satisfactoriamente'
            ]);
        } else {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => 'Ha ocurrido un error al intentar eliminar'
            ]);
        }
    }

    private function notExists($item, $id)
    {
        $elements = CategoryItem::where('categoryitemname', $item);
        if ($id != null) {
            $elements = $elements->where('idcategoryitem', '!=' , $id);
        }
        $count = $elements->count();
        return ($count === 0);
    }

    private function action(CategoryItem $item, Request $request, $typeAction)
    {
        $item->categoryitemname = strtoupper($request->input('categoryitemname'));
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
