<?php

namespace App\Http\Controllers\workflow;

use App\Models\schema_public\PaymentForm;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class PaymentFormController extends Controller
{

    private const SUCCESS = 'success';
    private const MESSAGE = 'message';
    private const DATA = 'data';
    private const FIELD_DUPLICATE = 'paymentformname';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        try {
            $result = PaymentForm::orderBy('paymentformname', 'asc')->get();
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
            $item = new PaymentForm();
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
            $item = PaymentForm::find($id);
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
           $item = PaymentForm::find($id);
           if ($item->delete()) {
               return response()->json([self::SUCCESS => true, self::MESSAGE => 'Se eliminó satisfactoriamente' ]);
           } else {
               return response()->json([self::SUCCESS => false, self::MESSAGE => 'Ha ocurrido un error al intentar eliminar' ]);
           }
        } catch (\Exception $e) {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => $e->getMessage()
            ]);
        }
    }

    private function notExists($item, $id)
    {
        $elements = PaymentForm::where('paymentformname', $item);
        if ($id != null) {
            $elements = $elements->where('idpaymentform', '!=' , $id);
        }
        $count = $elements->count();
        return ($count === 0);
    }

    private function action(PaymentForm $item, Request $request, $typeAction)
    {
        try {
            $item->paymentformname = strtoupper($request->input('paymentformname'));
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
