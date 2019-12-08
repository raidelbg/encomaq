<?php

namespace App\Http\Controllers\workflow;

use App\Models\schema_public\Carrier;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class CarrierController extends Controller
{

    private const SUCCESS = 'success';
    private const MESSAGE = 'message';
    private const DATA = 'data';
    private const FIELD_DUPLICATE = 'licenseplate';

    /**
     * Display a listing of the resource.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        try {
            $filter = json_decode($request->get('filter'));
            $where = "(identify LIKE '%" . $filter->search . "%' OR carriername LIKE '%" . $filter->search . "%' OR ";
            $where .= "licenseplate LIKE '%" . $filter->search . "%') AND state = " . $filter->state;
            $result = Carrier::with('nom_identifytype')->whereRaw($where)->orderBy($filter->column, $filter->order)->paginate($filter->num_page);
            return response()->json([
                self::SUCCESS => true, self::DATA => $result
            ]);
        } catch (\Exception $e) {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => $e->getMessage()
            ]);
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        try {
            $item = new Carrier();
            if ($this->notExists($request->input(self::FIELD_DUPLICATE), null)) {
                return $this->action($item, $request, 'add');
            } else {
                return response()->json([
                    self::SUCCESS => false,
                    self::MESSAGE => 'Ha ocurrido un error al intentar agregar, ya se encuentra registrado.'
                ]);
            }
        } catch (\Exception $e) {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => $e->getMessage()
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
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, $id)
    {
        try {
            $item = Carrier::find($id);
            if ($this->notExists($request->input(self::FIELD_DUPLICATE), $id)) {
                return $this->action($item, $request, 'update');
            } else {
                return response()->json([
                    self::SUCCESS => false,
                    self::MESSAGE => 'Ha ocurrido un error al intentar editar, ya se encuentra registrado.'
                ]);
            }
        } catch (\Exception $e) {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => $e->getMessage()
            ]);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id)
    {
        try {
            $item = Carrier::find($id);
            if ($item->delete()) {
                return response()->json([
                    self::SUCCESS => true, self::MESSAGE => 'Se eliminó satisfactoriamente'
                ]);
            } else {
                return response()->json([
                    self::SUCCESS => false, self::MESSAGE => 'Ha ocurrido un error al intentar eliminar'
                ]);
            }
        } catch (\Exception $e) {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => $e->getMessage()
            ]);
        }
    }

    private function notExists($item, $id)
    {
        $elements = Carrier::where('licenseplate', $item);
        if ($id != null) {
            $elements = $elements->where('idcarrier', '!=' , $id);
        }
        $count = $elements->count();
        return ($count === 0);
    }

    private function action(Carrier $item, Request $request, $typeAction)
    {
        try {
            $item->ididentifytype = $request->input('ididentifytype');
            $item->identify = $request->input('identify');
            $item->carriername = $request->input('carriername');
            $item->licenseplate = $request->input('licenseplate');
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
        } catch (\Exception $e) {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => $e->getMessage()
            ]);
        }
    }
}
