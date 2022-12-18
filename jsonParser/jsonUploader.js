// const courses = require("./json/courses.json");

// let sql = false;
// let csv = false;

// let sqlOutput = "";
// let csvOutput = "";
// courses.forEach((course) => {
//     if (course.schedules !== null) {
//         let credit = course.credits;
//         let code = course.eventId;
//         let name = course.eventName;
//         let subType = course.eventSubType;
//     }

//     // console.log(`credit = ${course.credits} code = ${course.eventId} name = ${course.eventName} subjectType = ${course.eventSubType} `);
// });
const courses = require('./json/courses_.json');
const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore} = require('firebase-admin/firestore');

const serviceAccount = require('./key.json');

initializeApp({
  credential: cert(serviceAccount)
});

const db = getFirestore();

// let flag = false;
// courses.forEach(course => { 
//   course.schedules.forEach(time => {
//     if (!time.startTime.includes("30")){
//       if(course.session == '01')
//         console.log(course);
//     }
//   });
// });

async function upload_courses(){
    courses.forEach(async course => {
        // let id = course.id;
        // console.log(course.id.toString());
        let doc = db.collection('bahaaaaaaaa').doc(course.id.toString());
        await doc.set(course);
      });
    }
console.log("done");
upload_courses();
