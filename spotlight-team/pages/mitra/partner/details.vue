<template>
<!-- Content -->
<div class="page-content-wrapper">
    <div class="pt-3"></div>
    <div class="container">
        <!-- Element Heading -->
        <div class="element-heading">
            <h6>Details (nama mitra)</h6>
        </div>
    </div>
    <div class="container mb-2">
        <div class="card">
            <div class="card-body py-3">
                <form action="">
                    <div class="form-group">
                        <label class="form-label">Range Tanggal</label>
                        <input class="form-control" type="text" name="daterange" value="01/01/2018 - 01/15/2018" />
                    </div>
                </form>
            </div>
        </div>
    </div> 
    <div class="container">
        <div class="card">
            <div class="card-body">
                <div class="minimal-tab">
                    <ul class="nav nav-tabs mb-3" id="affanTab2" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="btn active" id="ro-tab" data-bs-toggle="tab" data-bs-target="#ro" type="button" role="tab" aria-controls="ro" aria-selected="true">Ro</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="btn" id="sale-tab" data-bs-toggle="tab" data-bs-target="#sale" type="button" role="tab" aria-controls="sale" aria-selected="false">Sale</button>
                        </li>
                    </ul>
                    <div class="tab-content rounded-lg p-1" id="affanTab2Content">
                        <div class="tab-pane fade table-responsive show active" id="ro" role="tabpanel" aria-labelledby="ro-tab">
                            <table class="table w-100" id="dataTable">
                                <thead>
                                    <tr>
                                        <th rowspan="2">No</th>
                                        <th rowspan="2">Product</th>
                                        <th colspan="31" class="text-center">Tanggal</th>
                                        <th rowspan="2">Total</th>
                                    </tr>
                                    <tr>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                    </tr>
                                </thead>
                                <tbody >
                                    <tr>
                                        <td>1</td>
                                        <td>Soap</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>30</td>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td>1</td>
                                        <td>Soap</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>30</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        <div class="tab-pane fade table-responsive" id="sale" role="tabpanel" aria-labelledby="sale-tab">
                            <table class="table w-100" id="dataTableStock">
                                <thead>
                                    <tr>
                                        <th rowspan="2">No</th>
                                        <th rowspan="2">Product</th>
                                        <th colspan="31" class="text-center">Tanggal</th>
                                        <th rowspan="2">Total</th>
                                    </tr>
                                    <tr>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                        <th>2</th>
                                        <th>3</th>
                                        <th>1</th>
                                    </tr>
                                </thead>
                                <tbody >
                                    <tr>
                                        <td>1</td>
                                        <td>Soap</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>30</td>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td>1</td>
                                        <td>Soap</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>30</td>
                                    </tr>
                                </tfoot>
                            </table>
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
import Loader from '../../../components/Loader';
import Toast from '../../../components/Toast';
export default {
    layout: 'layoutMitra',
    components: {
        Toast,
        Loader
    },
    data() {
        return {
            isLoading: true,
            data : [],
        }
    },
    async mounted() {
    },
    methods: {
    },
    computed: {
    }
}
</script>