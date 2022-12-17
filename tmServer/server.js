const express = require('express');
const {getAllCourses, getCourseByCourseId, getCourseById, getCourseByName, getListCoursesByCourseId} = require('./index.js');

const PORT = process.env.PORT || 8080;

const app = express();
app.use(express.json());

app.get('/listAllCourses', async(req, res) => {
    res.send(await getAllCourses());
})

app.get('/getCourseById', async(req, res) => {
    console.log("Req body is %j" , req.body);
    res.send(await getCourseByCourseId(req.query.id));
})

app.get('/getListCoursesByCourseId', async(req, res) => {
    console.log("Req body is %j" , req.body);
    res.send(await getListCoursesByCourseId(req.body.id));
})

app.listen(PORT, function () {
    console.log(`Demo project at: ${PORT}!`); 
});

