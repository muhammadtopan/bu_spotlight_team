<template>
<!-- Wrapper -->
<div class="login-wrapper d-flex align-items-center justify-content-center text-center">
    <Loader />
    <div class="custom-container">
        <div class="text-center px-4"><img class="login-intro-img mb-4" src="/img/bg-img/38.png" alt="">
        <h3>Check emailmu!</h3>
        <p class="mb-4">Kami telah mengirimkan email pemulihan kata sandi di email Anda. Email ini berisi 8 digit kode keamanan.</p>
        <!-- Go Back Button --><NuxtLink class="btn btn-primary" to="/auth/change-password">Change Password</NuxtLink>
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