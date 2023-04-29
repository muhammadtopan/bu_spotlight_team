<template>
<!-- Hero Block Wrapper -->
<div class="hero-block-wrapper bg-primary">
    <Loader :isLoading="isLoading" />
    <!-- Styles -->
    <div class="hero-block-styles">
        <div class="hb-styles1" style="background-image: url('/img/core-img/dot.png')"></div>
        <div class="hb-styles2"></div>
        <div class="hb-styles3"></div>
    </div>
    <div class="custom-container">
        <!-- Skip Page -->
        <div class="skip-page"><NuxtLink to="/login">Lewati</NuxtLink></div>
        <!-- Hero Block Content -->
        <div class="hero-block-content"><img class="mb-4" src="/img/bg-img/19.png" alt="">
        <h2 class="display-4 text-white mb-3">Selamat datang diAplikasi Spotlight Team</h2>
        <p class="text-white">AST adalah aplikasi untuk memanajemen toko anggota tim Spotlight.</p><NuxtLink class="btn btn-warning btn-lg w-100" to="/login">Ayo Mulai!</NuxtLink>
        </div>
    </div>
</div>
</template>

<script>
import Loader from '../components/Loader.vue';
export default {
    layout: 'default',
    components: {
        Loader
    },
    data() {
        return {
            isLoading : true,
        }
    },
    mounted() {
        this.isLoading = false;
    }
}
</script>