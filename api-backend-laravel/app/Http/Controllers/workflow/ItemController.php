<?php

namespace App\Http\Controllers\workflow;

use App\Models\schema_public\Item;
use App\Models\schema_public\ItemPrice;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ItemController extends Controller
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
    public function index(Request $request): ?\Illuminate\Http\JsonResponse
    {
        try {
            $filter = json_decode($request->get('filter'), false);
            $otherWhere = '';
            if (isset($filter->idcategoryitem) && $filter->idcategoryitem !== '') {
                $otherWhere .= ' AND idcategoryitem = ' . $filter->idcategoryitem;
            }
            if (isset($filter->idunittype) && $filter->idunittype !== '') {
                $otherWhere .= ' AND idunittype = ' . $filter->idunittype;
            }
            $where = "(itemname LIKE '%" . $filter->search . "%' OR description LIKE '%" . $filter->search . "%' ) ";
            $where .= "AND state = " . $filter->state;
            $where .= $otherWhere;
            $result = Item::with('nom_categoryitem','nom_unittype', 'biz_itemprice')->whereRaw($where)
                ->orderBy($filter->column, $filter->order);

            if (isset($filter->num_page)) {
                $result = $result->paginate($filter->num_page);
            } else {
                $result = $result->get();
            }

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
    public function store(Request $request): ?\Illuminate\Http\JsonResponse
    {
        try {
            $path = null;
            if ($request->hasFile('file')) {
                $dirupload = 'uploads/items';
                $file = $request->file('file');
                $destinationPath = public_path() . '/' . $dirupload;
                $name = 'item-'.time().'.'.$file->getClientOriginalExtension();
                if($file->move($destinationPath, $name)) {
                    $path = $dirupload . '/' . $name;
                }
            }

            $flagItemPrice = false;

            $data = json_decode($request->get('data'), false);
            if (isset($data->iditem)) {
                $item = Item::find($data->iditem);
            } else {
                $item = new Item();
                $flagItemPrice = true;
            }

            $item->idcategoryitem = $data->idcategoryitem;
            $item->idunittype = $data->idunittype;
            $item->itemname = $data->itemname;
            $item->description = $data->description;
            $item->price = $data->price;
            $item->state = 1;

            if ($path !== null) {
                $item->image = $path;
            }

            if ($item->save()) {

                if ($flagItemPrice) {
                    $itemprice = new ItemPrice();
                    $itemprice->iditem = $item->iditem;
                    $itemprice->price = $data->price;
                    $itemprice->save();
                }

                return response()->json([
                    self::SUCCESS => true, self::MESSAGE => 'Se ha guardado satisfactoriamente el Producto',
                    'id' => $item->iditem
                ]);
            }

            return response()->json([
                self::SUCCESS => false, self::MESSAGE => 'Ha ocurrido un error al intentar guardar el Producto'
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
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        try {
            $result = Item::where('iditem', $id)->get();
            return response()->json([
                self::SUCCESS => true, self::DATA => $result[0]
            ]);
        } catch (\Exception $e) {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => $e->getMessage()
            ]);
        }
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

    private function notExists($item, $id)
    {
        $elements = Item::where('itemname', $item);
        if ($id !== null) {
            $elements = $elements->where('iditem', '!=' , $id);
        }
        $count = $elements->count();
        return ($count === 0);
    }

}
