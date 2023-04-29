<template>
<!-- Content -->
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <Toast v-for="t in toast" v-bind:key="t.range" :data="t" />
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Pengeluaran</h6>
        </div>
    </div>
    <div class="container">
        <div class="card bg-dark">
            <div class="card-body">
                <form class="pb-2" action="">
                    <div class="row">
                        <div class="form-group col-6">
                            <!-- <label class="form-label" for="defaultSelect">Bulan</label> -->
                            <select v-model="form_filter.month" @change="filterExpenses" class="form-select" id="defaultSelect" name="defaultSelect" aria-label="Default select example">
                                <option value="1">Januari</option>
                                <option value="2">Februari</option>
                                <option value="3">Maret</option>
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
                            <select v-model="form_filter.year" @change="filterExpenses" class="form-select" id="defaultSelect" name="defaultSelect" aria-label="Default select example">
                                <option v-for="d in get_year" :value="d">{{ d }}</option>
                            </select>
                        </div>
                    </div>
                </form>
                <div class="accordion accordion-style-three" id="accordionStyle3">
                    <!-- Single Accordion -->
                    <div v-for="(d,i) in dataDesc" class="accordion-item">
                        <div class="accordion-header" :id="'expenses'+i">
                            <h6 class="shadow-sm rounded collapsed border" data-bs-toggle="collapse" :data-bs-target="'#accordionexpenses'+i" aria-expanded="false" :aria-controls="'accordionexpenses'+i">
                                {{ d.item }}
                                <svg class="bi bi-arrow-down-short" width="24" height="24" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M8 4a.5.5 0 0 1 .5.5v5.793l2.146-2.147a.5.5 0 0 1 .708.708l-3 3a.5.5 0 0 1-.708 0l-3-3a.5.5 0 1 1 .708-.708L7.5 10.293V4.5A.5.5 0 0 1 8 4z"></path>
                                </svg>
                            </h6>
                        </div>
                        <div class="accordion-collapse collapse" :id="'accordionexpenses'+i" :aria-labelledby="'expenses'+i" data-bs-parent="#accordionStyle3">
                            <div class="accordion-body">
                                <small class="text-warning">{{ getExpenses(d.created_at) }}</small>
                                <p class="mb-0">Kategori : {{ d.category }}</p>
                                <p class="mb-0">Jumlah : {{ formatRp(d.nominal) }}</p>
                                <div class="btn-action-expenses d-flex align-items-center justify-content-end">
                                    <button @click="viewEdit(i)" type="button" class="btn btn-primary btn-sm mx-2" data-bs-toggle="modal" data-bs-target="#editModal">
                                        <i class="bi bi-pencil-square"></i>
                                    </button>
                                    <button class="btn btn-danger btn-sm" @click="form_delete.id=d.id" data-bs-toggle="modal" data-bs-target="#verificationModal">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="pb-3"></div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title" id="exampleModalLabel">Edit Pengeluaran</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <form @submit.prevent="submitEdit">
                            <div class="form-group">
                                <label class="form-label" for="expenses-date">Tanggal Pengeluaran</label>
                                <input v-model="form_edit.pre_created_at" class="form-control" id="expenses-date" name="expenses-date" type="datetime-local" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="item">Item Pengeluaran</label>
                                <input v-model="form_edit.item" class="form-control" id="item" name="item" type="text" placeholder="item pengeluaran" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="category">Kategori</label>
                                <select v-model="form_edit.category" class="form-select" id="category" name="category" required>
                                    <option value="Ongkir">Ongkir</option>
                                    <option value="Konsumsi">Konsumsi</option>
                                    <option value="Kebersihan">Kebersihan</option>
                                    <option value="Operasional">Operasional</option>
                                    <option value="Toolskit">Toolskit</option>
                                    <option value="ATK">ATK</option>
                                    <option value="Reward">Reward</option>
                                    <option value="Branding">Branding</option>
                                    <option value="Pembinaan">Pembinaan</option>
                                    <option value="Lainnya">Lainnya</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="price">Jumlah Pengeluaran</label>
                                <input v-model.number="form_edit.nominal" class="form-control" id="price" min="0" name="price" type="number" placeholder="Jumlah Pengeluaran" required>
                            </div>
                            <button class="btn btn-primary w-100 d-flex align-items-center justify-content-center" type="submit">Submit
                                <svg class="bi bi-arrow-right-short" width="24" height="24" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"></path>
                                </svg>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Verification Modal -->
    <div class="modal fade" id="verificationModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <p>Apakah anda yakin ingin menghapus data pengeluaran ini?</p>
                        <button type="button" @click="submitDelete" class="btn btn-success w-100"> Yakin</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <SuccessModal />
    
    <div class="add-sale-area">
        <NuxtLink class="btn m-1 btn-circle btn-success add-sale" to="/mitra/expenses/add"><i class="bi bi-plus"></i></NuxtLink>
    </div>
