<template>
    <div>
        <!-- ////////////////////////////////// Preloader //////////////////////////////// -->
        <!-- Preloader -->
        <div id="preloader" v-if="isLoading==true">
        <div class="spinner-grow text-primary" role="status"><span class="visually-hidden">Loading...</span></div>
        </div>
        <!-- Internet Connection Status -->
        <!-- # This code for showing internet connection status -->
        <div class="internet-connection-status" id="internetStatus"></div>
    </div>
</template>

<script>
export default {
    name: 'Loader',
    props: {
        isLoading: {
            type: Boolean,
            default: true
        }
    },
    data() {
        return {
            
        }
    },
    mounted() {
    }
}
</script>