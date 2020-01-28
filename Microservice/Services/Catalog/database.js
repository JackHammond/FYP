const mongoose = require('mongoose');

async function connect(){
    await mongoose.connect('mongodb://mongo:27017/ms-catalog-flutter-db',{
        useNewUrlParser: true, useFindAndModify:false
    });
    console.log('Catalog Database: Connected');
};

module.exports = { connect };
