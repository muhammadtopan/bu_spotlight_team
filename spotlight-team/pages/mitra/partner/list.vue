<template>
<!-- Content -->
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <Toast v-for="t in toast" v-bind:key="t.range" :data="t" />
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Daftar Mitra</h6>
        </div>
    </div>
    <!-- Pagination -->
    <div class="shop-pagination pb-3">
        <div class="container">
            <div class="card">
                <div class="card-body p-2">
                    <div class="d-flex align-items-center justify-content-between">
                        <small class="ms-1">Tambah Mitra</small>
                        <a class="btn btn-creative btn-warning" href="#" data-bs-toggle="modal" data-bs-target="#mitraModal">
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
                            <th>Nama</th>
                            <th>Posisi</th>
                            <th>Domisili</th>
                            <th>WA</th>
                            <th>Detail</th>
                        </tr>
                    </thead>
                    <tbody >
                        <tr v-for="(d,i) in dataDesc">
                            <td>
                                <a href="#" @click="viewProfile(i)" class="position-relative" data-bs-toggle="modal" data-bs-target="#profileUserModal">
                                    {{ d.name }}
                                </a>
                            </td>
                            <td>{{ d.role }}</td>
                            <td>{{ d.user_profile.domicile }}</td>
                            <td><a v-if="d.user_profile.phone" class="btn btn-success btn-sm" target="_blank" :href="'https://api.whatsapp.com/send?phone='+d.user_profile.phone"><i class="bi bi-whatsapp"></i></a></td>
                            <td><NuxtLink to="/mitra/partner/details">Details</NuxtLink></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="pb-3"></div>

    <!-- Mitra Modal -->
    <div class="modal fade" id="mitraModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title" id="exampleModalLabel">Tambah MItra</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <form @submit.prevent="submitAdd">
                            <div class="form-group">
                                <label class="form-label" for="email">Email Mitra</label>
                                <input v-model="form_add.email" class="form-control" id="email" type="email" placeholder="email@email.com" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="name">Nama Mitra</label>
                                <input v-model="form_add.name" class="form-control" id="name" type="text" placeholder="Nama" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="position">Posisi</label>
                                <select v-model="form_add.role" class="form-select" id="position" required>
                                    <option value="agen">Agen</option>
                                    <option value="sub agen">Sub Agen</option>
                                    <option value="reseller">Reseller</option>
                                    <option value="marketer">Marketer</option>
                                    <option value="customer">Customer ( Offline )</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="domicile">Domisili</label>
                                <input v-model="form_add.domicile" class="form-control" id="domicile" type="text" placeholder="Domisili" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="phone">Whatsapp</label>
                                <input v-model="form_add.phone" class="form-control" id="phone" type="number" placeholder="08**********" required>
                            </div>
                            <button class="btn btn-primary w-100 d-flex align-items-center justify-content-center" type="submit">Input
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

    <!-- Profile Modal -->
    <div class="modal fade" id="profileUserModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title" id="exampleModalLabel">Profile Users</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div v-if="profile" class="modal-body">
                    <div class="container">
                        <!-- User Information-->
                        <div class="card user-info-card mb-3">
                            <div class="card-body d-flex align-items-center">
                                <div class="user-profile me-3">
                                    <img :src="profile.user_profile.img_profile? `${$config.baseImgUrl}`+profile.user_profile.img_profile:`${$config.baseImgUrl}demo/500x500.jpg`" alt="">
                                </div>
                                <div class="user-info">
                                    <div class="d-flex align-items-center">
                                        <h5 class="mb-1">{{ profile.name }}</h5>
                                    </div>
                                    <p class="mb-0">{{ profile.role }}</p>
                                </div>
                            </div>
                        </div>
                        <!-- User Meta Data-->
                        <div class="card user-data-card">
                            <div class="card-body">
                                <form >
                                    <div class="form-group mb-3">
                                        <label class="form-label">NIM</label>
                                        <input class="form-control" type="text" :value="profile.id" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Email</label>
                                        <input class="form-control" type="email" :value="profile.email" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Nama</label>
                                        <input class="form-control" type="text" :value="profile.name" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Domisili</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.domicile" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Posisi</label>
                                        <input class="form-control" type="text" :value="profile.role" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Whatsapp</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.phone" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Alamat(KTP)</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.address" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Kota/Kab. domisili</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.city" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Provinsi Domisili</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.province" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Pekerjaan</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.profession" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Tanggal Lahir</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.born?getReformatDate(profile.user_profile.born):''" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Tanggal Gabung SR12</label>
                                        <input class="form-control" type="text" :value="profile.activated_at?getReformatDate(profile.activated_at):''" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Google Bisnis</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.google_business" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Facebook</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.facebook" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Instagram</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.instagram" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Shopee</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.shopee" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Tokopedia</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.tokopedia" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Lazada</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.lazada" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label">Tiktok</label>
                                        <input class="form-control" type="text" :value="profile.user_profile.tiktok" readonly>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label" for="motto">Motto</label>
                                        <textarea class="form-control" id="motto" name="motto" cols="30" rows="10" placeholder="Motto." readonly>
                                            {{ profile.user_profile.motto }}
                                        </textarea>
                                    </div>
                                    <a v-if="profile.phone" :href="'https://api.whatsapp.com/send?phone='+profile.phone" target="_blank" class="btn btn-success w-100" ><i class="bi bi-whatsapp"></i> Whatsapp</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <SuccessModal />

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
        Loader
    },
    data() {
        return {
            isLoading: true,
            toast: [],
            data : [],
            form_add: {
                role: 'agen',
            },
            profile : null,
        }
    },
    async mounted() {
        await this.loadData()
    },
    methods: {
        async submitAdd(){
            document.querySelector('#mitraModal button[data-bs-dismiss="modal"]').click();
            this.isLoading = true;
            console.log(this.form_add);
            await this.$axios.post('/mitra/partner/add', this.form_add)
            .then((r) => {
                console.log(r);
                if(r.data.status == 'success'){
                    new bootstrap.Modal(document.getElementById('successModal'), {}).show();
                    this.data = [
                        ...this.data,
                        r.data.data
                    ];
                    this.toast.push({
                        range: this.toast.length+1,
                        type: 'success',
                        title: 'BERHASIL',
                        msg: 'Berhasil input mitra baru.'
                    });
                }else{
                    this.toast.push({
                        range: this.toast.length+1,
                        type: 'danger',
                        title: 'GAGAL',
                        msg: 'Email sudah terdaftar atau data mungkin belum lengkap.'
                    })
                }
                this.isLoading = false;
            })
            .catch((error) => {
                console.log(error);
                this.toast.push({
                    range: this.toast.length+1,
                    type: 'danger',
                    title: 'GAGAL',
                    msg: 'Email sudah terdaftar atau data mungkin belum lengkap..'
                })
                this.isLoading = false;
            });
            
        },
        getReformatDate(data){
            const dt = new Date(data);
            const yyyy = dt.getFullYear();
            let mm = dt.getMonth() + 1; // Months start at 0!
            let dd = dt.getDate();

            if (dd < 10) dd = '0' + dd;
            if (mm < 10) mm = '0' + mm;

            return (dd + '-' + mm + '-' + yyyy);
        },
        viewProfile(i){
            this.profile = this.dataDesc[i]
        },
        async loadData(){
            const data = await this.$axios.$get('/mitra/partner/fetch')
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
    },
}
</script>