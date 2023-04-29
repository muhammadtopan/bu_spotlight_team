<template>
<!-- Content -->
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Stok Akhir Bulan</h6>
        </div>
    </div>
    <div class="container">
        <div class="card">
            <div class="card-body table-responsive">
                <table class="table w-100" id=" ">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Produk</th>
                            <th>Stok</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(d,i) in dataDesc">
                            <td>{{ ++i }}</td>
                            <td>{{ d.product.name }}</td>
                            <td>
                                <input v-model="d.edit_stock" :readonly="data.verification==false" class="form-control" type="number">
                            </td>
                        </tr>
                    </tbody>
                </table>
                <button v-if="data.verification && data.stock.length!=0" class="btn btn-creative btn-warning" data-bs-toggle="modal" data-bs-target="#confirmationModal" type="button">Input</button>
                <h6 v-if="data.verification==false" class="text-center">Belum waktu input stok akhir bulan.</h6>
            </div>
        </div>
    </div>
    <div class="pb-3"></div>

    <!-- Konfimasi Input Modal -->
    <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="logoutModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title">Are You Sure?</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-sm btn-secondary" type="button" data-bs-dismiss="modal">No</button>
                    <button class="btn btn-sm btn-success" type="button" @click="submitAdd()">Yes</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Success Modal -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <lottie-player src="https://assets9.lottiefiles.com/packages/lf20_fbwbq3um.json"  background="transparent"  speed="1"  style="width: 300px; height: 300px;"    autoplay></lottie-player>
                        <a href="stock.php" class="btn btn-success w-100"><i class="bi bi-check"></i> Oke</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
        this.isLoading = true
        await this.loadData();
    },
    methods: {
        async submitAdd(){
            this.isLoading = true
            console.log("submitAdd");
            console.log(this.data.stock);
            document.querySelector('#confirmationModal button[data-bs-dismiss="modal"]').click();
            await this.$axios.post('/mitra/stock/last-month/add', this.data.stock)
            .then((response) => {
                console.log(response);
                this.loadData();
                this.isLoading = false
            })
            .catch((error) => {
                console.log(error);
                this.isLoading = false
            });
        },
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
        async loadData(){
            console.log('loadData');
            const data = await this.$axios.$get('/mitra/stock/last-month/fetch')
            if(data.status == 'success'){
                this.data = data.data
                this.data.stock.forEach(object => {
                    object.edit_stock = object.stock;
                });
                this.isLoading = false
                console.log(this.data);
            }
        }
    },
    computed: {
        dataDesc() {
            return _.orderBy(this.data.stock, 'id', 'desc');
        },
    }
}
</script>