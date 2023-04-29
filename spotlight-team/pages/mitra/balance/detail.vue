<template>
<!-- Content -->
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <Toast v-for="t in toast" v-bind:key="t.range" :data="t" />
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>{{ bank }}</h6>
        </div>
    </div>
    <div class="shop-pagination pb-2">
        <div class="container">
            <div class="card">
                <div class="card-body p-1">
                    <div class="d-flex align-items-center justify-content-between">
                        <small class="ms-1">Saldo</small>
                        <h3 class="my-auto text-light">
                            Rp {{ formatWithoutRp(data.sum) }},-
                        </h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="card">
            <div class="card-body table-responsive">
                <table class="table w-100" id="">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Jenis</th>
                            <th>Tanggal</th>
                            <th>Jumlah</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(d,i) in data.mutation" :style="d.title=='Debit'?'color:#2ecc4a':'color:orange'">
                            <td>{{ i }}</td>
                            <td>{{ d.title }}</td>
                            <td>{{ parseDateTime(d.created_at) }}</td>
                            <td>{{ formatWithoutRp(d.amount) }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="pb-3"></div>
    <div class="add-sale-area">
        <NuxtLink class="btn m-1 btn-circle btn-success add-sale" to="/mitra/balance/add"><i class="bi bi-plus"></i></NuxtLink>
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
            toast: [],
            data: [],
            bank: '',
        }
    },
    async mounted() {
        console.log("mounted");
        this.bank = localStorage.getItem('bank');
        const data = await this.$axios.$post('/mitra/balance/detail', {bank:this.bank})
        if(data.status == 'success'){
            this.data = data.data
            this.isLoading = false
            console.log(this.data);
        }
    },
    methods: {
        parseDateTime(d){
            const monthNames = ["Januari", "Februari", "Maret", "April", "Mei", "Juni",
                "Juli", "Agustus", "September", "Oktober", "November", "December"
            ];
            d = new Date(d);
            
            return d.getDate()+" "+monthNames[d.getMonth()]+" "+d.getFullYear();
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