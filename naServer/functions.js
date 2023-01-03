const {db, FieldValue} = require('./firebase.js');
const dayjs = require('dayjs');
const customParseFormat = require('dayjs/plugin/customParseFormat')
dayjs.extend(customParseFormat)
const isBetween = require('dayjs/plugin/isBetween')
dayjs.extend(isBetween)


const getAllRooms = async function(){
    let rooms = [];
    const snapshot = await db.collection('nuask').get();
    snapshot.forEach((doc) => {
    //console.log(doc.id, '=>', doc.data());
    rooms.push(doc.data());
    });
    return rooms;
}

const getRoomById = async function(id){
    const doc = await db.collection('nuask').doc(id).get();
    if (!doc.exists) {
        console.log('No such document!');
    } else {
        return doc.data();
    }
}

const getRoomByCourseId = async function(courseId){
    const doc = await db.collection('nuask').where('courseId','==',courseId).get();
        return doc.docs.map((doc) => doc.data());   
}

const getRoomPostsByRoomId = async function(roomId){
    const doc = await db.collection('nuask').doc(roomId).collection('posts').get();
    return doc.docs.map((doc) => doc.data());
}

const addPost = async function(data){
    let userCourses = [];
    const userRef = await db.collection('users').doc(data.userId);
    const userDoc = await userRef.get();
    if (!userDoc.exists) {
        console.log('No such document!');
    } else {
        const user = userDoc.data();
        
        for(let course of user.table){
            userCourses.push(course.courseId);
        }
    }
    const roomRef = await db.collection('nuask').doc(data.courseId.replace('/',''));
    const roomDoc = await roomRef.get();
    if (!roomDoc.exists) {
        console.log('No such document!');
    } else {
        const room = roomDoc.data();
        if(!userCourses.includes(room.courseId)){
            return "You are not enrolled in this course";
        }
    }
    const doc = await db.collection('nuask').doc(data.courseId.replace('/','')).collection('posts').doc();
    await doc.set({
        roomId: data.roomId,
        postId: doc.id,
        userId: data.userId,
        postContent: data.content,
        timestamp: dayjs().format('YYYY-MM-DD HH:mm'),
        upvotes: 0,
        downvotes: 0,
    }).then(() => {
        console.log("Document successfully written!");
        return doc.id;
    }).catch((error) => {
        console.error("Error writing document: ", error);
    });

}

const upvote = async function(data){
    const doc = await db.collection('nuask').doc(data.courseId.replace('/','')).collection('posts').doc(data.postId);
    await doc.update({
        upvotes: FieldValue.increment(1),
        upvotedUsersId : FieldValue.arrayUnion(data.userId)
    }).then(() => {
        console.log("Document successfully updated!");
    }).catch((error) => {
        console.error("Error updating document: ", error);
    });
}

const downvote = async function(data){
    const doc = await db.collection('nuask').doc(data.courseId.replace('/','')).collection('posts').doc(data.postId);
    await doc.update({
        downvotes: FieldValue.increment(1),
        downVotedUsersId : FieldValue.arrayUnion(data.userId)
    }).then(() => {
        console.log("Document successfully updated!");
    }).catch((error) => {
        console.error("Error updating document: ", error);
    });
}

const createAllRooms = async function(){
    const coursesref = await db.collection('courses').get();
    const courses = coursesref.docs.map((doc) => doc.data());
    for(let course of courses){
        console.log(course.courseId);
        const doc = await db.collection('nuask').doc(course.courseId.replace('/',''));
        console.log(doc.id);
        await doc.set({
            courseId: course.courseId,
            courseName: course.courseName,
        },{merge: true}).then(() => {
            console.log("Document successfully written!");
        }).catch((error) => {
            console.error("Error writing document: ", error);
        });
    }
}

module.exports = {upvote, downvote, getRoomPostsByRoomId, getAllRooms, getRoomById, getRoomByCourseId,addPost, createAllRooms}