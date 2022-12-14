var express = require('express');
var app = express();
const PORT = process.env.PORT || 8080;
const {getAllCourses, getCourseByCourseId, getCourseById, getCourseByName} = require('./index.js');
app.get('/listAllCourses', async(req, res) => {
    
    res.send(await getAllCourses());
})

app.get('/getCourseById', async(req, res) => {
    console.log(req.query.id);    
    res.send(await getCourseByCourseId(req.query.id));
})

app.listen(PORT, function () {
    console.log(`Demo project at: ${PORT}!`); 
});