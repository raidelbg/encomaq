<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function signin(Request $request)
    {
        if (Auth::attempt($request->only('email', 'password'))) {
            $user = Auth::user();
            $token =  $user->createToken('MyAppFacturaDigital')->accessToken;
            return response()->json([
                'success'=> true,
                'token' => $token,
                'user' => $user
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'error' => 'Unauthorized',
                'status' => 401,
                'message' => 'Email o password incorrecto'
            ]);
        }
    }

    public function create(Request $request)
    {
        $item = new User();
        $item->name = $request->input('name');
        $item->email = $request->input('email');
        $item->password = Hash::make($request->input('password'));
        if ($item->save()) {
            return response()->json(['success' => true ]);
        } else {
            return response()->json(['success' => false ]);
        }
    }
}
