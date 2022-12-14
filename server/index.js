// const {db} = require('./firebase');

// console.log(db);
const { initializeApp, applicationDefault, cert } = require('firebase-admin/app');
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');

const serviceAccount = require('./servicekey.json');
const courses = require('./courses.json');


initializeApp({
  credential: cert(serviceAccount)
});

const db = getFirestore();

module.exports = db;

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

const getDoc = async function(id){
    const course = await db.collection('courses').doc(id).get();
    console.log(course.id, '=>', course.data());
    return course.data();
}

const getAllCourses = async function(){
    let courses = [];
    const snapshot = await db.collection('courses').get();
    snapshot.forEach((doc) => {
    console.log(doc.id, '=>', doc.data());
    courses.push(doc.data());
    });
    return courses;
}

// getDoc('0171xiS5gMFioa5016wk');
getAllCourses();

