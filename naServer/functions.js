const {db} = require('./firebase.js');
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

module.exports = {getAllRooms, getRoomById, getRoomByCourseId}