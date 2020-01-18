const app = require('./app');
const { connect } = require('../database');

require('./eureka-helper/eureka-helper').registerWithEureka('catalog-service', 4000);


async function main(){

    //database connection
    await connect();
    // Express Application
    await app.listen(4000);
    console.log('Catalog Server on port 4000: Connected');
}

main();