<template>
<!-- Content -->
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <Toast v-for="t in toast" v-bind:key="t.range" :data="t" />
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Tambah Stok</h6>
        </div>
    </div>
    <div class="container">
        <div class="card">
            <div class="card-body table-responsive">
                <form @submit.prevent="submitBuy">
                <table class="table w-100" id=" ">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Produk</th>
                            <th>Harga</th>
                            <th>Stok Leader</th>
                            <th>RO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(d,i) in dataDesc">
                            <td>{{ ++i }}</td>
                            <td>{{ d.product.name }}</td>
                            <td>{{ formatRp(d.price) }}</td>
                            <td>{{ d.stock }}</td>
                            <td>
                                <input v-model.number="d.ro" @keyup="getTotal()" @input="e=>d.ro=e.target.value" min="0" :max="d.stock" class="form-control" type="number" required>
                                <!-- <input v-model.number="d.ro" @input="e=>d.ro=e.target.value" class="form-control" type="number"> -->
                                <!-- <input v-model.number="d.ro" @keyup="getTotal()" @input="dataIndex=i" class="form-control" type="number"> -->
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="4">Total</td>
                            <td class="text-end">{{ formatRp(total) }}</td>
                        </tr>
                        <tr>
                            <td colspan="3">Setelah Diskon</td>
                            <td class="text-end">
                                <span class="text-success">
                                    &nbsp;&nbsp;&nbsp;
                                    {{ discount*100 }}%
                                </span>
                            </td>
                            <td class="text-end">{{ formatRp(after_discount) }}</td>
                        </tr>
                        <tr>
                            <td colspan="3">Minimal belanja untuk diskon </td>
                            <td class="text-end">{{ disc.discount_up*100 }}%</td>
                            <td class="text-end">{{ formatRp(disc.price_discount_up) }}</td>
                        </tr>
                        <tr>
                            <td colspan="4">Selisih</td>
                            <td class="text-end">{{ formatRp(difference) }}</td>
                        </tr>
                    </tfoot>
                </table>
                <button class="btn btn-creative btn-warning" data-bs-toggle="modal" data-bs-target="#bootstrapBasicModal" type="button">Pilih Transaksi</button>
               
                <!-- Bootstrap Basic Modal -->
                <div class="modal fade" id="bootstrapBasicModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h6 class="modal-title" id="exampleModalLabel">Transaksi</h6>
                                <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="container">
                                    <div class="form-group">
                                        <label class="form-label" for="jenisTransaksi">Jenis Transaksi</label>
                                        <select v-model="form_add.type" class="form-select" id="jenisTransaksi" name="jenisTransaksi" required>
                                            <option value="transfer" selected>Transfer</option>
                                            <option value="cash">Cash</option>
                                        </select>
                                    </div>
                                    <div v-if="form_add.type=='transfer'" class="form-group">
                                        <label class="form-label" for="jenisBank">Jenis Bank</label>
                                        <select v-model="form_add.bank" class="form-select" id="jenisBank" name="jenisBank" required>
                                            <option v-for="(d,i) in data.bank" :value="d.id" selected>{{ d.bank }}</option>
                                        </select> 
                                    </div>
                                    <!-- <button class="btn btn-creative btn-warning" data-bs-toggle="modal" data-bs-target="#successModal" type="button">pesan</button> -->
                                    <button class="btn btn-creative btn-warning" type="submit">Pesan</button>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
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
                        <button @click="redirectPage" data-bs-dismiss="modal" class="btn btn-success w-100" type="button"><i class="bi bi-check"></i> Berhasil</button>
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
            total : 0,
            discount: 0.15,
            disc: {
                index: 0,
                discount_up: 0.15,
                price_discount_up: 0,
            },
            min_buy: 0,
            after_discount: 0,
            difference: 0,
            form_add: {
                type: 'transfer',
                bank: '2'
            },
            toast: [],
        }
    },
    computed: {
        dataDesc: {
            get () {
                console.log("get");
                return _.orderBy(this.data.stock, 'id', 'desc');
            },
            set (val) {
                console.log("set "+val);
                return val;
            }
            // this.data.stock = this.data.stock.map(object => {
            //     return {...object, ro:0};
            // });
        },
        discAsc() {
            return _.orderBy(this.data.disc, 'discount_up', 'asc')
        }
    },
    async mounted() {
        await this.loadData();
        console.log(this.$auth.user);
    },
    methods: {
        redirectPage(){
            this.$router.push('/mitra/stock');
        },
        async submitBuy(){
            console.log("submitBuy");
            this.isLoading = true;
            this.form_add.data = this.data
            console.log(this.form_add);
            if(this.total>0){
                await this.$axios.post('/mitra/stock/add', this.form_add)
                .then((r) => {
                    console.log(r);
                    if(r.data.status == 'success'){
                        new bootstrap.Modal(document.getElementById("successModal"), {}).show();
                        this.loadData()
                        this.toast.push({
                            range: this.toast.length+1,
                            type: 'success',
                            title: 'BERHASIL',
                            msg: 'Transaksi berhasil.'
                        })
                    }else{
                        this.toast.push({
                            range: this.toast.length+1,
                            type: 'danger',
                            title: 'GAGAL',
                            msg: 'Data mungkin belum lengkap.'
                        })
                    }
                    document.querySelector('#bootstrapBasicModal button[data-bs-dismiss="modal"]').click();
                    this.isLoading = false;
                })
                .catch((error) => {
                    console.log(error);
                    this.isLoading = false;
                    this.toast.push({
                        range: this.toast.length+1,
                        type: 'danger',
                        title: 'GAGAL',
                        msg: 'Data mungkin belum lengkap..'
                    })
                });
            }else{
                this.isLoading = false;
                this.toast.push({
                    range: this.toast.length+1,
                    type: 'danger',
                    title: 'GAGAL',
                    msg: 'Min total transaksi tidak boleh 0'
                })
            }
            
        },
        getTotal(){
            console.log("=== getTotal ===");
            var data = this.dataDesc
            var hasil = data.reduce((total, item) => {
                item.ro = item.ro ? item.ro : 0
                return total + item.ro * item.price;
            }, 0);
            console.log(this.discAsc);
            let should_skip = false;
            this.discAsc.forEach((val, index, arr) => {
                // console.log(hasil+' < '+val.price_discount_up+' i='+index);
                if (should_skip) return;
                if(hasil < val.price_discount_up){
                    this.disc.index = index;
                    this.disc.discount_up = val.discount_up;
                    this.disc.price_discount_up = val.price_discount_up;
                    should_skip = true;
                }
            });
            console.log(this.discAsc);

            this.discount = this.discAsc[this.disc.index-1].discount_up;

            this.after_discount = hasil - (this.discount * hasil);
            
            console.log("hasil "+hasil);
            console.log("discount "+this.discount);
            console.log("discount_up "+this.disc.discount_up);
            this.difference = hasil < this.disc.price_discount_up ? this.disc.price_discount_up - hasil : 0
            // if(this.difference == 0){
            //     this.after_discount = hasil - (this.discount_up * hasil)
            // } 
            this.total = hasil
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
            const data = await this.$axios.$get('/mitra/stock/leader/fetch')
            if(data.status == 'success'){
                this.data = data.data
                this.data.stock.forEach(object => {
                    object.ro = 0;
                });
                // this.discount = data.data.disc.discount
                // this.discount_up = data.data.disc.discount_up
                // this.min_buy = data.data.disc.price_discount_up
                // this.difference = this.min_buy
                console.log("loadData");
                console.log(this.data);
                this.isLoading = false
            }
            this.getTotal()
        }
    },
    
}
</script>