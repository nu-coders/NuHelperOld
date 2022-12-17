const courses = require("./json/coursesDefault.json");
var fs = require('fs');
var temp = [];
courses.forEach((course) => {
    if (course.schedules !== null) 
    {
        delete course.areFeesApplicable;
        delete course.ceu;
        delete course.defaultCreditType;
        delete course.defaultCreditTypeDesc;
        delete course.description;
        delete course.endDate;
        delete course.eventType;
        delete course.id;
        if (course.instructors !== null) {
            course.instructors.forEach((instructor) => {
                delete instructor.colorFirstLetter;
                delete instructor.firstLetter;
                delete instructor.peopleId;
                delete instructor.percentage;
                delete instructor.personId;
            });
        }
        delete course.instructorsCount;
        delete course.isCartable;
        delete course.isConEd;
        delete course.isOpen;
        delete course.isWaitable;
        delete course.schedulesCount;
        delete course.seatsWaiting;
        delete course.startDate;
        delete course.startLongDate;
        delete course.term;
        delete course.termDesc;
        delete course.termSort;
        delete course.year;
        temp.push(course)
    }

});
let coursesString = JSON.stringify(temp);

fs.writeFile("./json/courses.json",coursesString,'utf-8',()=>{console.log("Filtering is done :)");});