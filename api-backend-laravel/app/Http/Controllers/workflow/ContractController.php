<?php

namespace App\Http\Controllers\workflow;

use App\Http\Controllers\Controller;
use App\Models\schema_public\Contract;
use App\Models\schema_public\ContractItem;
use App\Models\schema_public\ContractPaymentForm;
use App\Models\schema_public\PaymentForm;
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
            $where .= "AND biz_contract.state = " . $filter->state;
            $result = Contract::with(
                [
                    'biz_client.biz_project', 'nom_categoryitem', 'biz_period',
                    'biz_contractitem.biz_item', 'biz_contractpaymentform.biz_paymentform']
            )
                ->whereRaw($where)->orderBy($filter->column, $filter->order)
                ->join("biz_client","biz_client.idclient","=","biz_contract.idclient")
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
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        try {
            $item = new Contract();
            return $this->action($item, $request, 'add');
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

    private function action(Contract $item, Request $request, $typeAction)
    {
        try {
            $item->idclient = $request->input('idclient');
            $item->idperiod = $request->input('idperiod');
            $item->idcategoryitem = $request->input('idcategoryitem');
            $item->nocontract = $request->input('nocontract');
            $item->startdate = $request->input('startdate');
            $item->enddate = $request->input('enddate');
            $item->area = $request->input('area');
            $item->period = $request->input('period');
            $item->cost = $request->input('cost');
            $item->observation = $request->input('observation');
            $item->receipt = $request->input('receipt');
            $item->invoice = $request->input('invoice');
            $item->state = ($request->input('state') === true || $request->input('state') === 1) ? 1 : 0;
            if ($item->save()) {

                $resultPaymentForm = $this->actionPaymentForm($item->idcontract, $request->input('paymentform'));
                if ($resultPaymentForm->{self::SUCCESS}) {
                    $resultItems = $this->actionItem($item->idcontract, $request->input('items'));
                    if ($resultItems->{self::SUCCESS}) {
                        return response()->json([
                            self::SUCCESS => true,
                            self::MESSAGE => ($typeAction === 'add') ? 'Se agregó satisfactoriamente' : 'Se editó satisfactoriamente'
                        ]);
                    } else {
                        return response()->json([
                            self::SUCCESS => false,
                            self::MESSAGE => $resultItems->{self::MESSAGE}
                        ]);
                    }
                } else {
                    return response()->json([
                        self::SUCCESS => false,
                        self::MESSAGE => $resultPaymentForm->{self::MESSAGE}
                    ]);
                }

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

    private function actionPaymentForm($idContract, $paymentForms)
    {
        $result = new \stdClass();

        try {

            $count = ContractPaymentForm::where('idcontract', $idContract)->count();
            if ($count != 0) {
                ContractPaymentForm::where('idcontract', $idContract)->deleted();
            }

            foreach ($paymentForms as $paymentForm) {
                $payment = new ContractPaymentForm();
                $payment->idcontract = $idContract;
                $payment->idpaymentform = $paymentForm['idpaymentform'];
                $payment->cost = $paymentForm['value'];
                if (!$payment->save()) {
                    $result->{self::SUCCESS} = false;
                    $result->{self::MESSAGE} = 'Ha ocurrido un error al intentar guardar las garantías';
                    return $result;
                }
            }

            $result->{self::SUCCESS} = true;
            return $result;

        } catch (\Exception $e) {
            $result->{self::SUCCESS} = false;
            $result->{self::MESSAGE} = $e->getMessage();
            return $result;
        }
    }

    private function actionItem($idContract, $items)
    {
        $result = new \stdClass();

        try {

            $count = ContractItem::where('idcontract', $idContract)->count();
            if ($count != 0) {
                ContractItem::where('idcontract', $idContract)->deleted();
            }

            foreach ($items as $item) {
                $element= new ContractItem();
                $element->idcontract = $idContract;
                $element->iditem = $item['iditem'];
                $element->quantity = $item['count'];
                $element->observation = $item['observation'];
                if (!$element->save()) {
                    $result->{self::SUCCESS} = false;
                    $result->{self::MESSAGE} = 'Ha ocurrido un error al intentar guardar los productos';
                    return $result;
                }
            }

            $result->{self::SUCCESS} = true;
            return $result;

        } catch (\Exception $e) {
            $result->{self::SUCCESS} = false;
            $result->{self::MESSAGE} = $e->getMessage();
            return $result;
        }
    }
}
