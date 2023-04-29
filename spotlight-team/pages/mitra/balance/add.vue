<template>
<!-- Content -->
<div class="page-content-wrapper">
  <Loader :isLoading="isLoading" />
  <Toast v-for="t in toast" v-bind:key="t.range" :data="t" />
  <form @submit.prevent="submitAdd">
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Debit</h6>
        </div>
    </div>
    <div class="container">
        <div class="card">
            <div class="card-body">
                <div class="form-group">
                    <label class="form-label" for="expenses-date">Tanggal</label>
                    <input class="form-control" v-model="form_add.date" id="expenses-date" type="date" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="price">Nominal</label>
                    <input class="form-control" v-model="form_add.price" id="price" type="text" value="0" placeholder="nominal">
                </div>
                <div class="d-flex justify-content-end">
                    <button class="btn btn-creative btn-warning" data-bs-toggle="modal" data-bs-target="#agreementModal" type="button">Input</button>
                </div>
            </div>
        </div>
    </div>
    <div class="pb-3"></div>
    <!-- Agreement Modal -->
    <div class="modal fade" id="agreementModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title" id="exampleModalLabel">Apakah Anda yakin?</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-sm btn-secondary" type="button" data-bs-dismiss="modal">No</button>
                    <button type="submit" class="btn btn-sm btn-success" data-bs-dismiss="modal">Yes</button>
                    <!-- <button type="submit" class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#successModal">Yes</button> -->
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
                        <button @click="btnSuccess" class="btn btn-success w-100"><i class="bi bi-check"></i> Berhasil</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
  </form>
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
            toast: [],
            data: [],
            form_add: {
              date: this.$moment().format('YYYY-MM-DD'),
              price: 0
            }
        }
    },
    async mounted() {
        console.log("mounted");
        this.isLoading = false;
    },
    methods: {
      btnSuccess(){
        document.querySelector('#successModal button[data-bs-dismiss="modal"]').click();
        this.$router.push('/mitra/balance/detail');
      },
      async submitAdd(){
        this.isLoading = true;
        if(parseInt(this.form_add.price) > 0){
          this.form_add.bank = localStorage.getItem('bank');
          await this.$axios.post('/mitra/balance/add/submit-add', this.form_add)
          .then((r) => {
              console.log(r);
              if(r.data.status == 'success'){
                  new bootstrap.Modal(document.getElementById("successModal"), {}).show();
                  this.toast.push({
                      range: this.toast.length+1,
                      type: 'success',
                      title: 'BERHASIL',
                      msg: 'Transaksi berhasil.'
                  });
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
        }else{
          this.toast.push({
              range: this.toast.length+1,
              type: 'danger',
              title: 'GAGAL',
              msg: 'Data mungkin belum lengkap...'
          })
          this.isLoading = false;
        }
        console.log('submitAdd');
      }
    },
    computed: {
    }
}
</script>