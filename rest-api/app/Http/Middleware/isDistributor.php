<?php

namespace App\Http\Middleware;

use Closure;

class isDistributor
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
        if (auth()->user() && auth()->user()->role == 'distributor') {
            return $next($request);
        }
        return response('Unauthorized.', 401);
    }
}
