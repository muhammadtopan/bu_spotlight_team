<template>
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
                        <button type="button" class="btn btn-success w-100" data-bs-dismiss="modal" aria-label="Close"><i class="bi bi-check"></i> Berhasil</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    name: "SuccessModal",
    data() {
        return {
            redirectURL : null
        }
    },
    mounted() {
        setTimeout(() => this.isToast = false, 7000);
    }
}
</script>