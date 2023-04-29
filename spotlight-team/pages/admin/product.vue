<template>
<div class="page-content-wrapper py-3">
    <Loader :isLoading="isLoading" />
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Product List</h6>
        </div>
    </div>
    <!-- Pagination -->
    <div class="shop-pagination pb-3">
        <div class="container">
            <div class="card">
                <div class="card-body p-2">
                    <div class="d-flex align-items-center justify-content-between">
                        <small class="ms-1">Add Product</small>
                        <a class="btn btn-creative btn-warning" href="#" data-bs-toggle="modal" data-bs-target="#productModal">
                            <i class="bi bi-plus-circle"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="card">
            <div class="card-body table-responsive">
                <table class="table w-100" id="dataTable">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>unit</th>
                            <th>Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody >
                        <tr v-for="(d, i) in dataDesc">
                            <td>{{ d.name }}</td>
                            <td>{{ d.unit }}</td>
                            <td v-html="formatRp(d.price)"></td>
                            <td>
                                <div class="d-flex align-items-center justify-content-between">
                                    <button @click="viewEdit(i)" type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#productEditModal">
                                        <i class="bi bi-pencil-square"></i>
                                    </button>
                                    <button @click="viewDelete(i)" type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#productDeleteModal">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Product Modal -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title" id="exampleModalLabel">Add Product</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <form @submit.prevent="submitAdd">
                            <div class="form-group">
                                <label class="form-label" for="product">Product</label>
                                <input v-model="form_add.name" class="form-control" id="product" name="product" type="text" placeholder="Product" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="unit">Unit</label>
                                <input v-model="form_add.unit" class="form-control" id="unit" name="unit" type="text" placeholder="Unit" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="price">Price</label>
                                <input v-model="form_add.price" class="form-control" id="price" name="price" type="text" placeholder="Price" required>
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

    <!-- Product Modal -->
    <div class="modal fade" id="productEditModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title" id="exampleModalLabel">Edit Product</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <form @submit.prevent="submitEdit">
                            <div class="form-group">
                                <label class="form-label" for="product">Product</label>
                                <input v-model="form_edit.name" class="form-control" id="product" name="product" type="text" placeholder="Product" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="unit">Unit</label>
                                <input v-model="form_edit.unit" class="form-control" id="unit" name="unit" type="text" placeholder="Unit" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="price">Price</label>
                                <input v-model="form_edit.price" class="form-control" id="price" name="price" type="text" placeholder="Price" required>
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

    <!-- Delete Modal -->
    <div class="modal fade" id="productDeleteModal" tabindex="-1" aria-labelledby="logoutModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title">Are You Sure?</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <!-- <div class="modal-body">
                    <div class="container">
                        <p class="fw-bolder">Are You Sure?</p>
                    </div>
                </div> -->
                <div class="modal-footer">
                    <button class="btn btn-sm btn-secondary" type="button" data-bs-dismiss="modal">No</button>
                    <button class="btn btn-sm btn-success" type="button" @click="submitDelete()">Yes</button>
                </div>
            </div>
        </div>
    </div>

</div>
</template>

<script>
import Loader from '../../components/Loader';
var _ = require('lodash');
export default {
    layout: 'layoutAdmin',
    components: {
        Loader
    },
    data() {
        return {
            isLoading: true,
            data: [],
            form_add:{},
            form_edit:{},
            form_delete:{},
        }
    },
    mounted() {
        this.loadData()
    },
    methods: {
        async submitDelete(){
            console.log("submitDelete");
            console.log();
            this.isLoading = true
            console.log(this.form_edit);
            await this.$axios.post('/admin/product/delete', this.form_delete)
            .then((response) => {
                console.log(response);
                document.querySelector('#productDeleteModal button[data-bs-dismiss="modal"]').click();
                this.loadData()
            })
            .catch((error) => {
                console.log(error);
            });
        },
        viewDelete(i){
            this.form_delete = this.dataDesc[i]
            console.log(this.form_delete)
        },
        async submitEdit(){
            this.isLoading = true
            console.log("submitEdit");
            console.log(this.form_edit);
            await this.$axios.post('/admin/product/edit', this.form_edit)
            .then((response) => {
                console.log(response);
                document.querySelector('#productEditModal button[data-bs-dismiss="modal"]').click();
                this.loadData()
            })
            .catch((error) => {
                console.log(error);
            });
        },
        viewEdit(i){
            this.form_edit = this.dataDesc[i]
            console.log(this.form_edit)
        },
        async submitAdd(){
            this.isLoading = true
            console.log("add");
            console.log(this.form_add);
            await this.$axios.post('/admin/product/add', this.form_add)
            .then((response) => {
                console.log(response);
                document.querySelector('#productModal button[data-bs-dismiss="modal"]').click();
                this.loadData();
            })
            .catch((error) => {
                console.log(error);
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
            const data = await this.$axios.$get('/admin/product/fetch')
            if(data.status == 'success'){
                this.data = data.data
                this.isLoading = false
                console.log(this.data);
            }
        }
    },
    computed: {
        dataDesc() {
            return _.orderBy(this.data, 'id', 'desc');
        },
    }
}
</script>