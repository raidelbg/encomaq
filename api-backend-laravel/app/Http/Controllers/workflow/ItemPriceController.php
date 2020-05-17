<?php

namespace App\Http\Controllers\workflow;

use App\Http\Controllers\Controller;
use App\Models\schema_public\Item;
use App\Models\schema_public\ItemPrice;
use Illuminate\Http\Request;

class ItemPriceController extends Controller
{

    private const SUCCESS = 'success';
    private const MESSAGE = 'message';
    private const DATA = 'data';

    /**
     * Display a listing of the resource.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request): ?\Illuminate\Http\JsonResponse
    {
        try {
            $filter = json_decode($request->get('filter'));
            $result = ItemPrice::where('iditem', $filter->iditem)->orderBy('price', 'DESC')->get();

            $arrayResult = [];
            foreach ($result as $item) {
                $arrayResult[] = ['iditemprice' => $item->iditemprice, 'price' => $item->price, 'deleted' => false];
            }

            return response()->json([
                self::SUCCESS => true, self::DATA => $arrayResult
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

            foreach ($request->input('list') as $item) {
                if ($item['iditemprice'] === 0) {
                    $itemprice = new ItemPrice();
                    $itemprice->iditem = $request->input('iditem');
                    $itemprice->price = $item['price'];
                    if (!$itemprice->save()) {
                        return response()->json([
                            self::SUCCESS => false, self::MESSAGE => 'Ha ocurrido un error al intentar actualizar la lista'
                        ]);
                    }
                } else {
                    if (!$item['deleted']) {
                        $itemprice = ItemPrice::find($item['iditemprice']);
                        $itemprice->price = $item['price'];
                        if (!$itemprice->save()) {
                            return response()->json([
                                self::SUCCESS => false, self::MESSAGE => 'Ha ocurrido un error al intentar actualizar la lista'
                            ]);
                        }
                    } else {
                        $itemprice = ItemPrice::find($item['iditemprice']);
                        if (!$itemprice->delete()) {
                            return response()->json([
                                self::SUCCESS => false, self::MESSAGE => 'Ha ocurrido un error al intentar actualizar la lista'
                            ]);
                        }
                    }
                }
            }

            return response()->json([
                self::SUCCESS => true, self::MESSAGE => 'Se ha actualizado satisfactoriamente la lista de precios'
            ]);
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
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
