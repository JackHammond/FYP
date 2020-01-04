const express = require('express');
const app = express();
const morgan = require('morgan');
const cors = require('cors');

app.use(morgan('dev'));
app.use(cors());
app.use(require('./routes/catalog'));
app.use(require('./routes/rating'));
app.use(require('./routes/basket'));
//app.use(require('./routes/users'));


module.exports = app;