<template>
<!-- Content -->
<div class="page-content-wrapper">
    <Loader :isLoading="isLoading" />
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Laporan</h6>
        </div>
    </div>
    <div class="container mb-2">
        <div class="card">
            <div class="card-body py-3">
                <form action="">
                    <div class="form-group">
                        <label class="form-label">Jenis Laporan</label>
                        <select v-model="form_filter.type" @change="changeType(form_filter.type)" class="form-select">
                            <option value="Omset">Omset</option>
                            <option value="Produk">Produk</option>
                            <option value="Mitra">Mitra</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-6">
                                <label class="form-label">Range Tanggal From</label>
                                <input v-model="form_filter.from_at" @change="changeRange" class="form-control" type="date" required>
                            </div>
                            <div class="col-6">
                                <label class="form-label">To</label>
                                <input v-model="form_filter.to_at" @change="changeRange" class="form-control" type="date" required>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="container">
        <div v-if="form_filter.type=='Produk'"  class="card">
            <div class="card-body table-responsive">
                <table class="table w-100" id="dataTable2">
                    <thead>
                        <tr>
                            <th rowspan="2">Product</th>
                            <th rowspan="2">Satuan</th>
                            <th rowspan="2">Harga</th>
                            <th :colspan="dateProduct.length" class="text-center">Tanggal</th>
                            <th rowspan="2">Total</th>
                        </tr>
                        <tr>
                            <th v-for="d in dateProduct">{{ d }}</th>
                        </tr>
                    </thead>
                    <tbody >
                        <tr v-for="(d,i) in productFetch" :key="d.name">
                            <td>{{ d.name }}</td>
                            <td>{{ d.unit }}</td>
                            <td>{{ formatRp(d.price) }}</td>
                            <td v-for="d_date in dateProduct">
                                {{ viewDataProductFilter(d_date, d.trans) }}
                            </td>
                            <td>{{ d.total }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="pb-3"></div>
</div>
</template>
<script>
import Loader from '../../components/Loader';
import Toast from '../../components/Toast';
var _ = require('lodash');
export default {
    layout: 'layoutMitra',
    components: {
        Toast,
        Loader
    },
    data() {
        return {
            isLoading: false,
            data: null,
            form_filter: {
                type: 'Omset',
                from_at: this.$moment().set('date', 1).format('YYYY-MM-DD'),
                to_at: this.$moment().format('YYYY-MM-DD')
            }
        }
    },
    async mounted() {
    },
    methods: {
        async changeType(type){
            console.log('changeType');
            // type == 'Omset' ? new DataTable("#dataTable") : '';
            type == 'Produk' ? await this.loadProduct() : '';
            // type == 'Mitra' ? new DataTable("#dataTable3") : '';
        },
        async changeRange(){
            console.log('changeRange');
            if(this.form_filter.from_at && this.form_filter.to_at){
                // console.log(this.$moment().format('x'));
                // console.log(this.form_filter.from_at);
                // console.log(this.form_filter.to_at);
                let difference = moment(this.form_filter.to_at).format('x') - moment(this.form_filter.from_at).format('x');
                if(difference>=0){
                    console.log(difference);
                    this.form_filter.type == 'Produk' ? await this.loadProduct() : '';
                }
            }
        },
        viewDataProductFilter(d_date, d_trans){
            var total = 0;
            if (this.data){
                total = _.result(_.find(d_trans, (obj) => {
                    return obj.ordered_at === d_date;
                }), 'ro');
            }
            return total ? total : 0;
        },
        async loadProduct(){
            const data = await this.$axios.$post('/mitra/report/fetch/product',this.form_filter)
            if(data.status == 'success'){
                this.data = data.data
                this.isLoading = false
                this.data.transaction = _.map(this.data.transaction, (o) => {
                    o.ordered_at = this.$moment(o.ordered_at).format("YYYY-MM-DD");
                    return o;
                });
                console.log('==loadProduct==');
                console.log(this.data);
                setTimeout(() => {
                    new DataTable("#dataTable2");
                }, 1500);
            }
        },
        formatRp(angka, prefix = 'Rp ') {
            var number_string = parseInt(angka).toString().replace(/[^,\d]/g, ""),
                split = number_string.split(","),
                sisa = split[0].length % 3,
                rupiah = split[0].substr(0, sisa),
                ribuan = split[0].substr(sisa).match(/\d{3}/gi);

            // tambahkan titik jika yang di input sudah menjadi angka ribuan
            if (ribuan) {
                let separator = sisa ? "." : "";
                rupiah += separator + ribuan.join(".");
            }

            rupiah = split[1] != undefined ? rupiah + "," + split[1] : rupiah;
            return prefix == undefined ? rupiah : rupiah ? "Rp " + rupiah : "";
        },
    },
    computed: {
        productFetch(){
            var product = [];
            var product_data = [];
            let product_price = 0;
            let total = 0;
            if (this.data) {
                this.data.transaction = _.sortBy(this.data.transaction, (o) => {
                    return this.$moment(o.ordered_at)
                });
                for (let index = 0; index < this.data.product.length; index++) {
                    product_data = [];
                    product_price = 0;
                    total = 0;

                    product_data = _.map(this.data.transaction, (o) => {
                        if (o.name == this.data.product[index].name){
                            product_price = o.price;
                            total += o.ro;
                            return {
                                ordered_at: this.$moment(o.ordered_at).format("YYYY-MM-DD"),
                                ro: o.ro
                            };
                        } 
                    });

                    product_data = _(product_data)
                    .groupBy('ordered_at')
                    .map(item => {
                        if(item[0]){
                            return {
                                ordered_at: item[0].ordered_at,
                                ro: _.sumBy(item, 'ro'),
                            }
                        }
                    })
                    .value()

                    product_data = _.without(product_data, undefined);

                    product.push({
                        'name'  : this.data.product[index].name,
                        'unit'  : this.data.product[index].unit,
                        'price' : product_price,
                        'total' : total,
                        'trans' : product_data
                    });
                }

                product = _.map(product, (o) => {
                    _.map(o.trans, (o_trans) => {
                        o_trans.ordered_at = this.$moment(o_trans.ordered_at).format("DD/MM")
                        return o_trans;
                    });
                    return o;
                });

                console.log('==productFetch==');
                console.log(product);
                // console.log(product_data);
                // console.log(this.data.transaction);
            }
            return product
        },
        dateProduct(){
            var date_product = []
            if (this.data){
                date_product = _(this.data.transaction)
                .groupBy('ordered_at')
                .map((item, index)=> {
                    return this.$moment(item[0].ordered_at).format("DD/MM")
                })
                .value()
            }

            console.log('==dateProduct==');
            console.log(date_product);

            return date_product;
        }
    }
}
</script>