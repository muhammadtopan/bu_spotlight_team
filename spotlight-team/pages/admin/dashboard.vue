<template>
    <!-- ////////////////////////////////// Content ////////////////////////////////// -->
    <div class="page-content-wrapper">
        <Loader :isLoading="isLoading" />
        <Toast v-for="t in toast" v-bind:key="t.range" :data="t" />
        
        <div class="pt-3"></div>
        <div class="container direction-rtl">
            <div class="card mb-3">
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-4">
                            <div class="feature-card mx-auto text-center">
                                <div class="card mx-auto border">
                                    <i class="bi bi-people text-light"></i>
                                </div>
                                <p class="mb-0">Users</p>
                            </div>
                        </div>
                        <div class="col-4 my-auto">
                            <div class="feature-card text-center">
                                <h1 class="mb-0">{{ data.users ? data.users : '' }}</h1>
                                <p class="mb-0">account</p>
                            </div>
                        </div>
                        <div class="col-4 my-auto">
                            <div class="feature-card text-center">
                                <NuxtLink to="/admin/user" class="btn btn-creative btn-warning"><i class="bi bi-eye"></i></NuxtLink>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container direction-rtl">
            <div class="card mb-3">
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-4">
                            <div class="feature-card mx-auto text-center">
                                <div class="card mx-auto border">
                                    <i class="bi bi-person-check text-light"></i>
                                </div>
                                <p class="mb-0">Active</p>
                            </div>
                        </div>
                        <div class="col-4 my-auto">
                            <div class="feature-card text-center">
                                <h1 class="mb-0">{{ data.users ? data.user_active : '' }}</h1>
                                <p class="mb-0">account</p>
                            </div>
                        </div>
                        <div class="col-4 my-auto">
                            <div class="feature-card text-center">
                                <NuxtLink class="btn btn-creative btn-warning" to="/admin/user"><i class="bi bi-eye"></i> </NuxtLink>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container direction-rtl">
            <div class="card mb-3">
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-4">
                            <div class="feature-card mx-auto text-center">
                                <div class="card mx-auto border">
                                    <i class="bi bi-person-x text-light"></i>
                                </div>
                                <p class="mb-0">Inactive</p>
                            </div>
                        </div>
                        <div class="col-4 my-auto">
                            <div class="feature-card text-center">
                                <h1 class="mb-0">{{ data.users ? data.user_inactive : '' }}</h1>
                                <p class="mb-0">account</p>
                            </div>
                        </div>
                        <div class="col-4 my-auto">
                            <div class="feature-card text-center">
                                <NuxtLink class="btn btn-creative btn-warning" to="/admin/user"><i class="bi bi-eye"></i> </NuxtLink>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container direction-rtl">
            <div class="card mb-3">
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-4">
                            <div class="feature-card mx-auto text-center">
                                <div class="card mx-auto border">
                                    <i class="bi bi-person-plus text-light"></i>
                                </div>
                                <p class="mb-0">Request</p>
                            </div>
                        </div>
                        <div class="col-4 my-auto">
                            <div class="feature-card text-center">
                                <h1 class="mb-0">{{ data.users ? data.user_request : '' }}</h1>
                                <p class="mb-0">account</p>
                            </div>
                        </div>
                        <div class="col-4 my-auto">
                            <div class="feature-card text-center">
                                <NuxtLink class="btn btn-creative btn-warning" to="/admin/user"><i class="bi bi-eye"></i> </NuxtLink>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container direction-rtl">
            <div class="card mb-3">
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-4">
                            <div class="feature-card mx-auto text-center">
                                <div class="card mx-auto border">
                                    <i class="bi bi-person text-light"></i>
                                </div>
                                <p class="mb-0">Distributor</p>
                            </div>
                        </div>
                        <div class="col-4 my-auto">
                            <div class="feature-card text-center">
                                <h1 class="mb-0">{{ data.users ? data.user_distributor : '' }}</h1>
                                <p class="mb-0">people</p>
                            </div>
                        </div>
                        <div class="col-4 my-auto">
                            <div class="feature-card text-center">
                                <NuxtLink class="btn btn-creative btn-warning" to="/admin/du"><i class="bi bi-eye"></i></NuxtLink>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container direction-rtl">
            <div class="card mb-3">
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-4">
                            <div class="feature-card mx-auto text-center">
                                <div class="card mx-auto border">
                                    <i class="bi bi-box-seam text-light"></i>
                                </div>
                                <p class="mb-0">Product</p>
                            </div>
                        </div>
                        <div class="col-4 my-auto">
                            <div class="feature-card text-center">
                                <h1 class="mb-0">{{ data.users ? data.product : '' }}</h1>
                                <p class="mb-0">item</p>
                            </div>
                        </div>
                        <div class="col-4 my-auto">
                            <div class="feature-card text-center">
                                <NuxtLink class="btn btn-creative btn-warning" to="/admin/product"><i class="bi bi-eye"></i></NuxtLink>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="pb-3"></div>
    </div>
</template>
<script>
import Loader from '../../components/Loader';
import Toast from '../../components/Toast';
export default {
    layout: 'layoutAdmin',
    components: {
        Toast,
        Loader
    },
    data() {
        return {
            isLoading: true,
            data : [],
            toast: [],
        }
    },
    async mounted() {
        console.log(this.loginMessage);
        const data = await this.$axios.$get('/admin')
        if(data.status == 'success'){
            this.data = data.data
            this.isLoading = false
            if(this.loginMessage){
                this.toast.push({
                    range: this.toast.length+1,
                    type: 'success',
                    title: 'Welcome Admin!',
                    msg: 'Enjoy your day.'
                })
            }
            this.$store.commit('setOffLoginMessage')
        }
        console.log(this.data)
        console.log(this.$auth.user);
    },
    methods: {
    },
    computed: {
        loginMessage() {
            return this.$store.getters.getLoginMessage // call function getter untuk mendapatkan data
        },
    },
}
</script>