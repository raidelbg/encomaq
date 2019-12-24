<?php

namespace App\Http\Controllers\workflow;

use App\Http\Controllers\Controller;
use App\Models\schema_public\Contract;
use Illuminate\Http\Request;

class ContractController extends Controller
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
    public function index(Request $request)
    {
        try {
            $filter = json_decode($request->get('filter'));
            $where = "( biz_contract.nocontract LIKE '%" . $filter->search . "%' OR (biz_client.businessname LIKE '%" . $filter->search . "%' OR biz_client.identify LIKE '%" . $filter->search . "%') ) ";
            $where .= "AND state = " . $filter->state;
            $result = Contract::with(
                [
                    'biz_client.biz_project', 'nom_categoryitem', 'biz_period',
                    'biz_contractitem.biz_item', 'biz_contractpaymentform.biz_paymentform']
            )
                ->whereRaw($where)->orderBy($filter->column, $filter->order)
                ->paginate($filter->num_page);
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
}
