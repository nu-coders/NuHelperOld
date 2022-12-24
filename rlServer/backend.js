const e = require("express");
const { initializeApp, cert } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const serviceAccount = require("./key.json");

initializeApp({
  credential: cert(serviceAccount),
});

const db = getFirestore();

let slots = {
  830: 1,
  9: 2,
  930: 3,
  10: 4,
  1030: 5,
  11: 6,
  1130: 7,
  12: 8,
  1230: 9,
  13: 10,
  1330: 11,
  14: 12,
  1430: 13,
  15: 14,
  1530: 15,
  16: 16,
  1630: 17,
  17: 18,
  1730: 19,
  18: 20,
  1830: 21,
  19: 22,
  1930: 23,
  20: 24,
};

function currentSlot() {
  let currentTime = new Date();
  let hour = currentTime.getHours();
  let minute = currentTime.getMinutes();

  if (!(hour in slots)) {
    return 0;
  } else if (minute >= 30) {
    return slots[`${hour}30`];
  }
  return slots[`${hour}`];
}

function toArray(rooms){
  let result = [];
  rooms.forEach((room) => {
    result.push(room.id)
  });
  return result;
}

async function getRoom(room) {
  const roomData = db.collection("rooms").doc(`${room}`);
  let doc = await roomData.get();
  let slot = currentSlot();

  if (!doc.exists) {
    return 0;
  } else if(slot == 0){
    return {course: 0,status: true,type: 0,'E/V': 'The room is vacant until the end of today :)',section: 0};
  } else {
    let day = new Date().getDay();
    let data = doc.data()[day][slot];
    return data;
  }
}

async function whatsin(room) {
  const roomData = db.collection("rooms").doc(`${room}`);
  let doc = await roomData.get();
  let slot = currentSlot();

  if (!doc.exists) {
    return 0;
  } else if(slot == 0){
    return "Free Room";
  } else {
    let day = new Date().getDay();
    let data = doc.data()[day][slot];
    let status = data["status"];
    if (status === true) {
      return "Free Room";
    } 
    delete data.status;
    return data;
  }
}

async function roomTable(room) {
  const roomData = db.collection("rooms").doc(`${room}`);
  let doc = await roomData.get();

  if (!doc.exists) {
    return 0;
  } else {
    let day = new Date().getDay();
    let data = doc.data()[day];
    return data;
  }
}

async function getRooms(building) {
  const roomData = db.collection("rooms");
  let day = new Date().getDay();
  let slot = currentSlot();
  let result = [];
  if (slot == 0){
    if (building == 3){
      let data = await roomData.get();
      result = toArray(data);
    }else if (building === 1 || building === 2) {
      let data = await roomData.where("building", "==", `${building}`).get();
      result = toArray(data);
    }
  }else if (building === 3) {
    let data = await roomData.where(`${day}.${slot}.status`, "==", true).get();
    result = toArray(data);
  } else if (building === 1 || building === 2) {
    let data = await roomData.where("building", "==", `${building}`).where(`${day}.${slot}.status`, "==", true).get();
    result = toArray(data);    
  } else {
    return 0;
  }
  return result;
}

module.exports = { getRoom, whatsin, roomTable, getRooms };