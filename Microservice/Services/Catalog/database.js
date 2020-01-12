const mongoose = require('mongoose');

async function connect(){
    await mongoose.connect('mongodb://localhost/ms-catalog-flutter-db',{
        useNewUrlParser: true, useFindAndModify:false
    });
    console.log('Catalog Database: Connected');
};

module.exports = { connect };
