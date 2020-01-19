const app = require('./app');
const { connect } = require('./database');
const PORT = process.env.PORT || 4001;
const eurekaConnect = require('./eureka-helper/eureka-helper');



async function main(){

    //database connection
    await connect();
    // Express Application
    await app.listen(PORT, () => {
        console.log('Review Server on port 4001: Connected');
    });

    eurekaConnect.registerWithEureka("review", PORT);
}

main();