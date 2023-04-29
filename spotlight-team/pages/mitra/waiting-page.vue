<template>
<!-- Hero Block Wrapper -->
<div class="hero-block-wrapper bg-primary">
    <!-- Styles -->
    <div class="hero-block-styles">
        <div class="hb-styles1" style="background-image: url('/img/core-img/dot.png')"></div>
        <div class="hb-styles2"></div>
        <div class="hb-styles3"></div>
    </div>
    <div class="custom-container">
        <!-- Hero Block Content -->
        <div class="hero-block-content"><img class="mb-4" src="/img/bg-img/19.png" alt="">
        <h2 class="display-4 text-white mb-3">Terimakasih, anda telah melakukan verifikasi akun</h2>
        <p class="text-white">Data anda sedang diproses, silahkan tunggu 1x24 jam</p><a class="btn btn-warning btn-lg w-100" href="../auth/login.php">Oke!</a>
        </div>
    </div>
</div>
</template>
<script>
import Loader from '../../components/Loader';
import Toast from '../../components/Toast';
export default {
    layout: 'default',
    components: {
        Toast,
        Loader
    },
    data() {
        return {
            isLoading: true,
            data : [],
        }
    },
    async mounted() {
    },
    methods: {
    },
    computed: {
    }
}
</script>