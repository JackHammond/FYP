// const { Router } = require('express');
// const route = Router();

// const Users = require('../models/users');

// const faker = require('faker');

// route.get('/api/users', async (req, res) =>{
//     const user = await Users.find();
//     res.json({users: user});
// });

// route.get('/api/users/delete', async (req, res) => {
//     await Users.deleteMany(this.all);
// })

// route.get('/api/users/create', async (req, res) =>{
//     for(let i = 0; i < 5; i++){
//         await Users.create({
//             productName: faker.commerce.productName(),
//             productColor: faker.commerce.color(),
//             productPrice: faker.commerce.color(),
//             productDepartment: faker.commerce.department()
//             //TODO: Add product rating
//         })
//     }
//     res.json({message: '5 Users Created'});
// });
// module.exports = route;