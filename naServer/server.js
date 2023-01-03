const express = require('express');
const cors = require('cors')

const {getAllRooms, getRoomById, getRoomByCourseId,getRoomPostsByRoomId,addPost, upvote, downvote,createAllRooms} = require('./functions.js');

const PORT = process.env.PORT || 8082;

const app = express();
app.use(express.json());
app.use(cors())

app.get('/getRooms', async(req, res) => {
    res.send(await getAllRooms());
})

app.get('/getRoomById', async(req, res) => {
    res.send(await getRoomById(req.body.roomId));
})

app.get('/getRoomByCourseId', async(req, res) => {
    res.send(await getRoomByCourseId(req.body.courseId));
})
    
app.post('/getRoomPostsByRoomId', async(req, res) => {
    res.send(await getRoomPostsByRoomId(req.body.roomId));
})

app.get('/addPost', async(req, res) => {
    res.send(await addPost(req.body));
})

app.get('/upvote', async(req, res) => {
    res.send(await upvote(req.body));
})

app.get('/downvote', async(req, res) => {
    res.send(await downvote(req.body));
})

app.get('/createAllRooms', async(req, res) => {
    res.send(await createAllRooms());
})
    
app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}...`);
});