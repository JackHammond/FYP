const app = require('./app');
const { connect } = require('../database');



async function main(){

    //database connection
    await connect();
    // Express Application
    await app.listen(4000);
    console.log('Catalog Server on port 4000: Connected');
}

main();