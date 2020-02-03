const mongoose = require('mongoose');

async function connect(){
    await mongoose.connect('mongodb://mongo-basket:27019/ms-basket-flutter-db',{
        useNewUrlParser: true, useFindAndModify:false
    });
    console.log('Basket Database: Connected');
};

module.exports = { connect };
