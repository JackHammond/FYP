const app = require('./app');
const { connect } = require('../database');
const PORT = process.env.PORT || 4002;
const eurekaConnect = require('./eureka-helper/eureka-helper');

async function main() {

    // MongoDB connection
    await connect();
    // Express Application
    await app.listen(PORT, () => {
        console.log('Basket Server on port 4002: Connected');
    });

    eurekaConnect.registerWithEureka("basket", PORT);
}

main();