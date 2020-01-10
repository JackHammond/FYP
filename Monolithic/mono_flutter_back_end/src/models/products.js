const { Schema , model } = require('mongoose');

const  productSchema = new Schema({
    productName: String,
    productColor: String,
    productPrice: String,
    productDepartment: String,
    productRating: String,
}, {versionKey:false});

module.exports = model('Product', productSchema);