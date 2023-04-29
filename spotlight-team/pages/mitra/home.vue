<template>
    <div class="page-content-wrapper">
        <Loader :isLoading="isLoading" />
        <!-- Welcome Toast -->
        <!-- <div class="toast toast-autohide custom-toast-1 toast-success home-page-toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="7000" data-bs-autohide="true">
            <div class="toast-body">
                <svg class="bi bi-bookmark-check text-white" width="30" height="30" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"></path>
                    <path fill-rule="evenodd" d="M10.854 5.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 7.793l2.646-2.647a.5.5 0 0 1 .708 0z"></path>
                </svg>
                <div class="toast-text ms-3 me-2">
                    <p class="mb-1 text-white">Welcome to Affan!</p>
                    <small class="d-block">Click the "Add to Home Screen" button &amp; enjoy it like an app.</small>
                </div>
            </div>
            <button class="btn btn-close btn-close-white position-absolute p-1" type="button" data-bs-dismiss="toast" aria-label="Close"></button>
        </div> -->
        <div class="pt-3"></div>
        <div class="container direction-rtl">
            <div class="d-flex align-items-center justify-content-between mb-4">
                <div class="card mx-3 col-5">
                    <NuxtLink to="/mitra/stock/first">
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="feature-card mx-auto text-center">
                                    <p class="mb-0">Stok Awal</p>
                                </div>
                            </div>
                        </div>
                    </NuxtLink>
                </div>
                <div class="card mx-3 col-5">
                    <NuxtLink to="/mitra/stock">
                        <div class="card-body">
                            <div class="row g-3">
                                    <div class="feature-card mx-auto text-center">
                                        <p class="mb-0">Stok Toko</p>
                                    </div>
                            </div>
                        </div>
                    </NuxtLink>
                </div>
            </div>
            <div class="d-flex align-items-center justify-content-between mb-4">
                <div class="card mx-3 col-5">
                    <NuxtLink to="/mitra/sales/list">
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="feature-card mx-auto text-center">
                                    <p class="mb-0">Penjualan</p>
                                </div>
                            </div>
                        </div>
                    </NuxtLink>
                </div>
                <div class="card mx-3 col-5">
                    <NuxtLink to="/mitra/expenses">
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="feature-card mx-auto text-center">
                                    <p class="mb-0">Pengeluaran</p>
                                </div>
                            </div>
                        </div>
                    </NuxtLink>
                </div>
            </div>
            <div class="d-flex align-items-center justify-content-between mb-4">
                <div class="card mx-3 col-5">
                    <NuxtLink to="/mitra/partner/list">
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="feature-card mx-auto text-center">
                                    <p class="mb-0">Mitra</p>
                                </div>
                            </div>
                        </div>
                    </NuxtLink>
                </div>
                <div class="card mx-3 col-5">
                    <NuxtLink to="/mitra/report">
                        <div class="card-body">
                            <div class="row g-3">
                                    <div class="feature-card mx-auto text-center">
                                        <p class="mb-0">Laporan</p>
                                    </div>
                            </div>
                        </div>
                    </NuxtLink>
                </div>
            </div>
            <div class="d-flex align-items-center justify-content-between mb-4">
                <div class="card mx-3 col-5">
                    <NuxtLink to="/mitra/balance">
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="feature-card mx-auto text-center">
                                    <p class="mb-0">Saldo</p>
                                </div>
                            </div>
                        </div>
                    </NuxtLink>
                </div>
                <div class="card mx-3 col-5">
                    <NuxtLink to="/mitra/profile">
                        <div class="card-body">
                            <div class="row g-3">
                                    <div class="feature-card mx-auto text-center">
                                        <p class="mb-0">Profile</p>
                                    </div>
                            </div>
                        </div>
                    </NuxtLink>
                </div>
            </div>
            <div class="card mx-3">
                    <NuxtLink to="/mitra/tracking">
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="feature-card mx-auto text-center">
                                    <p class="mb-0">Tracking Mitra</p>
                                </div>
                            </div>
                        </div>
                    </NuxtLink>
                </div>
        </div>
        <div class="pb-3"></div>
    </div>
</template>
<script>
import Loader from '../../components/Loader';
import Toast from '../../components/Toast';
export default {
    layout: 'layoutMitra',
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
        this.isLoading = false
        console.log(this.data)
        console.log(this.$auth.user);
    },
    methods: {
    }
}
</script>