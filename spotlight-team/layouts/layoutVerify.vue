<template>
  <div>
    <MitraHeader />
    <MitraSidebar />
    <nuxt />
    <!-- Logout Modal -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title" id="exampleModalLabel">Are You Sure?</h6>
                    <button class="btn btn-close p-1 ms-auto" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <!-- <div class="modal-body">
                    <div class="container">
                        <p class="fw-bolder">Are You Sure?</p>
                    </div>
                </div> -->
                <div class="modal-footer">
                    <button class="btn btn-sm btn-secondary" type="button" data-bs-dismiss="modal">No</button>
                    <a class="btn btn-sm btn-success" href="#" @click="logout()">Yes</a>
                </div>
            </div>
        </div>
    </div>
  </div>
</template>

<script>
import MitraHeader from '../components/Mitra/MitraHeader';
import MitraSidebar from '../components/Mitra/MitraSidebar';
import MitraFooter from '../components/Mitra/MitraFooter';
export default {
  components: {
    MitraHeader,
    MitraSidebar,
    MitraFooter
  },
  data(){
    return {
    }
  },
  methods: {
    logout() {
      document.querySelector('#logoutModal button[data-bs-dismiss="modal"]').click();
      document.querySelector('#affanOffcanvas button[data-bs-dismiss="offcanvas"]').click();
      this.$auth.logout()
    }
  },
  async mounted() {
    console.log("== CEK USER CLIENT ==");
    console.log(this.$auth.user);
    this.$auth.user.status == 'request' ? this.$router.push('/mitra/verification') : '';
    console.log("== CEK LOGIN USER ==");
    await this.$axios.get('/auth/user')
    .then((r) => {
        console.log("res layout");
        console.log(r.data);
        var userToUpdate = {...this.$auth.user};
        userToUpdate = r.data;
        this.$auth.setUser(userToUpdate);
    })
    .catch((e) => {
        console.log(e);
    });
    
    this.$auth.user == false || this.$auth.user == null ? 
    this.$auth.user.role != 'agen' ? 
    this.$auth.user.role != 'sub agen' ?
    this.$auth.user.role != 'reseller' ?
    this.$auth.user.role != 'marketer' ? 
    this.$router.push('/login') : '' : '' : '' : '' : '';
    
    if(this.$auth.user.activated_at != null && this.$auth.user.status=='active') this.$router.push('/mitra/home');
  }
}
</script>
