const route = require('express')();

const Basket = require('../model/baskets');

const faker = require('faker');


var bodyParser = require('body-parser');



route.use(bodyParser.json());
route.use(bodyParser.urlencoded({ extended: true }))

route.get('/', async (req, res) => {
    const basket = await Basket.find();
    res.json({ baskets: basket });
});

route.get('/delete', async (req, res) => {
    await Basket.deleteMany(this.all);
    res.json({ message: 'Deleted basket successfully' });
});

route.post('/create', async (req, res) => {
    await Basket.create({
        user_ID: req.body.user_ID,
        savedProduct_IDs: req.body.savedProduct_IDs,
    })
    res.json({ message: 'Basket created successfully' })
});

route.put('/update', async (req, res) => {
    await Basket.findByIdAndUpdate(
        { _id: req.body._id },
        { savedProduct_IDs: req.body.savedProduct_IDs },
        { new: true },
        console.log(req.body.savedItems + " req body...."),
        res.json({ message: 'Basket updated successfully.' })
    )
});




module.exports = route;