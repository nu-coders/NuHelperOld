const express = require('express');
const {getAllRooms, getRoomById, getRoomByCourseId} = require('./functions.js');

const PORT = process.env.PORT || 8085;

const app = express();
app.use(express.json());

app.get('/getRooms', async(req, res) => {
    res.send(await getAllRooms());
})

app.get('/getRoomById', async(req, res) => {
    res.send(await getRoomById(req.body.roomId));
})

app.get('/getRoomByCourseId', async(req, res) => {
    res.send(await getRoomByCourseId(req.body.courseId));
 })
    
app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}...`);
});