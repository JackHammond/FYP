const app = require('./app');
const { connect } = require('../database');
require('./eureka-helper/eureka-helper').registerWithEureka('basket-service', 4002);



async function main(){

    //database connection
    await connect();
    // Express Application
    await app.listen(4002);
    console.log('Basket Server on port 4002: Connected');
}

main();