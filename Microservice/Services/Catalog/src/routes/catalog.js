const route = require('express')();

const Products = require('../model/products');

const faker = require('faker');

var bodyParser = require('body-parser');



route.use(bodyParser.json());
route.use(bodyParser.urlencoded({ extended: true }))

route.get('/api/catalog', async (req, res) => {
    const product = await Products.find();
    res.json({ products: product });
});

route.get('/api/catalog/delete', async (req, res) => {
    await Products.deleteMany(this.all);
    res.json({ message: 'Deleted all items' });
});

route.get('/api/catalog/create', async (req, res) => {
    for (let i = 0; i < 5; i++) {
        await Products.create({
            productName: faker.commerce.productName(),
            productColor: faker.commerce.color(),
            productPrice: faker.commerce.price(),
            productDepartment: faker.commerce.department(),
            productRating: "0",

        })
    }
    res.json({ message: '5 Users Created' });
});

route.put('/api/catalog/rating', async (req, res) => {
    await Products.findByIdAndUpdate(
        { _id: req.body._id },
        { productRating: req.body.productRating },
        { new: true },
        res.json({ message: req.body._id +' Rating updated successfully.' })
    )
});

module.exports = route;


