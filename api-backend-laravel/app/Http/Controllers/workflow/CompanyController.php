<?php

namespace App\Http\Controllers\workflow;

use App\Models\schema_public\Company;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class CompanyController extends Controller
{

    private const SUCCESS = 'success';
    private const MESSAGE = 'message';
    private const DATA = 'data';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        try {
            $result = Company::get();
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
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        try {
            $path = null;
            if ($request->hasFile('file')) {
                $dirupload = 'uploads/image';
                $file = $request->file('file');
                $destinationPath = public_path() . '/' . $dirupload;
                $name = 'logo-'.time().'.'.$file->getClientOriginalExtension();
                if($file->move($destinationPath, $name)) {
                    $path = $dirupload . '/' . $name;
                }
            }
            $data = json_decode($request->get('data'));
            if ($data->idcompany != 0) {
                $item = Company::find($data->idcompany);
            } else {
                $item = new Company();
            }

            $item->businessname = $data->businessname;
            $item->tradename = $data->tradename;
            $item->identify = $data->identify;
            $item->phone = $data->phone;
            $item->address = $data->address;
            $item->email = $data->email;
            $item->urlweb = $data->urlweb;

            if ($path != null) {
                $item->image = $path;
            }

            if ($item->save()) {
                return response()->json([
                    self::SUCCESS => true, self::MESSAGE => 'Se ha guardado satisfactoriamente el Producto'
                ]);
            } else {
                return response()->json([
                    self::SUCCESS => false, self::MESSAGE => 'Ha ocurrido un error al intentar guardar el Producto'
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
