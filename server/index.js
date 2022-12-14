const {db} = require('./firebase.js');


const addDoc  = async function(){
    const docRef = db.collection('courses').doc();

    await docRef.set({
        test: "test",
    })  
} 

const addDocJson  = async function(course){
    const docRef = db.collection('courses').doc();

    await docRef.set({
        id : docRef.id,
        credits : course.credits,
        courseId: course.eventId,
        courseName: course.eventName,
        courseType: course.eventSubType,
        instructors: course.instructors,
        maxSeats: course.maximumSeats,
        schedule: course.schedules,
        seatsLeft: course.seatsLeft,
        section: course.section,
        session: course.session,
    })  
} 

const coursesUploader = async function(){
    courses.map(async(course)=>{
        await addDocJson(course).then(()=>{
            console.log("done");
    });

    })
}

const getCourseById = async function(id){
    const course = await db.collection('courses').doc(id).get();
    console.log(course.id, '=>', course.data());
    return course.data();
}

const getAllCourses = async function(){
    let courses = [];
    const snapshot = await db.collection('courses').get();
    snapshot.forEach((doc) => {
    //console.log(doc.id, '=>', doc.data());
    courses.push(doc.data());
    });
    return courses;
}

const getCourseByName = async function(name){
    let courses = [];
    const snapshot = await db.collection('courses').where('courseName','==',name).get();
    snapshot.forEach((course) => {
        console.log(course.id, '=>', course.data());
        courses.push(course.data());
    });    
    return courses;
}

const getCourseByCourseId = async function(courseId){
    let courses = [];
    const snapshot = await db.collection('courses').where('courseId','==',courseId).get();
    snapshot.forEach((course) => {
        console.log(course.id, '=>', course.data());
        courses.push(course.data());
    });    
    return courses;
}

// getCourseById('0171xiS5gMFioa5016wk');
//getAllCourses();
// getCourseByName('Music Appreciation');
// getCourseByCourseId('ARTS105');
//console.log("hrllo");

module.exports = {getAllCourses, getCourseByCourseId, getCourseById, getCourseByName};