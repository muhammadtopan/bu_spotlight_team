<?php

namespace App\Http\Middleware;

use Closure;

class isAgen
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        // Masih Free Role
        // if (auth()->user() && auth()->user()->role == 'distributor') {
        if (auth()->user() && auth()->user()->status == 'active') {
            return $next($request);
        }
        return response('Unauthorized.', 401);
    }
}
