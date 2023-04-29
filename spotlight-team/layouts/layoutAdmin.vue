<template>
  <div>
    <AdminHeader />
    <AdminSidebar />
    <nuxt />
    <AdminFooter />
    <!-- Logout Modal -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModal" aria-hidden="true">
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
                    <NuxtLink to="#">
                      <button class="btn btn-sm btn-success" type="button" @click="logout()">Yes</button>
                    </NuxtLink>
                </div>
            </div>
        </div>
    </div>
  </div>
</template>

<script>
import AdminHeader from '../components/Admin/AdminHeader';
import AdminSidebar from '../components/Admin/AdminSidebar';
import AdminFooter from '../components/Admin/AdminFooter';
export default {
  components: {
    AdminHeader,
    AdminSidebar,
    AdminFooter
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
  mounted() {
    if(this.$auth.user == false || this.$auth.user == null || this.$auth.user.role != 'admin') {
        this.$router.push('/login');
    }
    // console.log("data "+$nuxt.$route.path);
    // console.log($nuxt.$route.name);
  }
}
</script>
