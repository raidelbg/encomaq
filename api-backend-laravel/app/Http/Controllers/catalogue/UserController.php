<?php

namespace App\Http\Controllers\catalogue;

use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return User[]|\Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection
     */
    public function index(Request $request)
    {
        $filter = json_decode($request->get('filter'));
        $where = "(personname LIKE '%" . $filter->search . "%' OR lastnameperson LIKE '%" . $filter->search . "%' OR ";
        $where .= "email LIKE '%" . $filter->search . "%') AND state = " . $filter->state;
        if ($filter->idrole != '') {
            $where .= ' AND idrole = ' . $filter->idrole;
        }

        return User::with('role')->whereRaw($where)->orderBy($filter->column, $filter->order)->get();
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
        $item = new User();

        if ($this->exists($request->input('email'), null) ==  false) {
            return $this->action($item, $request, 'add');
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Ha ocurrido un error al intentar agregar, ya se encuentra registrado.'
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
        $item = User::find($id);

        if ($this->exists($request->input('email'), $id) ==  false) {
            return $this->action($item, $request, 'update');
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Ha ocurrido un error al intentar editar, ya se encuentra registrado.'
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
        $item = User::find($id);

        if ($item->delete()) {
            return response()->json(['success' => true, 'message' => 'Se eliminó satisfactoriamente' ]);
        } else {
            return response()->json(['success' => false, 'message' => 'Ha ocurrido un error al intentar eliminar' ]);
        }
    }

    private function exists($item, $id)
    {
        $elements = User::where('email', $item);
        if ($id != null) {
            $elements = $elements->where('iduser', '!=' , $id);
        }
        $count = $elements->count();
        return ($count == 0) ? false : true;
    }

    private function action(User $item, Request $request, $typeAction)
    {
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
