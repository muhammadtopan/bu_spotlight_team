<template>
<!-- Login Wrapper Area -->
<div class="login-wrapper d-flex align-items-center justify-content-center">
    <Loader />
    <div class="custom-container">
        <div class="text-center px-4"><img class="login-intro-img" src="/img/bg-img/36.png" alt=""></div>
        <!-- Register Form -->
        <div class="register-form mt-4">
            <form>
                <div class="form-group text-start mb-3">
                    <input class="form-control" type="text" placeholder="Masukan 8 digit kode keamanan  ">
                </div>
                <div class="form-group text-start mb-3 position-relative">
                    <input class="form-control" id="psw-input" type="password" placeholder="Password baru">
                    <div class="position-absolute" id="password-visibility">
                        <i class="bi bi-eye"></i><i class="bi bi-eye-slash"></i>
                    </div>
                </div>  
                <!-- <div class="mb-3" id="pswmeter"></div> -->
                <div class="form-group text-start mb-3">
                    <input class="form-control" type="password" placeholder="Konfirmasi password">
                </div>
                <NuxtLink class="btn btn-primary w-100" to="/login">Update Password</NuxtLink>
                <!-- <button class="btn btn-primary w-100" type="submit">Update Password</button> -->
            </form>
        </div>
    </div>
</div>
</template>

<script>
import Loader from '../../components/Loader.vue';
export default {
    layout: 'layoutAuth',
    components: {
        Loader
    },
    data() {
        return {
        }
    },
    mounted() {
    }
}
</script>