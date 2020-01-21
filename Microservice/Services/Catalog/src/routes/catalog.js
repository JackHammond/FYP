const app = require('express')();

const Products = require('../model/products');

const faker = require('faker');

var bodyParser = require('body-parser');



app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }))


app.get('/', async (req, res) => {
    const product = await Products.find();
    res.json({ products: product });
});

app.get('/delete', async (req, res) => {
    await Products.deleteMany(this.all);
    res.json({ message: 'Deleted all product items' });
});

app.get('/create', async (req, res) => {
    for (let i = 0; i < 50; i++) {
        await Products.create({
            productName: faker.commerce.productName(),
            productColor: faker.commerce.color(),
            productPrice: faker.commerce.price(),
            productDepartment: faker.commerce.department(),
            productRating: "0",

        })
    }
    res.json({ message: '50 Products Created' });
});

app.put('/rating', async (req, res) => {
    await Products.findByIdAndUpdate(
        { _id: req.body._id },
        { productRating: req.body.productRating },
        { new: true },
    )
    res.json({ message: 'Product Rating updated successfully.' })
});

module.exports = app;


