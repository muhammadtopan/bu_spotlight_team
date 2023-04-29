<template>
    <div class="container mt-3">
        <Loader :isLoading="isLoading" />
        <div class="card" id="invoice">
            <div class="card-body">
                <div class="row border mb-3">
                    <div class="col-2 text-center my-auto">
                        <img src="/dist/img/bg-img/user1.png" alt="">
                    </div>
                    <div class="col-3 text-center my-auto">
                        <h4>FAKTUR PENJUALAN</h4>
                    </div>
                    <div class="col-3">
                        <div class="row">
                            <small class="col-12 border">No. Transaksi</small>
                            <small class="col-12 border">Tanggal</small>
                            <small class="col-12 border">Pelanggan</small>
                            <small class="col-12 border">Diskon</small>
                            <small class="col-12 border">Alamat</small>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="row">
                            <small class="col-12 border">TR-{{ data.id }}</small>
                            <small class="col-12 border">{{ parseDateTime(data.created_at) }}</small>
                            <small class="col-12 border">
                                {{ data.is_online=='yes' ? data.user.name : 
                                data.transaction_note ? data.transaction_note.name : 
                                'loading...' }}
                            </small>
                            <small class="col-12 border">{{ data.discount*100 }}%</small>
                            <small class="col-12 border">
                                {{ data.is_online=='yes' ? data.user.user_profile.address : 
                                data.transaction_note ? data.transaction_note.address : 
                                'loading...' }}
                            </small>
                        </div>
                    </div>
                </div>
                <table class="w-100">
                    <thead class="text-center">
                        <tr class="border">
                            <th rowspan="2">No</th>
                            <th rowspan="2">Nama Produk</th>
                            <th rowspan="2">Harga Pasar</th>
                            <th colspan="3">RO</th>
                        </tr>
                        <tr class="border">
                            <th>Jumlah</th>
                            <th>Satuan</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(d,i) in data.transaction_detail" class="border">
                            <td class="text-center">{{ i+1 }}</td>
                            <td>{{ d.product_user.product.name }}</td>
                            <td class="text-end">{{ formatRp(d.product_user.product.price) }}</td>
                            <td class="text-center">{{ d.ro }}</td>
                            <td class="text-center">{{ d.product_user.product.unit }}</td>
                            <td class="text-end">{{ formatRp(d.subtotal) }}</td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="2" class="text-end">JUMLAH PCS :</td>
                            <td colspan="3" class="border"></td>
                            <td class="border">{{ formatRp(data.subtotal) }}</td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-end">DISKON :</td>
                            <td colspan="3" class="border"></td>
                            <td class="text-end border">{{ data.discount*100 }}%</td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-end">TOTAL BAYAR :</td>
                            <td colspan="3" class="border"></td>
                            <td class="border">{{ formatRp(data.total) }}</td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</template>
<script>
import Vuex from "vuex";
import Loader from '../../../components/Loader';
import Toast from '../../../components/Toast';
var _ = require('lodash');
export default {
    components: {
        Toast,
        Loader
    },
    head() {
        return {
            htmlAttrs: {
                lang: 'en',
                'data-theme': 'light'
            },
        }
    },
    data() {
        return {
            isLoading: true,
            data: [],
        }
    },
    async created() {
        console.log("created");
        !localStorage.getItem('print_id') ? this.$router.push('/mitra/sales/list') : this.isLoading = false
        console.log(localStorage.getItem('print_id'));
        const r = await this.$axios.$get('/mitra/sales/print-nota/'+localStorage.getItem('print_id'));
        if(r.status == 'success'){
          this.data = r.data;
        }
        console.log(this.data);
    },
    async mounted() {
        console.log("mounted");
        // !this.$store.state.print_nota.data ? this.$router.push('/mitra/sales/list') : this.isLoading = false
        
        // setTimeout(() => this.print(), 3000);
    },
    methods: {
        parseDateTime(d){
            const monthNames = ["Januari", "Februari", "Maret", "April", "Mei", "Juni",
                "Juli", "Agustus", "September", "Oktober", "November", "December"
            ];
            d = new Date(d);
            
            return d.getDate()+" "+monthNames[d.getMonth()]+" "+d.getFullYear();
        },
        print () {
            const modal = document.getElementById("invoice")
            const cloned = modal.cloneNode(true)
            let section = document.getElementById("print")

            if (!section) {
                section  = document.createElement("div")
                section.id = "print"
                document.body.appendChild(section)
            }

            section.innerHTML = "";
            section.appendChild(cloned);
            window.print();
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
    },
    computed: {
    }
}
</script>
<style>
@media screen {
  #print {
    display: none;
   }
}

@media print {
 body * {
  visibility:hidden;
  }
  #print, #print * {
    visibility:visible;
  }
  #print {
    position:absolute;
    left:0;
    top:0;
  }
}
</style>