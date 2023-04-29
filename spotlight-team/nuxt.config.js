export default { 
  // Global page headers: https://go.nuxtjs.dev/config-head
  publicRuntimeConfig: { 
    baseImgUrl: 'http://localhost:8000',
  },
  head: {
    title: 'Spotlight Team',
    htmlAttrs: {
      lang: 'en',
      'data-theme': 'dark'
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Spotlight Team' },
      { name: 'theme-color', content: '#0134d4' },
      { name: 'apple-mobile-web-app-capable', content: 'yes' },
      { name: 'apple-mobile-web-app-status-bar-style', content: 'black' },
      // { name: 'format-detection', content: 'telephone=no' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/dist/img/core-img/favicon.ico' },
      { rel: 'apple-touch-icon', href: '/dist/img/icons/icon-96x96.png' },
      { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap' },
      { rel: 'stylesheet', type: 'text/css', href: '/dist/css/bootstrap.min.css' },
      // { rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css' },
      { rel: 'stylesheet', href: '/dist/css/bootstrap-icons.css' },
      { rel: 'stylesheet', type: 'text/css', href: '/dist/css/tiny-slider.css' },
      { rel: 'stylesheet', type: 'text/css', href: '/dist/css/baguetteBox.min.css' },
      { rel: 'stylesheet', type: 'text/css', href: '/dist/css/rangeslider.css' },
      { rel: 'stylesheet', type: 'text/css', href: '/dist/css/vanilla-dataTables.min.css' },
      { rel: 'stylesheet', type: 'text/css', href: '/dist/css/apexcharts.css' },
      { rel: 'stylesheet', type: 'text/css', href: '/dist/style.css' },
      { rel: 'manifest', type: 'text/css', href: '/dist/manifest.json' },
      { rel: 'stylesheet', type: 'text/css', href: 'https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css' }
    ],
    script: [
      { src: 'https://cdn.jsdelivr.net/jquery/latest/jquery.min.js' },
      { src: '/dist/js/bootstrap.bundle.min.js' },
      { src: '/dist/js/slideToggle.min.js' },
      { src: '/dist/js/internet-status.js' },
      { src: '/dist/js/tiny-slider.js' },
      { src: '/dist/js/baguetteBox.min.js' },
      { src: '/dist/js/countdown.js' },
      { src: '/dist/js/rangeslider.min.js' },
      { src: '/dist/js/vanilla-dataTables.min.js' },
      { src: '/dist/js/index.js' },
      { src: '/dist/js/imagesloaded.pkgd.min.js' },
      { src: '/dist/js/isotope.pkgd.min.js' },
      { src: '/dist/js/dark-rtl.js' },
      { src: '/dist/js/active.js' },
      { src: '/dist/js/pswmeter.js' },
      { src: '/dist/js/pwa.js' },
      { src: 'https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js' },
      { src: 'https://cdn.jsdelivr.net/momentjs/latest/moment.min.js' },
      { src: 'https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js' },
    ]
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
  ],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    '@nuxtjs/moment',
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/axios
    '@nuxtjs/axios',
    '@nuxtjs/auth-next'
  ],

  // Axios module configuration: https://go.nuxtjs.dev/config-axios
  axios: {
    // Workaround to avoid enforcing hard-coded localhost:3000: https://github.com/nuxt-community/axios-module/issues/308
    baseURL: 'http://localhost:8000/api/',
  },
  auth: {
    strategies: {
      local: {
        token: {
          property: 'access_token',
          // global: true,
          required: true,
          type: 'Bearer'
        },
        user: {
          property: false,
          autoFetch: true
        },
        endpoints: {
          login: { url: '/login', method: 'post' },
          logout: { url: '/logout', method: 'post' },
          user: { url: '/auth/user', method: 'get' }
        }
      }
    },
    rewriteRedirects: false,
    redirect: {
      login: '/login',
      logout: '/login',
      callback: '/login',
      home: '/'
    },
  },
  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
    // extractCSS: true,
  }
}
