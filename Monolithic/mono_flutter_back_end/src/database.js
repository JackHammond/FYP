const mongoose = require('mongoose');

async function connect(){
    await mongoose.connect('mongodb://localhost/mono-flutter-db',{
        useNewUrlParser: true, useFindAndModify:false
    });
    console.log('Database: Connected');
};

module.exports = { connect };
