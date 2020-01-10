const { Schema , model } = require('mongoose');

const  basketSchema = new Schema({
    user_ID: String,
    savedProduct_IDs: String,
}, {versionKey:false});

module.exports = model('Basket', basketSchema);