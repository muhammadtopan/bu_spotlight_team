<template>
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <Toast v-for="t in toast" v-bind:key="t.range" :data="t" />
    <div class="pt-3"></div>
    <span v-if="$auth.user.verify_at==null">
        <div class="container">
            <!-- Element Heading -->
            <div class="element-heading">
                <h6>Verifikasi Akun</h6>
            </div>
        </div>
        <div class="container">
            <div class="card">
                <div class="card-body">
                    <form @submit.prevent="submitAdd">
                        <div class="form-group mb-3">
                            <label class="form-label">Email</label>
                            <input v-model="form.email" class="form-control" type="email" readonly required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Nama</label>
                            <input v-model="form.name" class="form-control" type="text" readonly required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Domisili</label>
                            <input v-model="form.user_profile.domicile" class="form-control" type="text" readonly required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Posisi</label>
                            <input v-model="form.role" class="form-control" type="text" readonly required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Whatsapp</label>
                            <input v-model="form.user_profile.phone" class="form-control" type="text" readonly required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Alamat(KTP)</label>
                            <input v-model="form.user_profile.address" class="form-control" type="text" placeholder="alamat berdasarkan KTP" required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Kota/Kabuoaten Domisili</label>
                            <input v-model="form.user_profile.city" class="form-control" type="text" placeholder="kota/kab. domisili" required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Provinsi Domisili</label>
                            <input v-model="form.user_profile.province" class="form-control" type="text" placeholder="provinsi domisili" required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Pekerjaan</label>
                            <input v-model="form.user_profile.profession" class="form-control" type="text" placeholder="pekerjaan" required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Tanggal Lahir</label>
                            <input v-model="form.user_profile.born" class="form-control" type="date" required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Tanggal Gabung SR12</label>
                            <input v-model="form.user_profile.join_at" class="form-control" type="date" required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Nama Leader</label>
                            <input v-model="form.leader" class="form-control" type="text" value="ambil dari database" readonly required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Distributor Terdekat</label>
                            <input v-model="form.user_profile.nearest_distributor" class="form-control" type="text" placeholder="nama distributor">
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Google Bisnis</label>
                            <input v-model="form.user_profile.google_business" class="form-control" type="text" placeholder="google bisnis">
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Facebook</label>
                            <input v-model="form.user_profile.fb" class="form-control" type="text" placeholder="facebook">
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Instagram</label>
                            <input v-model="form.user_profile.ig" class="form-control" type="text" placeholder="instagram">
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Shopee</label>
                            <input v-model="form.user_profile.shoope" class="form-control" type="text" placeholder="shopee">
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Tokopedia</label>
                            <input v-model="form.user_profile.tokopedia" class="form-control" type="text" placeholder="tokopedia">
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Lazada</label>
                            <input v-model="form.user_profile.lazada" class="form-control" type="text" placeholder="lazada">
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Tiktok</label>
                            <input v-model="form.user_profile.tiktok" class="form-control" type="text" placeholder="tiktok">
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Foto KTP</label>
                            <input v-model="form.user_profile.ktp" class="form-control" type="hidden" placeholder="tiktok">
                            <input id="file-ktp" accept="image/*" @change="previewImageKtp" class="form-control border-0" type="file" required>
                            <small>ukuran file maksimal 200 kb <span class="text-danger">*</span></small>
                            <div class="border p-2 mt-3">
                                <p>Preview KTP:</p>
                                <template v-if="preview_ktp">
                                    <img :src="preview_ktp" class="img-fluid mb-3" />
                                    <p class="mb-1">file name: {{ image_ktp.name }}</p>
                                    <p class="mb-1">size: {{ image_ktp.size/1024 }}KB</p>
                                </template>
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Motto</label>
                            <textarea v-model="form.user_profile.motto" class="form-control" cols="30" rows="10" placeholder="motto"></textarea>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Bukti Transfer</label>
                            <input v-model="form.user_profile.photo_tf" class="form-control" type="hidden" placeholder="tiktok">
                            <input id="file-tf" accept="image/*" @change="previewImageTf" class="form-control border-0" type="file" required> 
                            <small>ukuran file maksimal 200 kb <span class="text-danger">*</span></small>
                            <div class="border p-2 mt-3">
                                <p>Preview Transfer:</p>
                                <template v-if="preview_tf">
                                    <img :src="preview_tf" class="img-fluid mb-3" />
                                    <p class="mb-1">file name: {{ image_tf.name }}</p>
                                    <p class="mb-1">size: {{ image_tf.size/1024 }}KB</p>
                                </template>
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Kode Unik Transfer</label>
                            <input v-model="form.user_profile.tf_unix" class="form-control" type="text" placeholder="kode unik" required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="form-label">Tanggal Transfer</label>
                            <input v-model="form.user_profile.tf_date" class="form-control" type="date" required>
                        </div>
                        <button class="btn btn-success w-100" type="submit">Kirim</button>
                    </form>
                </div>
            </div>
        </div>
    </span>
    <span v-else>
        <div class="container">
            <div class="d-flex justify-content-center">
                <lottie-player src="https://assets9.lottiefiles.com/packages/lf20_fbwbq3um.json"  background="transparent"  speed="1"  style="width: 300px; height: 300px;" autoplay></lottie-player>
            </div>
            <button class="btn btn-success w-100" type="button"><i class="bi bi-check"></i> Menunggu Verifikasi Admin</button>
        </div>
    </span>
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
                        <button  data-bs-dismiss="modal" class="btn btn-success w-100" type="button"><i class="bi bi-check"></i> Berhasil</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</template>
