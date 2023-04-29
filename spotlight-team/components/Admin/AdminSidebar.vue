<template>
    <!-- ////////////////////////////////// Sidebar ////////////////////////////////// -->
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
                        <h6 class="user-name mb-0">Muhammad Topan</h6>
                        <span>CTO, Spotlight Team</span>
                    </div>
                </div>
                <!-- Sidenav Nav -->
                <ul class="sidenav-nav ps-0">
                    <li @click="linkMenu">
                        <NuxtLink to="/admin/dashboard"><i class="bi bi-house-door"></i>Dashboard</NuxtLink>
                    </li>
                    <li @click="linkMenu">
                        <NuxtLink to="/admin/user">
                            <i class="bi bi-people"></i>Users
                        </NuxtLink>
                    </li>
                    <li @click="linkMenu">
                        <NuxtLink to="/admin/du">
                            <i class="bi bi-person"></i>Distributor
                        </NuxtLink>
                    </li>
                    <li @click="linkMenu">
                        <NuxtLink to="/admin/product">
                            <i class="bi bi-box-seam"></i>Product
                        </NuxtLink>
                    </li>
                    <li>
                        <div class="night-mode-nav"><i class="bi bi-moon"></i>Night Mode
                            <div class="form-check form-switch">
                                <input v-model="isTheme" class="form-check-input form-check-success" checked id="darkSwitch" type="checkbox">
                            </div>
                        </div>
                    </li>
                    <li data-bs-toggle="modal" data-bs-target="#logoutModal">
                        <a href="#"><i class="bi bi-box-arrow-right"></i>Logout</a>
                    </li>
                </ul>
                <!-- Copyright Info -->
                <div class="copyright-info">
                    <p>2022 &copy; Made by<NuxtLink to="#">Taufano</NuxtLink> {{ isTheme }}</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'AdminSidebar',
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
        }
    }
    
}
</script>