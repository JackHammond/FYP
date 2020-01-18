const app = require('./app');
const { connect } = require('./database');
require('./eureka-helper/eureka-helper').registerWithEureka('review-service', 4001);




async function main(){

    //database connection
    await connect();
    // Express Application
    await app.listen(4001);
    console.log('Review server on port 4001: Connected');
}

main();