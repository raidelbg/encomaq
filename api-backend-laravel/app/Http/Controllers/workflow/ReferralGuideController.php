<?php

namespace App\Http\Controllers\workflow;

use App\Http\Controllers\Controller;
use App\Models\shema_public\ReferralGuide;
use Illuminate\Http\Request;

class ReferralGuideController extends Controller
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
            $where .= "AND biz_referralguide.state = " . $filter->state;

            if ($filter->transferreason !== '') {
                $where .= ' AND biz_referralguide.idtransferreason = ' . $filter->transferreason;
            }

            $select = 'biz_referralguide.*, biz_client.businessname, biz_client.identify, biz_contract.nocontract, ';
            $select .= 'nom_transferreason.transferreasonname, nom_transferreason.idtypetransferreason, biz_carrier.carriername, biz_carrier.licenseplate, ';
            $select .= 'biz_project.projectname, biz_warehouse.warehousename';

            $result = ReferralGuide::join('biz_contract', 'biz_contract.idcontract', '=', 'biz_referralguide.idcontract')
                ->join('biz_client', 'biz_client.idclient', '=', 'biz_contract.idclient')
                ->join('biz_carrier', 'biz_carrier.idcarrier', '=', 'biz_referralguide.idcarrier')
                ->join('biz_project', 'biz_project.idproject', '=', 'biz_referralguide.idproject')
                ->join('biz_warehouse', 'biz_warehouse.idwarehouse', '=', 'biz_referralguide.idwarehouse')
                ->join('nom_transferreason', 'nom_transferreason.idtransferreason', '=', 'biz_referralguide.idtransferreason')
                ->whereRaw($where)->orderBy($filter->column, $filter->order)
                ->selectRaw($select)
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
