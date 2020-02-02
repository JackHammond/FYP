const mongoose = require('mongoose');

async function connect(){
    await mongoose.connect('mongodb://mongo-review:27018/ms-review-flutter-db',{
        useNewUrlParser: true, useFindAndModify:false
    });
    console.log('Review Database: Connected');
};

module.exports = { connect };
