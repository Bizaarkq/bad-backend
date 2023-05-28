<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Auth;
use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;

class roleAuthorization
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next, ...$roles): Response
    {   
        try{
            $token = JWTAuth::parseToken();
            $user = $token->authenticate();
        }catch(JWTException $e){
            return response()->json([
                'message' => 'Unauthorized'
            ], 401);
        }

        if (!$user) {
            return response()->json([
                'message' => 'Usuario no encontrado'
            ], 401);
        }

        if($user && $user->hasAnyRole($roles)){
            return $next($request);          
        }

        return response()->json([
            'message' => 'Unauthorized'
        ], 401);
    }
}
