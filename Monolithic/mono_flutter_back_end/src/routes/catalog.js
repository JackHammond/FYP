const route = require('express')();
//const route = Router();

const Products = require('../models/products');

const faker = require('faker');

//var express = require('express');
//var app = require('express')();
var bodyParser = require('body-parser');



route.use(bodyParser.json());
route.use(bodyParser.urlencoded({ extended: true }))

route.get('/api/catalog', async (req, res) => {
    const product = await Products.find();
    res.json({ products: product });
});

route.get('/api/catalog/delete', async (req, res) => {
    await Products.deleteMany(this.all);
    res.json({ message: 'deleted all rows' });
});

route.get('/api/catalog/create', async (req, res) => {
    for (let i = 0; i < 5; i++) {
        await Products.create({
            productName: faker.commerce.productName(),
            productColor: faker.commerce.color(),
            productPrice: faker.commerce.price(),
            productDepartment: faker.commerce.department(),
            productRating: "0",

            //TODO: Add product rating
        })
    }
    res.json({ message: '5 Users Created' });
});

route.put('/api/catalog/rating', async (req, res) => {
    await Products.findByIdAndUpdate(
        { _id: req.body._id },
        { productRating: req.body.productRating },
        { new: true },
        console.log(req.body.productRating + " req body...."),
        res.json({ message: 'Product Rating updated successfully.' })
    )
});




module.exports = route;