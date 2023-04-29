<template>
<div class="page-content-wrapper py-3">
    <Loader :isLoading="isLoading" />
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Distributor List</h6>
        </div>
    </div>
    <!-- Pagination -->
    <div class="shop-pagination pb-3">
        <div class="container">
            <div class="card">
                <div class="card-body p-2">
                    <div class="d-flex align-items-center justify-content-between">
                        <small class="ms-1">Add Distributor</small>
                        <a class="btn btn-creative btn-warning" href="#" data-bs-toggle="modal" data-bs-target="#newDistributorModal">
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
                            <th>Name</th>
                            <th>Periode</th>
                            <th>WA</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(d,i) in dataDesc">
                            <td>{{ d.name }}</td>
                            <td>3m 5d</td>
                            <td>
                                <a v-if="d.user_profile.phone != null" class="btn btn-success btn-sm" :href="'https://api.whatsapp.com/send?phone='+d.user_profile.phone" target="_blank"><i class="bi bi-whatsapp"></i></a>
                            </td>
                            <td>
                                <a v-if="d.status=='request'" @click="viewStatus(i)" href="#" data-bs-toggle="modal" data-bs-target="#requestModal">Request</a>
                                <span v-if="d.status=='inactive'">Inaktif</span>
                                <span v-if="d.status=='active'">Active</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Request Modal -->
    <div class="modal fade" id="requestModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title" id="exampleModalLabel">Activation</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <p><span class="fw-bolder">{{ form_status.id }}</span> {{ new Date(form_status.created_at).toLocaleDateString() }}</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-sm btn-secondary" type="button" data-bs-dismiss="modal">Close</button>
                    <button class="btn btn-sm btn-danger" type="button" @click="submitReject">Reject</button>
                    <button class="btn btn-sm btn-success" type="button" @click="submitActivate">Activate</button>
                </div>
            </div>
        </div>
    </div>

    <!-- New Distributor Modal -->
    <div class="modal fade" id="newDistributorModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title" id="exampleModalLabel">Add Distributor</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <form @submit.prevent="submitAdd">
                            <div class="form-group">
                                <label class="form-label" for="name">Name</label>
                                <input v-model="form_add.name" class="form-control" id="name" type="text" placeholder="Name">
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="domicile">Domicile</label>
                                <input v-model="form_add.domicile" class="form-control" id="domicile" type="text" placeholder="Domicile">
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="phone">Phone</label>
                                <input v-model="form_add.phone" class="form-control" id="phone" type="number" placeholder="08**********">
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
            data: {},
            form_add: {},
            form_status: {},
            isLoading: true,
        }
    },
    async mounted() {
        this.loadData()
    },
    methods: {
        async submitAdd(){
            console.log("add");
            this.isLoading = true
            console.log(this.form_add);
            await this.$axios.post('/admin/distributor/add', this.form_add)
            .then((response) => {
                console.log(response);
                document.querySelector('#newDistributorModal button[data-bs-dismiss="modal"]').click();
                this.loadData()
            })
            .catch((error) => {
                console.log(error);
            });
        },
        async submitActivate(){
            console.log("submitActivate");
            this.isLoading = true
            this.form_status.status = 'active'

            await this.$axios.post('/admin/distributor/update-status', this.form_status)
            .then((response) => {
                console.log(response);
                document.querySelector('#requestModal button[data-bs-dismiss="modal"]').click();
                this.isLoading = false
            })
            .catch((error) => {
                console.log(error);
            });
        },
        async submitReject(){
            console.log("submitReject");
            this.isLoading = true
            this.form_status.status = 'inactive'

            await this.$axios.post('/admin/distributor/update-status', this.form_status)
            .then((response) => {
                console.log(response);
                document.querySelector('#requestModal button[data-bs-dismiss="modal"]').click();
                this.isLoading = false
            })
            .catch((error) => {
                console.log(error);
            });
        },
        viewStatus(i){
            console.log("viewStatus");
            this.form_status = this.dataDesc[i];
            console.log(this.form_status);
        },
        async loadData(){
            const data = await this.$axios.$get('/admin/distributor/fetch')
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