</div>
</template>
<script>
import Loader from '../../../components/Loader';
import Toast from '../../../components/Toast';
import SuccessModal from '../../../components/SuccessModal';
var _ = require('lodash');
export default {
    layout: 'layoutMitra',
    components: {
        Toast,
        Loader,
        SuccessModal
    },
    data() {
        return {
            isLoading: true,
            data : [],
            form_filter : {
                month : new Date().getMonth()+1,
                year : new Date().getFullYear()
            },
            form_edit : {},
            form_delete: {
                id: null
            },
            toast: [],
            get_year : [],
        }
    },
    async mounted() {
        const data = await this.$axios.$get('/mitra/expenses/fetch')
        this.get_year = data.data.year;
        this.data = data.data.expenses;
        this.data.forEach(object => {
            // var result = new Date(object.created_at);
            // result.setDate(result.getDate() + 1);
            // var dt = new Date(result).toISOString();
            // object.pre_created_at = dt.substring(0, dt.length-8);
            var dt = new Date(object.created_at).toISOString();
            object.pre_created_at = dt.substring(0, dt.length-8);
        });
        console.log(data.data);
        this.isLoading = false;
    },
    methods: {
        async submitEdit(){
            console.log('submitEdit');
            console.log(this.form_edit);
            const data = await this.$axios.$post('/mitra/expenses/update', this.form_edit);
            if(data.status == 'success'){
                document.querySelector('#editModal button[data-bs-dismiss="modal"]').click();
                new bootstrap.Modal(document.getElementById('successModal'), {}).show();
                this.data = data.data.expenses;
                await this.filterExpenses();
            }
        },
        viewEdit(i){
            console.log('viewEdit');
            this.form_edit = this.dataDesc[i];
            console.log(this.form_edit);
        },
        async submitDelete(){
            const data = await this.$axios.$post('/mitra/expenses/delete', this.form_delete);
            if(data.status == 'success'){
                document.querySelector('#verificationModal button[data-bs-dismiss="modal"]').click();
                new bootstrap.Modal(document.getElementById('successModal'), {}).show();
                this.data = data.data.expenses;
                await this.filterExpenses();
            }
        },
        async filterExpenses(){
            console.log('filterExpenses');
            console.log(this.form_filter);
            await this.$axios.post('/mitra/expenses/filter', this.form_filter)
            .then((r) => {
                console.log(r);
                if(r.data.status == 'success'){
                    this.data = r.data.data;
                    this.data.forEach(object => {
                        // var result = new Date(object.created_at);
                        // result.setDate(result.getDate() + 1);
                        // var dt = new Date(result).toISOString();
                        // object.pre_created_at = dt.substring(0, dt.length-8);
                        var dt = new Date(object.created_at).toISOString();
                        object.pre_created_at = dt.substring(0, dt.length-8);
                    });
                }
            })
            .catch((error) => {
                console.log(error);
                this.isLoading = false;
            });
        },
        getExpenses(data){
            const dt = new Date(data);
            const yyyy = dt.getFullYear();
            let mm = dt.getMonth() + 1; // Months start at 0!
            let dd = dt.getDate();

            if (dd < 10) dd = '0' + dd;
            if (mm < 10) mm = '0' + mm;

            return (dd + '-' + mm + '-' + yyyy);
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
            return _.orderBy(this.data, 'id', 'desc');
        },
    },
}
</script>