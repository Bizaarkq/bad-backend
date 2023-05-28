<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class PedidoController extends Controller
{
    public function getPedidos(Request $request)
    {
        $pedidos = DB::table('pedido as ped')
            ->join('cliente as cli', 'ped.id_cli', '=', 'cli.id_cli')
            ->select('ped.*', 'cli.*')
            ->get();

        return response()->json([
            'message' => 'Pedidos list',
            'data' => $pedidos
        ], 200);
    }
}
