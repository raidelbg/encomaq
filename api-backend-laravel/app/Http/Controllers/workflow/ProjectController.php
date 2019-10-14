<?php

namespace App\Http\Controllers\workflow;

use App\Models\schema_public\Project;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ProjectController extends Controller
{

    private const SUCCESS = 'success';
    private const MESSAGE = 'message';
    private const FIELD_DUPLICATE = 'projectname';


    /**
     * Display a listing of the resource.
     *
     * @param Request $request
     * @return Project[]|\Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection
     */
    public function index(Request $request)
    {
        $filter = json_decode($request->get('filter'));

        $where = "(place LIKE '%" . $filter->search . "%' OR projectname LIKE '%" . $filter->search . "%') ";
        $where .= "AND state = " . $filter->state;

        return Project::with('biz_client')->whereRaw($where)->orderBy($filter->column, $filter->order)->get();
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
        $item = new Project();
        if ( ! $this->exists($request->input(self::FIELD_DUPLICATE), null) ) {
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
        $item = Project::find($id);
        if ( ! $this->exists($request->input(self::FIELD_DUPLICATE), $id) ) {
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
        $item = Project::find($id);

        if ($item->delete()) {
            return response()->json([
                self::SUCCESS => true, self::MESSAGE => 'Se eliminó satisfactoriamente'
            ]);
        } else {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => 'Ha ocurrido un error al intentar eliminar'
            ]);
        }
    }

    private function exists($item, $id)
    {
        $elements = Project::where('projectname', $item);
        if ($id != null) {
            $elements = $elements->where('idproject', '!=' , $id);
        }
        $count = $elements->count();
        return ($count == 0);
    }

    private function action(Project $item, Request $request, $typeAction)
    {
        $item->idclient = $request->input('idclient');
        $item->projectname = $request->input('projectname');
        $item->place = $request->input('place');
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
