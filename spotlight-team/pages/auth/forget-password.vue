<template>
<!-- Login Wrapper Area -->
<div class="login-wrapper d-flex align-items-center justify-content-center">
    <Loader />
    <div class="custom-container">
        <div class="text-center px-4">
            <img class="login-intro-img" src="/img/bg-img/37.png" alt="">
        </div>
        <!-- Register Form -->
        <div class="register-form mt-4">
        <form action="forget-password-success.php">
            <div class="form-group text-start mb-3">
                <input class="form-control" type="text" placeholder="Masukan email untuk verifikasi">
            </div>
            <NuxtLink class="btn btn-primary w-100" to="/auth/forget-password-success">Ganti Password</NuxtLink>
            <!-- <button class="btn btn-primary w-100" type="submit">Ganti Password</button> -->
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