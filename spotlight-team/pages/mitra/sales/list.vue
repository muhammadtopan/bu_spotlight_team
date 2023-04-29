<template>
<!-- Content -->
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <Toast v-for="t in toast" v-bind:key="t.range" :data="t" />
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Penjualan</h6>
        </div>
    </div>
    <div class="container">
        <div class="card bg-dark">
            <div class="card-body">
                <form class="pb-2" action="">
                    <div class="row">
                        <div class="form-group col-6">
                            <!-- <label class="form-label" for="defaultSelect">Bulan</label> -->
                            <select v-model="form_filter.month" @change="getFilterData" class="form-select" id="defaultSelect" name="defaultSelect" aria-label="Default select example">
                                <option value="1">Januari</option>
                                <option value="2">Februari</option>
                                <option value="3" selected>Maret</option>
                                <option value="4">April</option>
                                <option value="5">Mei</option>
                                <option value="6">Juni</option>
                                <option value="7">Juli</option>
                                <option value="8">Agustus</option>
                                <option value="9">September</option>
                                <option value="10">Oktober</option>
                                <option value="11">November</option>
                                <option value="12">Desember</option>
                            </select>
                        </div>
                        <div class="form-group col-6">
                            <!-- <label class="form-label" for="defaultSelect">Tahun</label> -->
                            <select v-model="form_filter.year" @change="getFilterData" class="form-select" id="defaultSelect" name="defaultSelect" aria-label="Default select example">
                                <option v-for="(d,i) in range_year" :value="d">{{ d }}</option>
                            </select>
                        </div>
                    </div>
                </form>
                <div class="colorful-tab">
                    <ul class="nav p-1 mb-3 shadow-sm" id="affanTab3" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="btn btn-primary active" id="semua-tab" data-bs-toggle="tab" data-bs-target="#semua" type="button" role="tab" aria-controls="semua" aria-selected="true">Semua</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="btn btn-primary" id="mitra-tab" data-bs-toggle="tab" data-bs-target="#mitra" type="button" role="tab" aria-controls="mitra" aria-selected="false">Mitra</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="btn btn-primary" id="costumer-tab" data-bs-toggle="tab" data-bs-target="#costumer" type="button" role="tab" aria-controls="costumer" aria-selected="false">Costumer</button>
                        </li>
                    </ul>
                    <div class="tab-content shadow-sm p-3" id="affanTab3Content">
                        <div class="tab-pane fade show active" id="semua" role="tabpanel" aria-labelledby="semua-tab">
                            <div class="accordion accordion-style-four" id="accordionStyle4">   

                                <!-- Single Accordion -->
                                <span v-for="(d,i) in dataDesc">
                                    <div class="accordion-item bg-transparent">
                                        <div class="accordion-header" id="appSale1">
                                            <h6 class="collapsed" data-bs-toggle="collapse" :data-bs-target="'#accordionAppTab1Sale'+i" aria-expanded="false" :aria-controls="'accordionAppTab1Sale'+i">
                                                {{ d.transaction[0].is_online=='yes'?d.user.name:d.transaction[0].transaction_note.name }}
                                                <svg class="bi bi-caret-down" width="20" height="20" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd" d="M3.204 5L8 10.481 12.796 5H3.204zm-.753.659l4.796 5.48a1 1 0 0 0 1.506 0l4.796-5.48c.566-.647.106-1.659-.753-1.659H3.204a1 1 0 0 0-.753 1.659z"></path>
                                                </svg>
                                            </h6>
                                        </div>
                                        <div class="accordion-collapse collapse" :id="'accordionAppTab1Sale'+i" aria-labelledby="appSale1" data-bs-parent="#accordionStyle4">
                                            <div class="accordion-body price-table-one">

                                                <!-- Single Price Table -->
                                                <div v-for="(dt,i) in transactionDesc(d.transaction)" 
                                                    :class="dt.status=='success'?'bg-success':dt.status=='cancel'?'bg-danger':''"
                                                    class="single-price-content p-4 shadow-sm mt-3">
                                                    <div class="price"><span class="text-white mb-2">{{ d.transaction[0].is_online=='yes'?d.user.role:d.transaction[0].transaction_note.position }}</span>
                                                        <h5 class="display-3" style="font-size: calc(1.525rem + 1.3vw);">{{ formatRp(dt.total) }}</h5>
                                                        <span v-if="d.transaction[0].is_online=='yes'" class="badge bg-light text-dark rounded-pill">Online</span>
                                                        <span v-if="d.transaction[0].is_online=='no'" class="badge bg-light text-dark rounded-pill">Offline</span>
                                                    </div>
                                                    <!-- List Product yang dibeli -->
                                                    <div class="pricing-desc">
                                                        <ul class="ps-0">
                                                            <li v-for="(tDetail,iDetail) in dt.transaction_detail">{{ tDetail.ro+' '+tDetail.product_user.product.name }}</li>
                                                        </ul>
                                                    </div>
                                                    <!-- Cetak Nota -->
                                                    <div class="purchase">
                                                        <!-- 1. Tombol terima orderan tampil pertama -->
                                                        <button v-if="dt.status=='pending'" @click="viewOrderAccept(d.user.id,dt.id)" class="btn btn-warning btn-lg btn-creative w-100 mb-2 active" data-bs-toggle="modal" data-bs-target="#accOrderModal">Terima Pesanan</button>
                                                        <!-- 2. Tombol cetak nota dan Tombol Orderan Selesai tampil setelah Pesanan diterima -->
                                                        <button v-if="dt.status=='process'" @click="viewOrderSuccess(d.user.id,dt.id)" class="btn btn-warning btn-lg btn-creative w-100 mb-2 active" data-bs-toggle="modal" data-bs-target="#viewOrderSuccessModal">Orderan Selesai</button>
                                                        <!-- 3. Tombol orderan selesai hilang setelah digunakan, Tombol Cetak Nota tetap ada  -->
                                                        <button v-if="dt.status=='success'" @click="viewOrderPrint(dt.id)" class="btn btn-warning btn-lg btn-creative w-100 active" href="print-nota.php">Cetak Nota</button>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </span>

                            </div>
                        </div>
                        <div class="tab-pane fade" id="mitra" role="tabpanel" aria-labelledby="mitra-tab">
                            <div class="accordion accordion-style-four" id="accordionStyle4">  

                                <!-- Single Accordion -->
                                <span v-for="(d,i) in dataDesc" v-if="d.transaction[0].is_online=='yes'">
                                    <div class="accordion-item bg-transparent">
                                        <div class="accordion-header" id="appSale1">
                                            <h6 class="collapsed" data-bs-toggle="collapse" :data-bs-target="'#accordionAppTab1Sale'+i" aria-expanded="false" :aria-controls="'accordionAppTab1Sale'+i">
                                                {{ d.transaction[0].is_online=='yes'?d.user.name:d.transaction[0].transaction_note.name }}
                                                <svg class="bi bi-caret-down" width="20" height="20" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd" d="M3.204 5L8 10.481 12.796 5H3.204zm-.753.659l4.796 5.48a1 1 0 0 0 1.506 0l4.796-5.48c.566-.647.106-1.659-.753-1.659H3.204a1 1 0 0 0-.753 1.659z"></path>
                                                </svg>
                                            </h6>
                                        </div>
                                        <div class="accordion-collapse collapse" :id="'accordionAppTab1Sale'+i" aria-labelledby="appSale1" data-bs-parent="#accordionStyle4">
                                            <div class="accordion-body price-table-one">

                                                <!-- Single Price Table -->
                                                <div v-for="(dt,i) in transactionDesc(d.transaction)" 
                                                    :class="dt.status=='success'?'bg-success':dt.status=='cancel'?'bg-danger':''"
                                                    class="single-price-content p-4 shadow-sm mt-3">
                                                    <div class="price"><span class="text-white mb-2">{{ d.transaction[0].is_online=='yes'?d.user.role:d.transaction[0].transaction_note.position }}</span>
                                                        <h5 class="display-3" style="font-size: calc(1.525rem + 1.3vw);">{{ formatRp(dt.total) }}</h5>
                                                        <span v-if="d.transaction[0].is_online=='yes'" class="badge bg-light text-dark rounded-pill">Online</span>
                                                        <span v-if="d.transaction[0].is_online=='no'" class="badge bg-light text-dark rounded-pill">Offline</span>
                                                    </div>
                                                    <!-- List Product yang dibeli -->
                                                    <div class="pricing-desc">
                                                        <ul class="ps-0">
                                                            <li v-for="(tDetail,iDetail) in dt.transaction_detail">{{ tDetail.ro+' '+tDetail.product_user.product.name }}</li>
                                                        </ul>
                                                    </div>
                                                    <!-- Cetak Nota -->
                                                    <div class="purchase">
                                                        <!-- 1. Tombol terima orderan tampil pertama -->
                                                        <button v-if="dt.status=='pending'" @click="viewOrderAccept(d.user.id,dt.id)" class="btn btn-warning btn-lg btn-creative w-100 mb-2 active" data-bs-toggle="modal" data-bs-target="#accOrderModal">Terima Pesanan</button>
                                                        <!-- 2. Tombol cetak nota dan Tombol Orderan Selesai tampil setelah Pesanan diterima -->
                                                        <button v-if="dt.status=='process'" @click="viewOrderSuccess(dt.id)" class="btn btn-warning btn-lg btn-creative w-100 mb-2 active" data-bs-toggle="modal" data-bs-target="#viewOrderSuccessModal">Orderan Selesai</button>
                                                        <!-- 3. Tombol orderan selesai hilang setelah digunakan, Tombol Cetak Nota tetap ada  -->
                                                        <button v-if="dt.status=='success'" @click="viewOrderPrint(dt.id)" class="btn btn-warning btn-lg btn-creative w-100 active" href="print-nota.php">Cetak Nota</button>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </span>

                            </div>
                        </div>
                        <div class="tab-pane fade" id="costumer" role="tabpanel" aria-labelledby="costumer-tab">
                            <div class="accordion accordion-style-four" id="accordionStyle4">
                                
                                <!-- Single Accordion -->
                                <span v-for="(d,i) in dataDesc" v-if="d.transaction[0].is_online=='no'">
                                    <div class="accordion-item bg-transparent">
                                        <div class="accordion-header" id="appSale1">
                                            <h6 class="collapsed" data-bs-toggle="collapse" :data-bs-target="'#accordionAppTab1Sale'+i" aria-expanded="false" :aria-controls="'accordionAppTab1Sale'+i">
                                                {{ d.transaction[0].is_online=='yes'?d.user.name:d.transaction[0].transaction_note.name }}
                                                <svg class="bi bi-caret-down" width="20" height="20" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd" d="M3.204 5L8 10.481 12.796 5H3.204zm-.753.659l4.796 5.48a1 1 0 0 0 1.506 0l4.796-5.48c.566-.647.106-1.659-.753-1.659H3.204a1 1 0 0 0-.753 1.659z"></path>
                                                </svg>
                                            </h6>
                                        </div>
                                        <div class="accordion-collapse collapse" :id="'accordionAppTab1Sale'+i" aria-labelledby="appSale1" data-bs-parent="#accordionStyle4">
                                            <div class="accordion-body price-table-one">

                                                <!-- Single Price Table -->
                                                <div v-for="(dt,i) in transactionDesc(d.transaction)" 
                                                    :class="dt.status=='success'?'bg-success':dt.status=='cancel'?'bg-danger':''"
                                                    class="single-price-content p-4 shadow-sm mt-3">
                                                    <div class="price"><span class="text-white mb-2">{{ d.transaction[0].is_online=='yes'?d.user.role:d.transaction[0].transaction_note.position }}</span>
                                                        <h5 class="display-3" style="font-size: calc(1.525rem + 1.3vw);">{{ formatRp(dt.total) }}</h5>
                                                        <span v-if="d.transaction[0].is_online=='yes'" class="badge bg-light text-dark rounded-pill">Online</span>
                                                        <span v-if="d.transaction[0].is_online=='no'" class="badge bg-light text-dark rounded-pill">Offline</span>
                                                    </div>
                                                    <!-- List Product yang dibeli -->
                                                    <div class="pricing-desc">
                                                        <ul class="ps-0">
                                                            <li v-for="(tDetail,iDetail) in dt.transaction_detail">{{ tDetail.ro+' '+tDetail.product_user.product.name }}</li>
                                                        </ul>
                                                    </div>
                                                    <!-- Cetak Nota -->
                                                    <div class="purchase">
                                                        <!-- 3. Tombol orderan selesai hilang setelah digunakan, Tombol Cetak Nota tetap ada  -->
                                                        <button v-if="dt.status=='success'" @click="viewOrderPrint(dt.id)" class="btn btn-warning btn-lg btn-creative w-100 active" href="print-nota.php">Cetak Nota</button>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </span>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="pb-3"></div>

    <div class="add-sale-area">
        <NuxtLink to="/mitra/sales/add" class="btn m-1 btn-circle btn-success add-sale"><i class="bi bi-plus"></i></NuxtLink>
    </div>

    <!-- Acc Order Modal -->
    <div class="modal fade" id="accOrderModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h4>Terima Orderan</h4>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="d-flex justify-content-between">
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#warningModal">Tolak</button>
                            <button type="button" @click="submitOrderAccept" class="btn btn-success" data-bs-dismiss="modal">Terima</button>
                        </div>
                    </div>
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
                        <div class="d-flex justify-content-center">
                            <lottie-player src="https://assets9.lottiefiles.com/packages/lf20_fbwbq3um.json" background="transparent" speed="1" style="width: 300px; height: 300px;" autoplay></lottie-player>
                        </div>
                        <button type="button" data-bs-dismiss="modal" class="btn btn-success w-100"><i class="bi bi-check"></i> Berhasil</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Warning Modal -->
    <div class="modal fade" id="warningModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="d-flex justify-content-center">
                            <p>Pesanan akan dibatalkan jika ditolak. Apakah Anda yakin?</p>
                        </div>
                        <button type="button" @click="submitOrderCancel" data-bs-dismiss="modal" class="btn btn-danger w-100"><i class="bi bi-check"></i> Yakin</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- View Order Success Modal -->
    <div class="modal fade" id="viewOrderSuccessModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h4>Apakah Orderan Ini Sudah Selesai ?</h4>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#warningModal">Belum</button>
                            <button type="button" @click="submitOrderSuccess" class="btn btn-success" data-bs-dismiss="modal">Sudah</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- completed Modal -->
    <div class="modal fade" id="complitedModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="d-flex justify-content-center">
                            <p>Kerja bagus! Semoga omset bulan ini naik. :)</p>
                        </div>
                        <button type="button" data-bs-dismiss="modal" class="btn btn-success w-100"><i class="bi bi-check"></i> Oke</button>
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
            form_filter: {
                month: new Date().getMonth()+1,
                year: new Date().getFullYear()
            },
            detail_order_accept: {},
            toast: [],
            range_year:[]
        }
    },
    async mounted() {
        console.log("mounted");
        const data = await this.$axios.$get('/mitra/sales/fetch')
        if(data.status == 'success'){
            this.data = data.data
            this.isLoading = false
            if(data.year_start && data.year_end){
                for (let index = data.year_start; index <= data.year_end; index++) {
                    this.range_year.push(index);
                }
            }
            console.log(data);
        }
    },
    methods: {
        viewOrderAccept(id_u, id_t){
            console.log('viewOrderAccept: '+id_u+' '+id_t);
            console.log(this.data);
            let detail_order_accept = {}
            _.filter(this.data, (o, key) => {
                console.log(o);
                if(o.user!=null && o.user.id==parseInt(id_u)){
                    _.filter(this.data[key].transaction, (o_trans) => {
                        if(o_trans.id==id_t){
                            detail_order_accept = o_trans;
                        }
                    });
                }
            });
            this.detail_order_accept = detail_order_accept
            console.log(this.data);
            console.log(detail_order_accept);
        },
        async submitOrderAccept(){
            console.log('submitOrderAccept');
            this.isLoading = true;
            await this.$axios.post('/mitra/sales/submit-accept', this.detail_order_accept)
            .then((r) => {
                console.log(r);
                if(r.data.status == 'success'){
                    new bootstrap.Modal(document.getElementById("successModal"), {}).show();
                    this.detail_order_accept.status = 'process';
                }
                this.isLoading = false;
            })
            .catch((error) => {
                console.log(error);
                this.isLoading = false;
            });
        },
        async submitOrderCancel(){
            console.log('submitOrderCancel');
            this.isLoading = true;
            await this.$axios.post('/mitra/sales/submit-cancel', this.detail_order_accept)
            .then((r) => {
                console.log(r);
                if(r.data.status == 'success'){
                    this.detail_order_accept.status = 'cancel';
                    // _.find(this.data, function(obj) {
                    //     if(obj.id == detail_order_accept.id){
                    //         obj.status = 'cancel'
                    //     }
                    // });
                }
                console.log(this.dataDesc);
                this.isLoading = false;
            })
            .catch((error) => {
                console.log(error);
                this.isLoading = false;
            });
        },
        viewOrderSuccess(id_u, id_t){
            console.log('viewOrderSuccess: '+id_u+' '+id_t);
            this.viewOrderAccept(id_u, id_t);
        },
        async submitOrderSuccess(){
            console.log('submitOrderSuccess');
            this.isLoading = true;
            await this.$axios.post('/mitra/sales/submit-order-success', this.detail_order_accept)
            .then((r) => {
                console.log(r.data);
                if(r.data.status == 'success'){
                    new bootstrap.Modal(document.getElementById("complitedModal"), {}).show();
                    this.detail_order_accept.status = 'success';
                }
                this.isLoading = false;
            })
            .catch((error) => {
                console.log(error);
                this.isLoading = false;
            });
        },
        viewOrderPrint(id){
            this.isLoading = true;
            console.log('viewOrderPrint: '+id);
            this.$store.commit('print_nota/setPrintId', id);
            localStorage.setItem('print_id', this.$store.state.print_nota.print_id);
            console.log(localStorage.getItem('print_id'));
            let route = this.$router.resolve({ path: "/mitra/sales/print-nota" });
            window.open(route.href);
            
            // this.$store.dispatch('print_nota/fetch').then((result)=>{
            //     if(result){
            //         // let route = this.$router.push('/mitra/sales/print-nota')
            //         // localStorage.setItem('print_id', );
            //         // let route = this.$router.resolve({ path: "/mitra/sales/print-nota" });
            //         // window.open(route.href);
            //     }
            // });
            this.isLoading = false;
        },
        async getFilterData(){
            console.log(this.form_filter);
            await this.$axios.post('/mitra/sales/list/filter', this.form_filter)
                .then((r) => {
                    console.log(r);
                    if(r.data.status == 'success'){
                        this.data = r.data.data;
                    }else{
                    }
                })
                .catch((error) => {
                    console.log(error);
                });
        },
        transactionDesc(d){
            // console.log("transactionDesc");
            let transaction_desc = _.orderBy(d, 'id', 'desc');
            // console.log(transaction_desc);
            return transaction_desc;
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
        dataDesc() {
            console.log("dataDesc");
            return this.data;
            // let data_desc = _.orderBy(this.filterData, 'id', 'desc');
            // console.log(data_desc);
            // return data_desc;
        },
        // filterData(){
        //     return _.filter(
        //         this.data, (o) => {
        //             let filter_data = new Date(o.created_at).getFullYear() == this.form_filter.year && new Date(o.created_at).getMonth()+1 == this.form_filter.month;
        //             console.log("filterData");
        //             console.log(filter_data);
        //             return filter_data;
        //         }
        //     );
        // },
    }
}
</script>