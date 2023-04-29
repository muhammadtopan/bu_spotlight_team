<template>
    <!-- Login Wrapper Area -->
    <div class="login-wrapper d-flex align-items-center justify-content-center">
        <Loader :isLoading="isLoading" />
        <div class="custom-container">
            <div class="text-center px-4">
                <img class="login-intro-img" src="/img/bg-img/36.png" alt="">
            </div>
            <!-- Register Form -->
            <div class="register-form mt-4">
                <h6 class="mb-3 text-center">Ayo masuk untuk pertualangan seru.</h6>
                <form @submit.prevent="userLogin">
                <!-- <form> -->
                    <div class="form-group">
                        <input v-model="login.email" class="form-control" type="text" placeholder="Username" required>
                    </div>
                    <div class="form-group position-relative">
                        <input v-model="login.password" class="form-control" :type="showInput? 'text':'password'" placeholder="Masukan Password" required>
                        <div @click="showInput=!showInput" class="position-absolute" id="password-visibility">
                            <i v-if="showInput==false" class="bi bi-eye"></i>
                            <i v-if="showInput==true" class="bi bi-eye-slash"></i>
                        </div>
                    </div>
                    <!-- <NuxtLink to="/admin/dashboard" class="btn btn-primary w-100">Masuk</NuxtLink> -->
                    <button class="btn btn-primary w-100" type="submit">Masuk</button>
                    <!-- <button class="btn btn-primary w-100" type="button" @click="userLogin">Masuk</button> -->
                </form>
            </div>
            <!-- Login Meta -->
            <div class="login-meta-data text-center">
                <NuxtLink class="stretched-link forgot-password d-block mt-3 mb-1" to="/auth/forget-password">
                    Lupa Password?
                </NuxtLink>
            </div>
        </div>
    </div>
</template>

<script>
import Loader from '../components/Loader.vue';
export default {
    layout: 'layoutAuth',
    components: {
        Loader
    },
    data() {
        return {
            isLoading : true,
            showInput: false,
            login: {
                // email: 'admin@gmail.com',
                email: 'belintex8@gmail.com',
                password: 'team45'
            }
        }
    },
    methods: {
        async userLogin() {
            this.isLoading = true
            try {
                console.log("userLogin");
                let response = await this.$auth.loginWith('local', { data: this.login })
                console.log(response);
                if(response.status == '200' && response.data.status != 'error') {
                    this.$store.commit('login/setOnLoginMessage');

                    if(this.$auth.user.status == 'request'){
                        this.$router.push('/mitra/verification')
                    }else{
                        await this.$auth.user.role == 'admin' ?
                            this.$router.push('/admin/dashboard')
                            : await this.$auth.user.role == 'agen' || 
                            await this.$auth.user.role == 'sub agen' || 
                            await this.$auth.user.role == 'reseller' ||
                            await this.$auth.user.role == 'marketer' ||
                            await this.$auth.user.role == 'distributor' ?
                                this.$router.push('/mitra/home') : this.$router.push('/login')
                    }
                }else{
                    this.isLoading = false
                    console.log("Bukan User active");
                    console.log(response.data.message);
                }
            } catch (err) {
                this.isLoading = false
                console.log(err.response)
            }
        }
    },
    mounted() {
        this.isLoading = false
        if(this.$auth.user != false && this.$auth.user != null && this.$auth.user.status == 'active') {
            this.$store.commit('login/setOnLoginMessage');

            if(this.$auth.user.status == 'request'){
                this.$router.push('/mitra/verification')
            }else{
                this.$auth.user.role == 'admin' ?
                    this.$router.push('/admin/dashboard')
                    : this.$auth.user.role == 'agen' || 
                        this.$auth.user.role == 'sub agen' || 
                        this.$auth.user.role == 'reseller' ||
                        this.$auth.user.role == 'marketer' ||
                        this.$auth.user.role == 'distributor' ?
                            this.$router.push('/mitra/home') : this.$router.push('/login')
            }

            
        }
    },
}
</script>