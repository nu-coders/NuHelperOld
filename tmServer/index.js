const {db} = require('./firebase.js');
const dayjs = require('dayjs');
const courses = require('./courses.json');
const customParseFormat = require('dayjs/plugin/customParseFormat')
dayjs.extend(customParseFormat)
var isBetween = require('dayjs/plugin/isBetween')
dayjs.extend(isBetween)
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

const cartesian =async(a) => a.reduce((a, b) => a.flatMap(d => b.map(e => [d, e].flat())));


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
        //console.log(uniqueSectionNumbers);
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
            //console.log("//////////////////////////");
            //console.log(segmentedCourseByType);
            let courseOption = await cartesian(segmentedCourseByType);
            singleCourseFinal.push(courseOption);
        }
        let singleCourseFinalUnique = [...new Set(singleCourseFinal)];
        let singleCourseFinalUniqueFlattened = singleCourseFinalUnique.flat();
        finalCoursesOutput.push(singleCourseFinalUniqueFlattened);
    }

    return finalCoursesOutput;
}

const createTablesNoChecks = async function(coursesId){
    let coursesOptions = await createCourseOptionsList(coursesId);
    let tablesNoChecks = await cartesian(coursesOptions)
    // console.log(tablesNoChecks.length);
    console.log(dayjs('10:30 AM', 'h:m a').format('h:m'));
    console.log()
    // console.log(dayjs('2019-01-25').format('DD/MM/YYYY'));
    // console.log(dayjs('10:30 AM', 'h:m a').isBetween(dayjs('10:30 AM', 'h:m a'), dayjs('12:30 AM', 'h:m a'), '[]'));

    const startTime = dayjs('10:29 AM', 'HH:mm').subtract(1, 'minute');
    const endTime = dayjs('12:30 AM', 'HH:mm').add(1, 'minute');

    const testTime1 = dayjs('10:30 AM', 'HH:mm');
    console.log(testTime1.isBetween(startTime, endTime, 'minute', '[]'));  // false
    
    for(const course of coursesOptions){
        console.log(course);
    }
    return tablesNoChecks;
}

const removeClashes = async function(coursesId){
    let tableOptions = await createTablesNoChecks(coursesId);
    let cleanTableOptions = [];
    let i=0;
    for(const table of tableOptions){
        let clash = false;
        for(const course of table){
            let courseStartTime = course.schedule[0].startTime;
            let courseendTime = course.schedule[0].endTime;
            let courseDay = course.schedule[0].dayDesc;
            for(const course2 of table){
                let courseStartTime2 = course2.schedule[0].startTime;
                let courseendTime2 = course2.schedule[0].endTime;
                let courseDay2 = course2.schedule[0].dayDesc;
                if(courseDay==CourseDay2){
                   if((courseStartTime <= courseEndTime2)  &&  (courseEndTime >= courseStartTime2)){
                        clash=true;
                    } 
                }
            }
        }
        if(clash==false){
            cleanTableOptions.push(table);
        }
    }
    console.log(i);
}

module.exports = {removeClashes,createTablesNoChecks, coursesUploader, getAllCourses, getCourseByCourseId, getCourseById, getCourseByName, getListCoursesByCourseId, createCourseOptionsList};