const app = require('express')();

const Reviews = require('../model/reviews');

const faker = require('faker');

const axios = require('axios').default;

var bodyParser = require('body-parser');

function updateCatalogRating(listItem, rating) {
    axios({
        method: 'put',
        url: 'http://localhost:8762/catalog/rating',
        data: {
            _id: listItem,
            productRating: rating
        }
    });
}


app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }))

app.get('/', async (req, res) => {
    const review = await Reviews.find();
    res.json({ reviews: review });
});

app.put('/average', async (req, res) => {
    const listItem = req.body._id;
    var ratingCount = 0;
    Reviews.find({ product_ID: listItem }, function (err, data) {
        if (err) {
            console.log(err);
            return;
        }
        if (data.length == 0) {
            console.log("No record found")
            return;
        }
        console.log(data.length);
        for (var i = 0; i < data.length; i++) {
            ratingCount += parseInt(data[i].productRating);
        }
        var average = ratingCount / data.length;
        if (isNaN(average)) {
            average = 0.0;
        }
        var avg = fixedPoint(average);

        updateCatalogRating(listItem, avg);
        res.json({ average: avg });
    });


})

function fixedPoint(fixedFloat) {
    return Number.parseFloat(fixedFloat).toFixed(1);
}

app.get('/delete', async (req, res) => {
    await Reviews.deleteMany(this.all);
    res.json({ message: 'Deleted all product reviews' });
});

app.post('/create', async (req, res) => {
    await Reviews.create({
        product_ID: req.body._id,
        productRating: req.body.productRating,
    })
    res.json({ message: 'Review created' })
});

module.exports = app;