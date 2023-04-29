<template>
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Stok Toko</h6>
        </div>
    </div>
    <div class="shop-pagination pb-2">
        <div class="container">
            <div class="card">
                <div class="card-body p-1">
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
    <div class="shop-pagination pb-2">
        <div class="container">
            <div class="card">
                <div class="card-body p-1">
                    <div class="d-flex align-items-center justify-content-between">
                        <small class="ms-1">Stok Akhir Bulan</small>
                        <NuxtLink class="btn btn-creative btn-warning" to="/mitra/stock/last">
                            <i class="bi bi-plus-circle"></i>
                        </NuxtLink>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="shop-pagination pb-2">
        <div class="container">
            <div class="card">
                <div class="card-body p-1">
                    <div class="d-flex align-items-center justify-content-between">
                        <small class="ms-1">Stok Leader</small>
                        <NuxtLink class="btn btn-creative btn-warning" to="/mitra/stock/leader">
                            <i class="bi bi-eye"></i>
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
                            <td>{{ i+1 }}</td>
                            <td>{{ d.product.name }}</td>
                            <td>{{ formatRp(d.price) }}</td>
                            <td>{{ d.stock }}</td>
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
        }
    },
    async mounted() {
        const data = await this.$axios.$get('/mitra/stock/fetch')
        if(data.status == 'success'){
            this.data = data.data
            this.isLoading = false
            console.log(this.data);
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
            return _.orderBy(this.data, 'id', 'desc');
        },
    }
}
</script>