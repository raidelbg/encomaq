<?php

namespace App\Http\Controllers\workflow;

use App\Models\schema_public\Client;
use App\Models\schema_public\Company;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ClientController extends Controller
{

    private const SUCCESS = 'success';
    private const MESSAGE = 'message';
    private const FIELD_DUPLICATE = 'identify';

    /**
     * Display a listing of the resource.
     *
     * @param Request $request
     * @return Client[]|\Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection
     */
    public function index(Request $request)
    {
        $filter = json_decode($request->get('filter'));

        $where = "(businessname LIKE '%" . $filter->search . "%' OR identify LIKE '%" . $filter->search . "%') ";
        $where .= "AND state = " . $filter->state;

        return Client::with('nom_identifytype')->whereRaw($where)->orderBy($filter->column, $filter->order)->get();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $item = new Client();

        if (!$this->exists($request->input(self::FIELD_DUPLICATE), null)) {
            return $this->action($item, $request, 'add');
        } else {
            return response()->json([
                self::SUCCESS => false,
                self::MESSAGE => 'Ha ocurrido un error al intentar agregar, ya se encuentra registrado.'
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
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
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
        $item = Client::find($id);

        if (!$this->exists($request->input(self::FIELD_DUPLICATE), $id)) {
            return $this->action($item, $request, 'update');
        } else {
            return response()->json([
                self::SUCCESS => false,
                self::MESSAGE => 'Ha ocurrido un error al intentar editar, ya se encuentra registrado.'
            ]);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $item = Client::find($id);

        if ($item->delete()) {
            return response()->json([self::SUCCESS => true, self::MESSAGE => 'Se eliminó satisfactoriamente' ]);
        } else {
            return response()->json([self::SUCCESS => false, self::MESSAGE => 'Ha ocurrido un error al intentar eliminar' ]);
        }
    }

    public function exportToPDF(Request $request)
    {
        ini_set('max_execution_time', 300);

        $filter = json_decode($request->get('filter'));

        $where = "(businessname LIKE '%" . $filter->search . "%' OR identify LIKE '%" . $filter->search . "%') ";
        $where .= "AND state = " . $filter->state;

        $data = Client::with('nom_identifytype')->whereRaw($where)->orderBy($filter->column, $filter->order)->get();
        $company = Company::all();
        $today = date("Y-m-d H:i:s");

        $view =  \View::make('templatesExportToPDF.listClient', compact('data','company'))->render();
        $pdf = \App::make('dompdf.wrapper');
        $pdf->loadHTML($view);
        $pdf->setPaper('A4', 'landscape');

        return $pdf->stream('ListaDeClientes' . $today.'.pdf');
    }

    private function exists($item, $id)
    {
        $elements = Client::where('identify', $item);
        if ($id != null) {
            $elements = $elements->where('idclient', '!=' , $id);
        }
        $count = $elements->count();
        return ($count == 0);
    }

    private function action(Client $item, Request $request, $typeAction)
    {
        $item->ididentifytype = $request->input('ididentifytype');
        $item->identify = $request->input('identify');
        $item->businessname = $request->input('businessname');
        $item->phone = $request->input('phone');
        $item->phone_2 = $request->input('phone_2');
        $item->address = $request->input('address');
        $item->email = $request->input('email');
        $item->email_2 = $request->input('email_2');
        $item->email_3 = $request->input('email_3');
        $item->observation = $request->input('observation');
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
    }
}
