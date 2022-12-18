const express = require('express');
const {removeClashes,createTablesNoChecks, coursesUploader, getAllCourses, getCourseByCourseId, getCourseById, getCourseByName, getListCoursesByCourseId, createCourseOptionsList} = require('./index.js');

const PORT = process.env.PORT || 8080;

const app = express();
app.use(express.json());

app.get('/listAllCourses', async(req, res) => {
    res.send(await getAllCourses());
})

app.get('/uploadAll', async(req, res) => {
    res.send(await coursesUploader());
})

app.get('/getCourseById', async(req, res) => {
    console.log("Req body is %j" , req.body);
    res.send(await getCourseByCourseId(req.query.id));
})

app.get('/getListCoursesByCourseId', async(req, res) => {
    console.log("Req body is %j" , req.body);
    try {   
        res.send(await getListCoursesByCourseId(req.body.id));
        
    } catch(e) {
        console.log(e);
        res.sendStatus(500);
    }
})

app.get('/createTable', async(req, res) => {
    console.log("Req body is %j" , req.body);
    try {   
        res.send(await removeClashes(req.body.id));
        
    } catch(e) {
        console.log(e);
        res.sendStatus(500);
    }
})

app.listen(PORT, function () {
    console.log(`Demo project at: ${PORT}!`); 
});

