<?php

namespace App\Http\Controllers\report;

use App\Http\Controllers\Controller;
use App\Models\schema_public\Client;
use App\Models\schema_public\Contract;
use App\Models\schema_public\Liquidation;
use App\Models\schema_public\ReferralGuide;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    private const SUCCESS = 'success';
    private const MESSAGE = 'message';
    private const DATA = 'data';

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    public function countClients()
    {
        try {
            $count = Client::count();
            return response()->json([
                self::SUCCESS => true, self::DATA => $count
            ]);
        } catch (\Exception $e) {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => $e->getMessage()
            ]);
        }
    }

    public function countContracts()
    {
        try {
            $count = Contract::count();
            return response()->json([
                self::SUCCESS => true, self::DATA => $count
            ]);
        } catch (\Exception $e) {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => $e->getMessage()
            ]);
        }
    }

    public function countReferralGuides()
    {
        try {
            $count = ReferralGuide::count();
            return response()->json([
                self::SUCCESS => true, self::DATA => $count
            ]);
        } catch (\Exception $e) {
            return response()->json([
                self::SUCCESS => false, self::MESSAGE => $e->getMessage()
            ]);
        }
    }

    public function countLiquidations()
    {
        try {
            $count = Liquidation::count();
            return response()->json([
                self::SUCCESS => true, self::DATA => $count
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
