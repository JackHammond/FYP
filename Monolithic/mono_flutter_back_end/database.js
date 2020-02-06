const mongoose = require('mongoose');

async function connect(){
    await mongoose.connect('mongodb://localhost:27017/mono-flutter-db',{
        useNewUrlParser: true, useFindAndModify:false
    });
    console.log('Database: Connected');
};

module.exports = { connect };