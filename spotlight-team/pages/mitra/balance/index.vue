<template>
<!-- Content -->
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <Toast v-for="t in toast" v-bind:key="t.range" :data="t" />
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Saldo</h6>
        </div>
    </div>
    <div class="container direction-rtl" v-for="(d,i) in data">
        <div class="card mb-3">
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-3">
                        <div class="feature-card mx-auto text-center">
                            <div class="card mx-auto border bg-light">
                                <img v-if="d.bank!='Cash'" :src="d.logo" :alt="d.bank">
                                <i v-else class="bi bi-currency-dollar text-success"></i>
                            </div>
                            <p class="mb-0">{{ d.bank }}</p>
                        </div>
                    </div>
                    <div class="col-6 my-auto">
                        <div class="feature-card text-center">
                            <h6 class="mb-0">{{ formatWithoutRp(d.sum) }}</h6>
                            <p class="mb-0">rupiah</p>
                        </div>
                    </div>
                    <div class="col-3 my-auto">
                        <div class="feature-card text-center">
                            <button type="button" @click="detailBalance(d.bank)" class="btn btn-creative btn-warning"><i class="bi bi-eye"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="pb-3"></div>
</div>
</template>
<script>
import Loader from '../../../components/Loader';
import Toast from '../../../components/Toast';
var _ = require('lodash');
export default {
    layout: 'layoutMitra',
    components: {
        Toast,
        Loader
    },
    data() {
        return {
            isLoading: true,
            toast: [],
            data: [],
        }
    },
    async mounted() {
        console.log("mounted");
        const data = await this.$axios.$get('/mitra/balance/fetch')
        if(data.status == 'success'){
            this.data = data.data
            this.isLoading = false
            console.log(this.data);
        }
    },
    methods: {
        detailBalance(bank){
            localStorage.setItem('bank', bank);
            console.log(localStorage.getItem('bank'));
            this.$router.push('/mitra/balance/detail');
        },
        formatWithoutRp(angka, prefix = 'Rp ') {
            var number_string = parseInt(angka).toString().replace(/[^,\d]/g, ""),
                split = number_string.split(","),
                sisa = split[0].length % 3,
                rupiah = split[0].substr(0, sisa),
                ribuan = split[0].substr(sisa).match(/\d{3}/gi);

            // tambahkan titik jika yang di input sudah menjadi angka ribuan
            if (ribuan) {
                let separator = sisa ? "." : "";
                rupiah += separator + ribuan.join(".");
            }

            rupiah = split[1] != undefined ? rupiah + "," + split[1] : rupiah;
            return prefix == undefined ? rupiah : rupiah ? rupiah : "";
        },
    },
    computed: {
    }
}
</script>