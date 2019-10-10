<?php

namespace App\Http\Controllers\catalogue;

use App\Models\schema_public\ConfigEmail;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ConfigEmailController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return ConfigEmail::get();
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
        $item = new ConfigEmail();
        return $this->action($item, $request, 'add');
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
        $item = ConfigEmail::find($id);
        return $this->action($item, $request, 'update');
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

    private function action(ConfigEmail $item, Request $request, $typeAction)
    {
        $item->driver = strtoupper($request->input('driver'));
        $item->server = $request->input('server');
        $item->port = $request->input('port');
        $item->encryptation = $request->input('encryptation');
        $item->useremail = $request->input('useremail');
        $item->passwordemail = $request->input('passwordemail');

        if ($item->save()) {
            return response()->json([
                'success' => true,
                'message' => ($typeAction === 'add') ? 'Se agregó satisfactoriamente' : 'Se editó satisfactoriamente'
            ]);
        } else {
            return response()->json([
                'success' => false,
                'message' => ($typeAction === 'add') ? 'Ha ocurrido un error al intentar agregar' : 'Ha ocurrido un error al intentar editar'
            ]);
        }
    }
}
