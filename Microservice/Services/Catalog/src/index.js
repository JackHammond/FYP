const app = require('./app');
const { connect } = require('../database');
const PORT = process.env.PORT || 4000;
const eurekaConnect = require('./eureka-helper/eureka-helper');

async function main() {

    // MongoDB connection
    await connect();
    // Express Application
    await app.listen(PORT, () => {
        console.log('Catalog Server on port 4000: Connected');
    });

    eurekaConnect.registerWithEureka("catalog", PORT);
}

main();
