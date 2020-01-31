const mongoose = require('mongoose');

async function connect(){
    await mongoose.connect('mongodb://mongo_review:27017/ms-review-flutter-db',{
        useNewUrlParser: true, useFindAndModify:false
    });
    console.log('Review Database: Connected');
};

module.exports = { connect };
