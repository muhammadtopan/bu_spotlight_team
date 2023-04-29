<template>
<div class="page-content-wrapper py-3">
    <Loader :isLoading="isLoading" />
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Users List</h6>
        </div>
    </div>
    <!-- Pagination -->
    <div class="shop-pagination pb-3">
        <div class="container">
            <div class="card">
                <div class="card-body p-2">
                    <div class="row bor">
                        <div class="col mx-2 border rounded"> 
                            <div class="d-flex align-items-center text-light justify-content-between">
                                <div>Total</div>
                                <div>{{ data.total }}</div>
                            </div>
                        </div>
                        <div class="col mx-2 border rounded"> 
                            <div class="d-flex align-items-center text-light justify-content-between">
                                <div>Request</div>
                                <div>{{ data.request }}</div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col mx-2 border rounded"> 
                            <div class="d-flex align-items-center text-light justify-content-between">
                                <div>Active</div>
                                <div>{{ data.active }}</div>
                            </div>
                        </div>
                        <div class="col mx-2 border rounded"> 
                            <div class="d-flex align-items-center text-light justify-content-between">
                                <div>Inactive</div>
                                <div>{{ data.inactive }}</div>
                            </div>
                        </div>
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
                            <th>Position</th>
                            <th>Periode</th>
                            <th>WA</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(d,i) in dataDesc">
                            <td>
                                <a @click="viewDetail(i)" href="#" class="position-relative" data-bs-toggle="modal" data-bs-target="#profileUserModal">
                                    {{ d.name }}
                                    <span v-if="d.view_admin==0" class="position-absolute top-0 start-100 badge rounded-circle bg-danger p-1">
                                        <span class="visually-hidden">unread messages</span>
                                    </span>
                                </a> 
                            </td>
                            <td>{{ d.role }}</td>
                            <td>-</td>
                            <td>
                                <a v-if="d.user_profile.phone != null" class="btn btn-success btn-sm" :href="'https://api.whatsapp.com/send?phone='+d.user_profile.phone" target="_blank"><i class="bi bi-whatsapp"></i></a>
                            </td>
                            <td>
                                <a v-if="(d.status=='request')" @click="viewStatus(i)" href="#" data-bs-toggle="modal" data-bs-target="#bootstrapBasicModal">Request</a>
                                <span class="text-danger" v-if="d.status=='inactive'">Inaktif</span>
                                <span class="text-success" v-if="d.status=='active'">Active</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap Basic Modal -->
    <div class="modal fade" id="bootstrapBasicModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title" id="exampleModalLabel">Activation</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <p><span class="fw-bolder">{{ detail.id }}</span> {{ $moment(detail.verify_at).format('DD/MM/YYYY') }}</p>
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

    <!-- Profile Modal -->
    <div class="modal fade" id="profileUserModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title" id="exampleModalLabel">Profile Users</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <!-- User Information-->
                        <div class="card user-info-card mb-3">
                            <div class="card-body d-flex align-items-center">
                                <div class="user-profile me-3">
                                    <img :src="detail.user_profile.img_profile? `${$config.baseImgUrl}`+detail.user_profile.img_profile:`${$config.baseImgUrl}/images/demo/500x500.jpg`" alt="">
                                </div>
                                <div class="user-info">
                                    <div class="d-flex align-items-center">
                                        <h5 class="mb-1">{{ detail.name }}</h5>
                                        <span class="badge ms-2 rounded-pill" :class="detail.status=='request'?'bg-warning':
                                                                                      detail.status=='inactive'?'bg-danger':
                                                                                      detail.status=='active'?'bg-success':''">{{ detail.status }}</span>
                                    </div>
                                    <p class="mb-0">{{ detail.role }}</p>
                                </div>
                            </div>
                        </div>
                        <!-- User Meta Data-->
                        <div class="card user-data-card">
                            <div class="card-body">
                                <form action="#">
                                    <div class="form-group mb-3">
                                        <label class="form-label">NIM</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.user_id" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Name</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.name" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Domicile</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.domicile" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Position</label>
                                        <input class="form-control" type="text" value="-" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Phone</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.phone" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Address(KTP)</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.address" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">City/Distric of domicile</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.city" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Province of domicile</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.province" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Profession</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.profession" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Born</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.born" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Join Date</label>
                                        <input class="form-control" type="text" :value="detail.activated_at" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Leader</label>
                                        <input class="form-control" type="text" value="-" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Nearest Distributor</label>
                                        <input class="form-control" type="text" value="-" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Google Business</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.google_business" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Facebook</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.fb" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Instagram</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.ig" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Shopee</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.shoopee" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Tokopedia</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.tokopedia" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Lazada</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.lazada" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Tiktok</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.tiktok" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <div class="border p-2 mt-3">
                                            <p>Preview KTP:</p>
                                            <template v-if="detail.user_profile.ktp">
                                                <img :src="($config.baseImgUrl+detail.user_profile.ktp)" class="img-fluid mb-3" />
                                            </template>
                                        </div>
                                    </div>
                                    <div class="form-group mb-3">
                                        <div class="border p-2 mt-3">
                                            <p>Preview Bukti Transfer:</p>
                                            <template v-if="detail.user_profile.ktp">
                                                <img :src="($config.baseImgUrl+detail.user_profile.photo_tf)" class="img-fluid mb-3" />
                                            </template>
                                        </div>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Unix Transfer</label>
                                        <input class="form-control" type="text" :value="detail.user_profile.tf_unix" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Tanggal Transfer</label>
                                        <input class="form-control" type="text" :value="$moment(detail.user_profile.tf_date).format('DD/MM/YYYY')" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label" for="motto">Motto</label>
                                        <textarea class="form-control" id="motto" name="motto" cols="30" rows="10" placeholder="Motto." readonly>{{ detail.user_profile.motto }}</textarea>
                                    </div>
                                    <a :href="'https://web.whatsapp.com/send?phone='+detail.user_profile.phone" target="_blank" class="btn btn-success w-100" type="button"><i class="bi bi-whatsapp"></i> Whatsapp</a>
                                </form>
                            </div>
                        </div>
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
            form_status: {},
            detail: {
                user_profile : {
                    img_profile : null
                }
            },
            isLoading: true,
        }
    },
    async mounted() {
        this.loadData()
    },
    methods: {
        async viewDetail(i) {
            console.log("viewDetail");
            this.detail = this.dataDesc[i]
            console.log(this.detail);
            if(this.detail.view_admin == 0){
                await this.$axios.post('/admin/user/update-view-admin', this.detail)
                .then((response) => {
                    console.log(response);
                    this.dataDesc[i].view_admin = 1
                })
                .catch((error) => {
                    console.log(error);
                });
            }
        },
        async submitActivate(){
            console.log("submitActivate");
            this.isLoading = true
            this.form_status.status = 'active'

            await this.$axios.post('/admin/user/update-status', this.form_status)
            .then((response) => {
                console.log(response);
                document.querySelector('#bootstrapBasicModal button[data-bs-dismiss="modal"]').click();
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

            await this.$axios.post('/admin/user/update-status', this.form_status)
            .then((response) => {
                console.log(response);
                document.querySelector('#bootstrapBasicModal button[data-bs-dismiss="modal"]').click();
                this.isLoading = false
            })
            .catch((error) => {
                console.log(error);
            });
        },
        viewStatus(i){
            console.log("viewStatus");
            this.form_status = this.dataDesc[i]
            console.log(this.form_status)
        },
        async loadData(){
            const data = await this.$axios.$get('/admin/user/fetch')
            if(data.status == 'success'){
                this.data = data.data
                this.isLoading = false
                console.log(this.data);
            }
        }
    },
    computed: {
        dataDesc() {
            return _.orderBy(this.data.user, 'id', 'desc');
        },
    }
}
</script>