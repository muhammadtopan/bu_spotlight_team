<template>
<!-- Content -->
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <Toast v-for="t in toast" v-bind:key="t.range" :data="t" />
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Tambah Penjualan</h6>
        </div>
    </div>
    <div class="container">
        <div class="card">
            <div class="card-body">
                <form @submit.prevent="submitAdd">
                    <div class="form-group">
                        <label class="form-label" for="shopping-date">Tanggal</label>
                        <input v-model="form_add.ordered_at" class="form-control" id="shopping-date" type="date" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="costumer">Pelanggan</label>
                        <input v-model="form_add.name" class="form-control" id="costumer" type="text" placeholder="nama" required>
                        <!-- <input class="form-control" id="costumer" :value="$moment().format('YYYY-MM-DD')" type="text" placeholder="nama" required> -->
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="position">Posisi</label>
                        <select v-model="form_add.position" class="form-select" id="position" name="position" required>
                            <option value="agen">Agen</option>
                            <option value="sub agen">Sub Agen</option>
                            <option value="reseller">Reseller</option>
                            <option value="marketer">Marketer</option>
                            <option value="customer" selected>Costumer</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="address">Alamat</label>
                        <input v-model="form_add.address" class="form-control" id="address" type="text" placeholder="alamat" required>
                    </div>
                    <div class="table-responsive">
                        <table class="table w-100" id="">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Produk</th>
                                    <th>Jumlah</th>
                                </tr>
                            </thead>
                            <tbody >
                                <tr v-for="(d,i) in this.data.stock">
                                    <td>{{ i+1 }}</td>
                                    <td>{{ d.product.name }}</td>
                                    <td>
                                        <input v-model.number="d.ro" @keyup="getTotal()" @input="e=>d.ro=e.target.value" min="0" :max="d.stock" class="form-control" type="number" required>
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="2">Total</td>
                                    <td class="text-end">{{ formatRp(total) }}</td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="jenisTransaksi">Jenis Transaksi</label>
                        <select v-model="form_add.type" class="form-select" id="jenisTransaksi" name="jenisTransaksi" required>
                            <option value="cash" selected>Cash</option>
                            <option value="transfer">Transfer</option>
                        </select>
                    </div>
                    <div class="form-group" v-if="form_add.type=='transfer'">
                        <label class="form-label" for="jenisBank">Jenis Bank</label>
                        <select v-model="form_add.bank" class="form-select" id="jenisBank" name="jenisBank" required>
                            <option value="BRI" selected>BRI</option>
                            <option value="BNI">BNI</option>
                            <option value="BCA">BCA</option>
                            <option value="Mandiri">Mandiri</option>
                        </select>
                    </div>
                    <div class="form-group" v-if="form_add.type=='transfer'">
                        <label class="form-label" for="address">Bank a/n</label>
                        <input v-model="form_add.behalf_of" class="form-control" id="an" type="text" placeholder="Bank a/n" required>
                    </div>
                    <div class="d-flex justify-content-end">
                        <button class="btn btn-creative btn-warning" type="submit">Tambah</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="pb-3"></div>
    <!-- Success Modal -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="d-flex justify-content-center">
                            <lottie-player src="https://assets9.lottiefiles.com/packages/lf20_fbwbq3um.json"  background="transparent"  speed="1"  style="width: 300px; height: 300px;" autoplay></lottie-player>
                        </div>
                        <button @click="btnSuccessModal()" class="btn btn-success w-100"><i class="bi bi-check"></i> Berhasil</button>
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
            data: [],
            total: 0,
            form_add:{
                ordered_at: this.$moment().format('YYYY-MM-DD'),
                position: 'agen',
                type: 'cash',
                bank: 'BRI'
            },
            toast: [],
        }
    },
    computed: {
    },
    async mounted() {
        await this.loadData();
    },
    methods: {
        btnSuccessModal(){
            document.querySelector('#successModal button[data-bs-dismiss="modal"]').click();
            this.$router.push('/mitra/sales/list');
        },
        getTotal(){
            console.log("=== getTotal ===");
            var data = this.data.stock
            var hasil = data.reduce((total, item) => {
                item.ro = item.ro ? item.ro : 0
                return total + item.ro * item.price;
            }, 0);
            this.total = hasil;
        },
        async submitAdd(){
            console.log("=== submitAdd ===");
            var f = this.form_add;
            let cek = false;
            if(f.ordered_at && f.name && f.position && f.address && this.total>0 && f.type){
                if(f.type=='transfer'){
                    if(f.bank && f.behalf_of){
                        cek = true;
                    }
                }else{
                    cek = true;
                }
            }
            console.log(f);
            if(cek){
                this.form_add.data = this.data;
                await this.$axios.post('/mitra/sales/add/submit-add', this.form_add)
                .then((r) => {
                    console.log(r);
                    if(r.data.status == 'success'){
                        new bootstrap.Modal(document.getElementById("successModal"), {}).show();
                        this.toast.push({
                            range: this.toast.length+1,
                            type: 'success',
                            title: 'BERHASIL',
                            msg: 'Transaksi berhasil.'
                        });
                    }else{
                        this.toast.push({
                            range: this.toast.length+1,
                            type: 'danger',
                            title: 'GAGAL',
                            msg: 'Data mungkin belum lengkap...'
                        })
                    }
                    this.isLoading = false;
                })
                .catch((error) => {
                    console.log(error);
                    this.isLoading = false;
                    this.toast.push({
                        range: this.toast.length+1,
                        type: 'danger',
                        title: 'GAGAL',
                        msg: 'Data mungkin belum lengkap. .'
                    })
                });
            }else{
                this.toast.push({
                    range: this.toast.length+1,
                    type: 'danger',
                    title: 'GAGAL',
                    msg: 'Data mungkin belum lengkap.'
                })
            }
            
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
            const data = await this.$axios.$get('/mitra/sales/add/fetch-product');
            if(data.status == 'success'){
                this.data = data.data;
                this.data.stock.forEach(object => {
                    object.ro = 0;
                });
                console.log("loadData");
                console.log(this.data);
                this.isLoading = false
                this.getTotal();
            }
        }
    },
    computed: {
    }
}
</script>