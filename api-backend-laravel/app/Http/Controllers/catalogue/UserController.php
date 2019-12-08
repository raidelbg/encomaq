<?php

namespace App\Http\Controllers\catalogue;

use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{

    private const SUCCESS = 'success';
    private const MESSAGE = 'message';
    private const DATA = 'data';
    private const FIELD_DUPLICATE = 'email';

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
            $where = "(personname LIKE '%" . $filter->search . "%' OR lastnameperson LIKE '%" . $filter->search . "%' OR ";
            $where .= "email LIKE '%" . $filter->search . "%') AND state = " . $filter->state;
            if ($filter->idrole != '') {
                $where .= ' AND idrole = ' . $filter->idrole;
            }
            $result = User::with('role')->whereRaw($where)->orderBy($filter->column, $filter->order)->get();
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
            $item = new User();
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
            $item = User::find($id);
            if ( ! $this->notExists($request->input(self::FIELD_DUPLICATE), $id) ) {
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
            $item = User::find($id);
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

    private function notExists($item, $id)
    {
        $elements = User::where('email', $item);
        if ($id != null) {
            $elements = $elements->where('iduser', '!=' , $id);
        }
        $count = $elements->count();
        return ($count == 0);
    }

    private function action(User $item, Request $request, $typeAction)
    {
        try {
            $item->idrole = $request->input('idrole');
            $item->personname = $request->input('personname');
            $item->lastnameperson = $request->input('lastnameperson');
            $item->email = $request->input('email');
            $item->state = ($request->input('state') === true || $request->input('state') === 1) ? 1 : 0;
            if ($request->input('password') !== false) {
                $item->password = Hash::make($request->input('password'));
            }
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
