const route = require('express')();

const Basket = require('../model/baskets');

const faker = require('faker');


var bodyParser = require('body-parser');



route.use(bodyParser.json());
route.use(bodyParser.urlencoded({ extended: true }))

route.get('/api/basket', async (req, res) => {
    const basket = await Basket.find();
    res.json({ baskets: basket });
});

route.get('/api/basket/delete', async (req, res) => {
    await Basket.deleteMany(this.all);
    res.json({ message: 'deleted all rows' });
});

route.post('/api/basket/create', async (req, res) => {
    await Basket.create({
        user_ID: req.body.user_ID,//TODO
        savedProduct_IDs: req.body.savedProduct_IDs ,//TODO
    })
    res.json({ message: 'Basket created' })
});
//Do a put first when a user adds to basket, if an error is returned then post instead the same data.
route.put('/api/basket/update', async (req, res) => {
    await Basket.findByIdAndUpdate(
        { _id: req.body._id}, // check the _id 
        { savedProduct_IDs: req.body.savedProduct_IDs },
        { new: true },
        console.log(req.body.savedItems + " req body...."),
        res.json({ message: 'Basket updated successfully.' })
    )
});




module.exports = route;