const { Schema , model } = require('mongoose');

const  reviewSchema = new Schema({
    product_ID: String,
    productRating: String,
}, {versionKey:false});

module.exports = model('Review', reviewSchema);