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
    const doc = await db.collection('nuask').doc(data.roomId).collection('posts').doc();
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
    const doc = await db.collection('nuask').doc(data.roomId).collection('posts').doc(data.postId);
    await doc.update({
        upvotes: FieldValue.increment(1),
        usersId : FieldValue.arrayUnion(data.userId)
    }).then(() => {
        console.log("Document successfully updated!");
    }).catch((error) => {
        console.error("Error updating document: ", error);
    });
}

const downvote = async function(data){
    const doc = await db.collection('nuask').doc(data.roomId).collection('posts').doc(data.postId);
    await doc.update({
        downvotes: FieldValue.increment(1),
        usersId : FieldValue.arrayUnion(data.userId)
    }).then(() => {
        console.log("Document successfully updated!");
    }).catch((error) => {
        console.error("Error updating document: ", error);
    });
}
module.exports = {upvote, downvote, getRoomPostsByRoomId, getAllRooms, getRoomById, getRoomByCourseId,addPost}