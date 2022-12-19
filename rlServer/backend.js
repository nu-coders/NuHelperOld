const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore } = require('firebase-admin/firestore');
const serviceAccount = require('./key.json');

initializeApp({
  credential: cert(serviceAccount)
});

const db = getFirestore();


let slots = {
    '830': 1,
    '9': 2,
    '930': 3,
    '10': 4,
    '1030': 5,
    '11': 6,
    '1130': 7,
    '12': 8,
    '1230': 9,
    '13': 10,
    '1330': 11,
    '14': 12,
    '1430': 13,
    '15': 14,
    '1530': 15,
    '16': 16,
    '1630': 17,
    '17': 18,
    '1730': 19,
    '18': 20,
    '1830': 21,
    '19': 22,
    '1930': 23,
    '20': 24,
};

function currentSlot(){
    let currentTime = new Date();
    let hour = currentTime.getHours();
    let minute = currentTime.getMinutes();
    if (!(hour in slots)){
        return 0;
    }
    else if (minute >= 30){ 
        return slots[`${hour}30`]
    }
    return slots[`${hour}`]

}

async function getRoom(room){
    const roomData = db.collection('rooms').doc(`${room}`);
    let doc = await roomData.get();

    if (!doc.exists) {
        return 0;
      } else {
        let day = new Date().getDay();
        let data = doc.data();     
        return data[day][currentSlot()];
      }
}

module.exports = {getRoom};

console.log(currentSlot());

