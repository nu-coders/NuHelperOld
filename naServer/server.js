const express = require('express');
const {getAllRooms, getRoomById, getRoomByCourseId,getRoomPostsByRoomId,addPost, upvote, downvote} = require('./functions.js');

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
    
app.get('/getRoomPostsByRoomId', async(req, res) => {
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

app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}...`);
});