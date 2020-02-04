const app = require('express')();

const Basket = require('../model/baskets');

const faker = require('faker');

const axios = require('axios').default;


var bodyParser = require('body-parser');



app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }))

app.get('/', async (req, res) => {
    const basket = await Basket.find();
    res.json({ baskets: basket });
});

app.get('/deleteall', async (req, res) => {
    await Basket.deleteMany(this.all);
    res.json({ message: 'Deleted whole basket successfully' });
});

app.put('/deleteone', async (req, res) => {
    console.log("reqbodyid: " +req.body._id);
    await Basket.deleteOne({"savedProduct_IDs": req.body._id}, (err) => {
        if(err){
            throw err;
        }else{
            res.json({ message: "Deleted" + req.body._id +" successfully" });
        }
    });
});


app.post('/create', async (req, res) => {
    await Basket.create({
        user_ID: req.body.user_ID,
        savedProduct_IDs: req.body.savedProduct_IDs,
    })
    res.json({ message: 'Basket created successfully' })
});

//snippet used  https://codeburst.io/comparison-of-two-arrays-using-javascript-3251d03877fe
function compare(productAtIndexArr, basketArray) {
    const finalArray = [];
    basketArray.forEach((e1) => productAtIndexArr.forEach((e2) => {
        if (e1 === e2) {
            finalArray.push(e1);
        }
    })
    );
    return finalArray;
}

app.put('/total', async (req, res) => {
    console.log("Req body user_ID: "+req.body.user_ID);
    await Basket.find({ user_ID: req.body.user_ID }).exec(function (e, basketItems) {
        if (e) {
            console.log(e)
        } else {
            var decodedBasket = JSON.parse(basketItems[0].savedProduct_IDs);
            //console.log(addUpBasket(decodedBasket));
            axios.get('http://35.242.134.188:8762/catalog/')
                .then((response) => {
                    var tempTotal = 0.0;
                    for (var i = 0; i < decodedBasket.length; i++) {
                        for (var j = 0; j < response.data["products"].length; j++) {
                            var productData = response.data["products"][j]["_id"];
                            if (productData == decodedBasket[i]) {
                                tempTotal += parseFloat(response.data["products"][i]["productPrice"]);
                            }
                        }
                    }
                    console.log(tempTotal);
                    res.json(tempTotal);
                });
        }
    });

});

app.put('/update', async (req, res) => {
    await Basket.findByIdAndUpdate(
        { _id: req.body._id },
        { savedProduct_IDs: req.body.savedProduct_IDs },
        { new: true },
        console.log(req.body.savedItems + " req body...."),
        res.json({ message: 'Basket updated successfully.' })
    )
});

module.exports = app;
