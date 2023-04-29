<template>
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Stok {{ leader }}</h6>
        </div>
    </div>
    <div class="shop-pagination pb-3">
        <div class="container">
            <div class="card">
                <div class="card-body p-2">
                    <div class="d-flex align-items-center justify-content-between">
                        <small class="ms-1">Tambah Stok</small>
                        <NuxtLink class="btn btn-creative btn-warning" to="/mitra/stock/add">
                            <i class="bi bi-plus-circle"></i>
                        </NuxtLink>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="card">
            <div class="card-body table-responsive">
                <table class="table w-100" id="dataTableStock">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Produk</th>
                            <th>Harga</th>
                            <th>Stok</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(d,i) in dataDesc">
                            <td>{{ ++i }}</td>
                            <td>{{ d.product.name }}</td>
                            <td>{{ formatRp(d.price) }}</td>
                            <td>{{ d.stock<=10 ? 'Limit' : d.stock<=100 ? d.stock : '100+' }}</td>
                        </tr>
                    </tbody>
                </table>
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
            data : [],
            leader : ''
        }
    },
    async created(){
        // send a request to get result, and assign the value to a, b, c here

    },
    async mounted() {
        const data = await this.$axios.$get('/mitra/stock/leader/fetch')
        if(data.status == 'success'){
            this.data = data.data
            console.log(data);
            this.leader = data.data.leader.name
            this.isLoading = false
        }
    },
    methods: {
        formatRp(angka, prefix = 'Rp ') {
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
            return prefix == undefined ? rupiah : rupiah ? "Rp " + rupiah : "";
        },
    },
    computed: {
        dataDesc() {
            return _.orderBy(this.data.stock, 'id', 'desc');
        },
    }
}
</script>