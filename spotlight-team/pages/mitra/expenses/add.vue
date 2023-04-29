<template>
<!-- Content -->
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <Toast v-for="t in toast" v-bind:key="t.range" :data="t" />
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Input Pengeluaran</h6>
        </div>
    </div>
    <div class="container">
        <div class="card">
            <div class="card-body">
                <form @submit.prevent="submitAdd">
                    <div class="form-group">
                        <label class="form-label" for="expenses-date">Tanggal</label>
                        <input v-model="form_add.created_at" class="form-control" id="expenses-date" type="datetime-local" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="item">Item Pengeluaran</label>
                        <input v-model="form_add.item" class="form-control" id="item" type="text" placeholder="item pengeluaran" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="category">Kategori</label>
                        <select v-model="form_add.category" class="form-select" id="category" name="category" required>
                            <option value="Ongkir">Ongkir</option>
                            <option value="Konsumsi">Konsumsi</option>
                            <option value="Kebersihan">Kebersihan</option>
                            <option value="Operasional">Operasional</option>
                            <option value="Toolskit">Toolskit</option>
                            <option value="ATK">ATK</option>
                            <option value="Reward">Reward</option>
                            <option value="Branding">Branding</option>
                            <option value="Pembinaan">Pembinaan</option>
                            <option value="Lainnya" selected>Lainnya</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="price">Nominal Pengeluaran</label>
                        <input v-model="form_add.nominal" class="form-control" id="price" type="text" placeholder="nominal">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="jenisTransaksi">Jenis Transaksi</label>
                        <select v-model="form_add.type_trans" class="form-select" id="jenisTransaksi" name="jenisTransaksi" required>
                            <option value="transfer" selected>Transfer</option>
                            <option value="cash">Cash</option>
                        </select>
                    </div>
                    <div v-if="form_add.type_trans=='transfer'" class="form-group">
                        <label class="form-label" for="jenisBank">Jenis Bank</label>
                        <select v-model="form_add.bank" class="form-select" id="jenisBank" name="jenisBank" required>
                            <option value="BRI" selected>BRI</option>
                            <option value="BNI">BNI</option>
                            <option value="BCA">BCA</option>
                            <option value="Mandiri">Mandiri</option>
                        </select>
                    </div>
                    <div class="d-flex justify-content-end">
                        <button class="btn btn-creative btn-warning" type="submit">Input</button>
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
                        <a href="expenses.php" class="btn btn-success w-100"><i class="bi bi-check"></i> Berhasil</a>
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
export default {
    layout: 'layoutMitra',
    components: {
        Toast,
        Loader
    },
    data() {
        return {
            isLoading: true,
            form_add : {
                created_at: this.$moment().format('YYYY-MM-DD hh:mm A'),
                category: 'Lainnya',
                type_trans: 'transfer',
                bank: 'BRI'
            },
            toast: [],
        }
    },
    mounted() {
        this.isLoading = false;
    },
    methods: {
        async submitAdd(){
            console.log('submitAdd');
            console.log(this.form_add);

            this.isLoading = true
            console.log(this.form_add);
            await this.$axios.post('/mitra/expenses/add', this.form_add)
            .then((r) => {
                if(r.data.status == 'success'){
                    this.$router.push('/mitra/expenses');
                }
                console.log(r);
            })
            .catch((error) => {
                console.log(error);
            });
        }
    },
}
</script>