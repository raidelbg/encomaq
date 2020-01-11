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
                ->selectRaw('biz_contract.*, biz_client.idclient, biz_client.businessname, biz_client.identify, biz_client.address')
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

    public function getNoContract(Request $request)
    {
        try {

            return response()->json([
                self::SUCCESS => true,
                self::DATA => $this->getLastNoContract()
            ]);

        } catch (\Exception $e) {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => $e->getMessage()
            ]);
        }

    }

    public function resumeContract(Request $request)
    {
        try {

            $result = Contract::with([
                    'biz_client.biz_project', 'nom_categoryitem', 'biz_period',
                    'biz_contractitem.biz_item', 'biz_contractpaymentform.biz_paymentform']
            )
            ->orderBy('biz_contract.startdate', 'asc')
            ->selectRaw('biz_contract.*')
            ->get();
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
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, $id)
    {
        try {
            $item = Contract::find($id);
            return $this->action($item, $request, 'edit');
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
            $item = Contract::find($id);
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

    private function action(Contract $item, Request $request, $typeAction)
    {
        try {
            $item->idclient = $request->input('idclient');
            $item->idperiod = $request->input('idperiod');
            $item->idcategoryitem = $request->input('idcategoryitem');
            $item->nocontract = $this->verifyNoContract($request->input('nocontract'), $item->idcontract);
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
                ContractPaymentForm::where('idcontract', $idContract)->delete();
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
                ContractItem::where('idcontract', $idContract)->delete();
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

    private function verifyNoContract($nocontract, $id = null)
    {
        $search = str_pad((((int) $nocontract) ),9,'0', STR_PAD_LEFT );

        if ($id === null) {
            $result = Contract::where('nocontract', $search)->count();
        } else {
            $result = Contract::where('nocontract', $search)->where('idcontract', '!=', $id)->count();
        }

        if ($result != 0) {
            $search = $this->getLastNoContract();
        }

        return $search;
    }

    private function getLastNoContract()
    {
        $row = Contract::all();
        $last = $row->last();
        $num_contract = 0;
        if(  isset($last->nocontract) ) {
            $num_contract = $last->nocontract;
        }
        return str_pad((((int) $num_contract) + 1 ),9,'0', STR_PAD_LEFT );
    }

}
