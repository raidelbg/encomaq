<?php

namespace App\Http\Controllers\workflow;

use App\Models\schema_public\Item;
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
    public function index(Request $request)
    {
        try {
            $filter = json_decode($request->get('filter'));
            $otherWhere = '';
            if ($filter->idcategoryitem != '') {
                $otherWhere .= ' AND idcategoryitem = ' . $filter->idcategoryitem;
            }
            if ($filter->idunittype != '') {
                $otherWhere .= ' AND idunittype = ' . $filter->idunittype;
            }
            $where = "(itemname LIKE '%" . $filter->search . "%' OR description LIKE '%" . $filter->search . "%' ) ";
            $where .= "AND state = " . $filter->state;
            $where .= $otherWhere;
            $result = Item::with('nom_categoryitem','nom_unittype', 'biz_itemprice')->whereRaw($where)
                ->orderBy($filter->column, $filter->order)->paginate($filter->num_page);
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
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
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

    private function notExists($item, $id)
    {
        $elements = Item::where('itemname', $item);
        if ($id != null) {
            $elements = $elements->where('iditem', '!=' , $id);
        }
        $count = $elements->count();
        return ($count === 0);
    }

}
