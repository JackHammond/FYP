const route = require('express')();

const Reviews = require('../model/reviews');

const faker = require('faker');


var bodyParser = require('body-parser');



route.use(bodyParser.json());
route.use(bodyParser.urlencoded({ extended: true }))

route.get('/api/review', async (req, res) => {
    const review = await Reviews.find();
    res.json({ reviews: review });
});

route.get('/api/review/delete', async (req, res) => {
    await Reviews.deleteMany(this.all);
    res.json({ message: 'deleted all rows' });
});

route.post('/api/review/create', async (req, res) => {
    await Reviews.create({
        product_ID: req.body._id,
        productRating: req.body.productRating,
    })
    res.json({ message: 'review created' })
});

module.exports = route;