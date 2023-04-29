export default () => ({
    print_id: null, // membuat state
    data: null
})


// export const state = () => ({
//     print_id: null, // membuat state
//     data: null
// })
// // getter
// export const getters = {
//     getPrintId (state) {
//         return state.print_id  // getter untuk di panggil oleh commponent atau function untuk mendapatkan data.
//     },
// }
// export const mutations = {
//     setPrintId (state, id) {
//         state.print_id = id // mutation untuk merubah value state
//     },
// }
// export const actions = {
//     async fetch({ state }) {
//       // make request
//       const res = { data: 10 };
//       state.data = res.data;
//       return res.data;
//     }
// }
