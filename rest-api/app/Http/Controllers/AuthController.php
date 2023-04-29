<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\UserProfile;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function index(){
        return User::all();
    }

    public function getUserAuth(){
        $user = User::with('user_profile')->where('id',auth()->user()->id)->first();
        if($user->id!=99){
            $leader = User::where('id',auth()->user()->relation_id)->first();
            $user->leader = $leader->name;
        }
        return $user;
    }

    public function login(Request $request){
        // $validator = Validator::make($request->all(), [
        //     'name' => 'required',
        //     'email' => 'required|email',
        //     'password' => 'required'
        // ]);

        // if($validator->fails()){
        //     return response(['message' => 'Validation errors', 'errors' =>  $validator->errors(), 'status' => false], 422);
        // }
        // return $request->all();
        // return $request->password;
        if(!$request->email || !$request->password){
            return response()->json(['status'=>'error', 'message' => 'Email and password are required']);
        }

        $user = User::where([
                    ['email', $request->email],
                    ['status', '=', 'active'],
                ])->exists();
        if ($user === false) {
            $user = User::where([
                        ['email', $request->email],
                        ['status', '=', 'request'],
                    ])->exists();
            if ($user === false){
                return response()->json([
                    'status' => 'error', 
                    'message' => 'User doesnt exist'
                ]);
            }
        }

        $client = new \GuzzleHttp\Client();
        try{
            $tokenRequest = $request->create(
                // config('service.passport.login_endpoint'),
                '/v1/oauth/token',
                'POST'
            );

            $tokenRequest->request->add([
                "grant_type" => "password",
                "username" => $request->email,
                "password" => $request->password,
                "client_id" => config('service.passport.client_id'),
                "client_secret" => config('service.passport.client_secret'),
            ]);

            $response = app()->handle($tokenRequest);
            return $response;
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error', 
                'message' => $e->getMessage()
            ]);
        }
    }

    public function register(Request $r){
        if(!$r->name || !$r->email || !$r->password){
            return response()->json(['status'=>'error', 'message' => 'Name, Email and password are required']);
        }

        if(User::where('email', $r->email)->exists()){
            return response()->json(['status'=>'error', 'message' => 'User already exists']);
        }

        $user = new User;
        $user->name = $r->name;
        $user->email = $r->email;
        $user->password = app('hash')->make($r->password);
        $user->save();

        return response()->json(['status' => 'success', 'message' => 'User has been created']);
    }

    public function logout(Request $r){
        try {
            auth()->user()->tokens->each(function ($token, $key) {
                $token->delete();
            });
            return response()->json(['status' => 'success', 'message' => 'Logout success']);
        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }

    public function verifyForm(Request $r){
        try {
            try{
                \DB::beginTransaction();
                $c = new \Carbon\Carbon;

                $d = json_decode($r->data, true);

                $user = User::where('id', auth()->user()->id)->first();
                $user->verify_at = $c->now();
                $user->save();

                $user_profile = UserProfile::where('user_id', auth()->user()->id)->first();
                $user_profile->name = $d['user_profile']['name'];
                $user_profile->phone = $d['user_profile']['phone'];
                $user_profile->domicile = $d['user_profile']['domicile'];
                $user_profile->address = $d['user_profile']['address'];
                $user_profile->city = $d['user_profile']['city'];
                $user_profile->province = $d['user_profile']['province'];
                $user_profile->profession = $d['user_profile']['profession'];
                $user_profile->born = $d['user_profile']['born'];
                $user_profile->join_at = $d['user_profile']['join_at'];
                $user_profile->nearest_distributor = $d['user_profile']['nearest_distributor'];
                $user_profile->google_business = $d['user_profile']['google_business'];
                $user_profile->fb = $d['user_profile']['fb'];
                $user_profile->ig = $d['user_profile']['ig'];
                $user_profile->shoopee = $d['user_profile']['shoopee'];
                $user_profile->tokopedia = $d['user_profile']['tokopedia'];
                $user_profile->lazada = $d['user_profile']['lazada'];
                $user_profile->tiktok = $d['user_profile']['tiktok'];
                $user_profile->motto = $d['user_profile']['motto'];
                $user_profile->tf_unix = $d['user_profile']['tf_unix'];
                $user_profile->tf_date = $d['user_profile']['tf_date'];
                
                // upload ktp
                if ($r->hasFile('photo_ktp') && (
                    strtolower($r->photo_ktp->getClientMimeType()) == 'image/jpeg' ||
                    strtolower($r->photo_ktp->getClientMimeType()) == 'image/jpg' ||
                    strtolower($r->photo_ktp->getClientMimeType()) == 'image/png'
                    )){

                    $file_ktp = $r->photo_ktp;
                    if (strtolower($file_ktp->getClientMimeType()) == 'image/jpeg') {
                        $image = imagecreatefromjpeg($file_ktp);
                    } elseif (strtolower($file_ktp->getClientMimeType()) == 'image/png') {
                        $image = imagecreatefrompng($file_ktp);
                    } elseif (strtolower($file_ktp->getClientMimeType()) == 'image/jpg') {
                        $image = imagecreatefromjpeg($file_ktp);
                    }
                    
                    // deleteImageFromServer($d['user_profile']['ktp']);

                    $photo = time().'.jpg';
                    $url = 'images/ktp/' . $photo;
                    imagejpeg($image, public_path($url), 80); // 0 = worst / smaller file, 100 = better / bigger file
                    $user_profile->ktp = '/'.$url;
                    imagedestroy($image);
                }

                // upload bukti tf
                if ($r->hasFile('photo_tf') && (
                    strtolower($r->photo_tf->getClientMimeType()) == 'image/jpeg' ||
                    strtolower($r->photo_tf->getClientMimeType()) == 'image/jpg' ||
                    strtolower($r->photo_tf->getClientMimeType()) == 'image/png'
                )){
                    $file_tf = $r->photo_tf;
                    if (strtolower($file_tf->getClientMimeType()) == 'image/jpeg') {
                        $image_tf = imagecreatefromjpeg($file_tf);
                    } elseif (strtolower($file_tf->getClientMimeType()) == 'image/png') {
                        $image_tf = imagecreatefrompng($file_tf);
                    } elseif (strtolower($file_tf->getClientMimeType()) == 'image/jpg') {
                        $image_tf = imagecreatefromjpeg($file_tf);
                    }

                    // \DB::beginTransaction();

                    // deleteImageFromServer($d['user_profile']['ktp']);

                    $photo_tf = time().'.jpg';
                    $url_tf = 'images/bukti-transfer/' . $photo_tf;
                    imagejpeg($image_tf, public_path($url_tf), 80); // 0 = worst / smaller file, 100 = better / bigger file
                    imagedestroy($image_tf);

                    $user_profile->photo_tf = '/'.$url_tf;
                    $user_profile->save();
                }
                \DB::commit();
                return [
                    'data' => [
                        'verify_at' => $user->verify_at
                    ],
                    'msg' => 'Berhasil melengkapi data',
                    'status' => 'success'
                ];

                return [
                    'data' => 'error image',
                    'msg' => 'bukti transfer belum di upload',
                    'status' => 'error'
                ];

            }
            catch(\Exception $e){
                \DB::rollback();
                return [
                    'data' => $e,
                    'status' => 'error'
                ];
            }
        } catch (\Throwable $th) {
            return [
                'data' => $th->getMessage(),
                'status' => 'error'
            ];
        }
    }
}
