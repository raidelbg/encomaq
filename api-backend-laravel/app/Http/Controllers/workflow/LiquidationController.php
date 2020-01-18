<?php

namespace App\Http\Controllers\workflow;

use App\Http\Controllers\Controller;
use App\Models\schema_public\Liquidation;
use Illuminate\Http\Request;

class LiquidationController extends Controller
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

            $filtro = json_decode($request->get('filter'));

            $sql = '';
            if ($filtro->search != '') {
                $sql .= ' OR biz_liquidation.idliquidation IN (';
                $sql .= ' SELECT biz_liquidation_project.idliquidation FROM biz_liquidation_project WHERE biz_liquidation_project.idproject IN ( ';
                $sql .= ' SELECT biz_project.idproject FROM biz_project  WHERE biz_project.idclient IN (';
                $sql .= ' SELECT biz_client.idclient FROM biz_client  WHERE  businessname LIKE '%".$filtro->search."%') ) )';
            }

            /*if ($filtro->idproject != '') {
                $sql .= ' AND biz_liquidation.idliquidation IN ( ';
                $sql .= ' SELECT biz_liquidation_project.idliquidation FROM biz_liquidation_project WHERE biz_liquidation_project.idproject = ' . $filtro->idproject . ' ) ';
            }*/

            $data = Liquidation::with("biz_liquidationproject.biz_project.biz_client",
                "biz_referralguideliquidation.biz_referralguide.biz_contract.biz_client",
                "biz_referralguideliquidation.biz_referralguide.biz_Referralguideitem.biz_item",
                "biz_referralguideliquidation.biz_referralguide.nom_transferreason"
            )
            ->whereRaw("biz_liquidation.state='".$filtro->state."' AND ( biz_liquidation.number LIKE '%".$filtro->search."%' ".$sql." )")
            ->orderBy("".$filtro->column, "".$filtro->order);

            return response()->json([
                self::SUCCESS => true, self::DATA => $data->paginate($filtro->num_page)
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
