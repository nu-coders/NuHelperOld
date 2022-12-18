const {db} = require('./firebase.js');

const courses = require('./courses.json');
const addDoc  = async function(){
    const docRef = db.collection('courses').doc();

    await docRef.set({
        test: "test",
        id: docRef.id
    })  
} 

const addDocJson  = async function(course){
    const docRef = db.collection('courses').doc();
    let sectionLetter = "";
    let sectionNumber = ""
    sectionNumber = course.section;

    if(course.eventSubType!="Lecture"&&course.courseType!="Thesis"){
        console.log(course.eventSubType);
        sectionLetter = course.section.substring(course.section.length-1,course.section.length);
        sectionNumber = course.section.substring(0,course.section.length-1);
    }
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
        sectionLetter: sectionLetter,
        sectionNumber: sectionNumber,
    }).then(()=>{
        console.log("Uploaded "+ docRef.id);
    })
} 

const coursesUploader = async function(){
    courses.map(async(course)=>{
        await addDocJson(course).then(()=>{
            console.log("Finished Uploading ");
    });

    })
}

const getCourseById = async function(id){
    const course = await db.collection('courses').doc(id).get();
    //console.log(course.id, '=>', course.data());
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
        //console.log(course.id, '=>', course.data());
        courses.push(course.data());
    });    
    return courses;
}

const getCourseByCourseId = async function(courseId){
    let courses = [];
    const snapshot = await db.collection('courses').where('courseId','==',courseId).get();
    snapshot.forEach((course) => {
        //console.log(course.id, '=>', course.data());
        courses.push(course.data());
    });    
    return courses;
}

const getListCoursesByCourseId = async function(coursesId){
    
    
    let allCourses = [];
    for (const courseId of coursesId){
        let courses = [];
        const snapshot = await db.collection('courses').where('courseId','==',courseId).get();
        await snapshot.forEach((course) => {
            courses.push(course.data());
        }); 
        allCourses.push(courses);
    }
    return allCourses;
}


const getListCoursesByCourseIdSegmented = async function(coursesId){
    
    
    let allCourses = [];
    for (const courseId of coursesId){
        let courses = [];
        const snapshot = await db.collection('courses').where('courseId','==',courseId).get();
        await snapshot.forEach((course) => {
            courses.push(course.data());
        }); 
        allCourses.push(courses);
    }
    return allCourses;
}

const createCourseOptionsList = async function(coursesId){
    let coursesList = await getListCoursesByCourseId(coursesId);
    finalCoursesOutput=[];
    //console.log(coursesList);
    for (const course of coursesList){
        let singleCourseFinal = [];
        //Get Number of Sections
        //Looping on a single CourseID list
        let sectionNumbers = [];
        for (const section of course){
            //console.log(section);
            sectionNumbers.push(section.sectionNumber);
        }
        let uniqueSectionNumbers = [...new Set(sectionNumbers)];
        console.log(uniqueSectionNumbers);
        for (const sectionNumber of uniqueSectionNumbers){
            let sectionCourses = [];
            for (const section of course){
                if(section.sectionNumber==sectionNumber){
                    sectionCourses.push(section);
                }
            }
            //console.log(sectionCourses);
            let segmentedCourseByType = [];
            let courseTypes = [];
            for (const section of sectionCourses){
                courseTypes.push(section.courseType);
            }
            let uniqueCourseTypes = [...new Set(courseTypes)];
            //console.log(uniqueCourseTypes);
            for (const courseType of uniqueCourseTypes){
                let courseTypeCourses = [];
                for (const section of sectionCourses){
                    if(section.courseType==courseType){
                        courseTypeCourses.push(section);
                    }
                }
                //console.log(courseTypeCourses);
                segmentedCourseByType.push(courseTypeCourses);
            }
            console.log("//////////////////////////");
            console.log(segmentedCourseByType);
            singleCourseFinal.push(segmentedCourseByType);
        }
        finalCoursesOutput.push(singleCourseFinal);
    }

    return finalCoursesOutput;
}

module.exports = {coursesUploader, getAllCourses, getCourseByCourseId, getCourseById, getCourseByName, getListCoursesByCourseId, createCourseOptionsList};