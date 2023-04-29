export default {
    // pindah ke localStorage
    async fetch({ state,commit,dispatch }) {
      // make request
      if(state.print_id){
        const r = await this.$axios.$get('/mitra/sales/print-nota/'+state.print_id);
        if(r.status == 'success'){
          commit('setData', r.data);
          return true;
        }
      }
    }
}
