<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Log;

class AuthController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login']]);
    }

    public function login(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'email' => 'required|string',
            'password' => 'required|string'
        ]);

        if($validator->fails()){
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        $credentials = $request->only('email', 'password');

        $token = auth()->attempt($credentials);

        if(!$token){
            return response()->json([
                'message' => 'Email or password incorrect'
            ], 401);
        }

        return response()->json([
            'message' => 'Login successful',
            'data' => [
                'user' => Auth::user(),
                'access_token' => $token
            ]
        ], 200);
    }

    public function me()
    {
        $this->authCheck();        

        return response()->json([
            'message' => 'User details by token',
            'data' => Auth::user()
        ], 200);
    }

    public function logout()
    {
        auth()->logout();

        return response()->json([
            'message' => 'Logout successful'
        ], 200);
    }

    public function refresh()
    {
        $this->authCheck();

        return response()->json([
            'message' => 'Token refreshed',
            'data' => [
                'access_token' => auth()->refresh()
            ]
        ], 200);
    }

    public function authCheck()
    {
        if(!Auth::check()){
            return response()->json([
                'message' => 'Unauthorized'
            ], 401);
        }
    }
}
