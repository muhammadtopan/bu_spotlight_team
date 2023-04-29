<template>
    <!-- Header Area -->
    <div class="header-area" id="headerArea">
        <div class="container">
            <!-- # Paste your Header Content from here -->
            <!-- # Header Five Layout -->
            <!-- # Copy the code from here ... -->
            <!-- Header Content -->
            <div class="header-content header-style-three position-relative d-flex align-items-center justify-content-between">
                <!-- Navbar Toggler -->
                <div class="navbar--toggler" id="affanNavbarToggler" data-bs-toggle="offcanvas" data-bs-target="#affanOffcanvas" aria-controls="affanOffcanvas">
                    <div class="span-wrap"><span class="d-block"></span><span class="d-block"></span><span class="d-block"></span></div>
                <!-- <span class="d-block"></span>
                    <span class="d-block"></span>
                    <span class="d-block"></span> -->
                </div>
                <!-- Logo Wrapper -->
                <div class="logo-wrapper">
                    <NuxtLink to="/mitra/home">
                        <img src="/img/core-img/logo.png" alt="">
                    </NuxtLink>
                </div>
                <!-- User Profile -->
                <div class="user-profile-wrapper">
                    <a class="user-profile-trigger-btn" href="#" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBottom" aria-controls="offcanvasBottom">
                        <img src="/img/bg-img/2.jpg" alt="">
                    </a>
                    <!-- Offcanvas Wrapper -->
                    <div class="offcanvas offcanvas-bottom" style="border-radius: 2rem !important" id="offcanvasBottom" tabindex="-1" aria-labelledby="offcanvasBottomLabel">
                    <!-- Close Button -->
                        <button class="btn-close text-reset" type="button" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        <!-- Offcanvas Body -->
                        <div class="offcanvas-body p-4 my-auto text-center">
                            <h5>Logout</h5>
                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal" type="button"><i class="bi bi-box-arrow-right"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- # Header Five Layout End -->
        </div>
    </div>
</template>

<script>
export default {
    name: 'MitraHeader'
}
</script>