
const courses = require('./json/courses.json');
// const rooms = require('./json/rooms.json');
const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore} = require('firebase-admin/firestore');

const serviceAccount = require('./key.json');

initializeApp({
  credential: cert(serviceAccount)
});

const db = getFirestore();

async function upload_courses(){
    courses.forEach(async course => {
        // let doc = db.collection('coursesById').doc(course.id.toString());
        let doc = db.collection('courses').doc();
        await doc.set(course);
      });
    }

// async function upload_rooms(){
//   Object.keys(rooms).forEach(async room => {
//     let doc = db.collection('rooms').doc(room);
//     await doc.set(rooms[room]);
//   });
// }


upload_courses().then(()=>{console.log("done uploading courses");});
// upload_rooms().then(()=>{console.log("done uploading Rooms");});
