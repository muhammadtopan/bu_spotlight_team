<template>
<!-- # Sidenav Left -->
<!-- Offcanvas -->
<div class="offcanvas offcanvas-start" id="affanOffcanvas" data-bs-scroll="true" tabindex="-1" aria-labelledby="affanOffcanvsLabel">
    <button class="btn-close btn-close-white text-reset" type="button" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    <div class="offcanvas-body p-0">
        <!-- Side Nav Wrapper -->
        <div class="sidenav-wrapper">
            <!-- Sidenav Profile -->
            <div class="sidenav-profile bg-gradient">
                <div class="sidenav-style1"></div>
                <!-- User Thumbnail -->
                <div class="user-profile">
                    <img src="/img/bg-img/2.jpg" alt="">
                </div>
                <!-- User Info -->
                <div class="user-info">
                    <h6 class="user-name mb-0">{{ $auth.user.name }}</h6>
                    <span>{{ $auth.user.role }}</span>
                </div>
            </div>
            <!-- Sidenav Nav -->
            <ul class="sidenav-nav ps-0" v-if="$auth.user.status=='active'">
                <li @click="linkMenu">
                    <NuxtLink to="/mitra/home"><i class="bi bi-house-door"></i>Home</NuxtLink>
                </li>
                <li @click="linkMenu">
                    <NuxtLink to="/mitra/stock/first"><i class="bi bi-server"></i>Stok Awal</NuxtLink>
                </li>
                <li @click="linkMenu">
                    <NuxtLink to="/mitra/stock"><i class="bi bi-server"></i>Stok Toko</NuxtLink>
                </li>
                <li @click="linkMenu">
                    <NuxtLink to="/mitra/sales/list"><i class="bi bi-graph-up"></i>Penjualan</NuxtLink>
                </li>
                <li @click="linkMenu">
                    <NuxtLink to="/mitra/expenses"><i class="bi bi-wallet2"></i>Pengeluaran</NuxtLink>
                </li>
                <li @click="linkMenu">
                    <NuxtLink to="/mitra/partner/list"><i class="bi bi-people"></i>Mitra</NuxtLink>
                </li>
                <li @click="linkMenu">
                    <NuxtLink to="/mitra/report"><i class="bi bi-file-earmark-bar-graph"></i>Laporan</NuxtLink>
                </li>
                <li @click="linkMenu">
                    <NuxtLink to="/mitra/balance"><i class="bi bi-currency-dollar"></i>Saldo</NuxtLink>
                </li>
                <li @click="linkMenu">
                    <NuxtLink to="/mitra/settings"><i class="bi bi-gear"></i>Settings</NuxtLink>
                </li>
                <li>
                    <div class="night-mode-nav"><i class="bi bi-moon"></i>Night Mode
                        <div class="form-check form-switch">
                            <input v-model="isTheme" class="form-check-input form-check-success" checked id="darkSwitch" type="checkbox">
                        </div>
                    </div>
                </li>
                <li>
                    <a href="#" data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="bi bi-box-arrow-right"></i>Logout</a>
                </li>
            </ul>
            <ul class="sidenav-nav ps-0" v-else>
                <li>
                    <div class="night-mode-nav"><i class="bi bi-moon"></i>Night Mode
                        <div class="form-check form-switch">
                            <input v-model="isTheme" class="form-check-input form-check-success" checked id="darkSwitch" type="checkbox">
                        </div>
                    </div>
                </li>
                <li>
                    <a href="#" data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="bi bi-box-arrow-right"></i>Logout</a>
                </li>
            </ul>
            <!-- Copyright Info -->
            <div class="copyright-info">
                <p>2022 &copy; Made by<a to="#">Taufano</a></p>
            </div>
        </div>
    </div>
</div>
</template>

<script>
export default {
    name: 'MitraSidebar',
    head() {
        return {
            htmlAttrs: {
                lang: 'en',
                'data-theme': this.isTheme? 'dark' : 'light'
            }
        }
    },
    data() {
        return {
            isTheme: true
        }
    },
    methods: {
        linkMenu() {
            document.querySelector('#affanOffcanvas button[data-bs-dismiss="offcanvas"]').click();
            // document.querySelector('#affanOffcanvas > button').click();
        }
    }
    
}
</script>