<script>
import Loader from '../../components/Loader';
import Toast from '../../components/Toast';
var _ = require('lodash');
export default {
    layout: 'layoutVerify',
    components: {
        Toast,
        Loader
    },
    data() {
        return {
            isLoading: true,
            toast: [],
            form: {},
            preview_ktp: null,
            image_ktp: null,
            preview_tf: null,
            image_tf: null,
        }
    },
    created(){
        this.form = _.cloneDeep(this.$auth.user);
    },
    async mounted() {
        this.$auth.user.status != 'request' ? this.$router.push('/login') : '';
        console.log('mounted verify');
        console.log(this.$auth.user);
        console.log(this.form);
        this.isLoading = false;
    },
    methods: {
        async submitAdd(){
            console.log('submitAdd');
            this.isLoading = true;
            console.log(this.form);
            let formData = new FormData();
            formData.append('data', JSON.stringify(this.form));
            formData.append('photo_ktp', document.getElementById('file-ktp').files[0]);
            formData.append('photo_tf', document.getElementById('file-tf').files[0]);
            await this.$axios.post('/verify/verify-form', formData)
            .then((r) => {
                console.log(r);
                if(r.data.status == 'success'){
                    new bootstrap.Modal(document.getElementById("successModal"), {}).show();
                    this.toast.push({
                        range: this.toast.length+1,
                        type: 'success',
                        title: 'BERHASIL',
                        msg: 'Data berhasil di upload.'
                    });
                    const userToUpdate = {...this.$auth.user};
                    userToUpdate.verify_at = r.data.data.verify_at;
                    this.$auth.setUser(userToUpdate);
                    console.log(r.data.data);
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
        },
        previewImageKtp: function(event) {
            var input = event.target;
            if (input.files) {
                var reader = new FileReader();
                reader.onload = (e) => {
                    this.preview_ktp = e.target.result;
                }
                this.image_ktp=input.files[0];
                reader.readAsDataURL(input.files[0]);
            }
        },
        previewImageTf: function(event) {
            var input = event.target;
            if (input.files) {
                var reader = new FileReader();
                reader.onload = (e) => {
                    this.preview_tf = e.target.result;
                }
                this.image_tf=input.files[0];
                reader.readAsDataURL(input.files[0]);
            }
        },
    },
    computed: {
    }
}
</script>