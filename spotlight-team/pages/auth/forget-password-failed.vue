<template>
<!-- Wrapper -->
<div class="login-wrapper d-flex align-items-center justify-content-center text-center">
    <Loader />
    <div class="custom-container">
        <div class="text-center px-4">
            <img class="login-intro-img mb-4" src="/img/bg-img/38.png" alt="">
            <!-- Reset Password Message -->
            <p class="mb-4">Ooops! Email yang kamu input belum terdafar. Silahkan coba lagi atau hubungi <a href="https://api.whatsapp.com/send?phone=6282363878350">admin </a> untuk info lebih lanjud.</p>
            <!-- Go Back Button -->
            <NuxtLink class="btn btn-danger" to="/auth/forget-password">Coba Lagi</NuxtLink>
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