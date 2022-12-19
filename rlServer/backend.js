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

async function getRoom(room) {
  const roomData = db.collection("rooms").doc(`${room}`);
  let doc = await roomData.get();

  if (!doc.exists) {
    return 0;
  } else {
    let day = new Date().getDay();
    let data = doc.data();
    return data[day][currentSlot()];
  }
}

async function getRooms(room) {
  const roomData = db.collection("rooms").doc(`${room}`);
  let doc = await roomData.get();

  if (!doc.exists) {
    return 0;
  } else {
    let day = new Date().getDay();
    let data = doc.data();
    return data[day][currentSlot()];
  }
}

async function whatsin(room) {
  const roomData = db.collection("rooms").doc(`${room}`);
  let doc = await roomData.get();
  if (!doc.exists) {
    return 0;
  } else {
    let day = new Date().getDay();
    let data = doc.data();
    let id = data[day][currentSlot()]["id"];
    if (id === 0) {
      return "free room";
    } else {
      const subjectData = db.collection("coursesById").doc(`${id}`);
      let doc = await subjectData.get();
      let data = doc.data();
      return data;
    }
  }
}

async function roomTable(room) {
  const roomData = db.collection("rooms").doc(`${room}`);
  let doc = await roomData.get();

  if (!doc.exists) {
    return 0;
  } else {
    let day = new Date().getDay();
    let data = doc.data();
    return data[day];
  }
}

async function getRooms(building) {
  const roomData = db.collection("rooms");
  let slot = currentSlot();
  let day = new Date().getDay().toString();
  let result = [];
  if (building === 3) {
    let data = await roomData.get();
    data.forEach((room) => {
      id = room.id;
      room = room.data();
      if (room[day][slot]["status"] === true) {
        result.push(id);
      }
    });
    return result;
  } else if (building === 1) {
    let data = await roomData.where("building", "==", "1").get();
    data.forEach((room) => {
      id = room.id;
      room = room.data();
      if (room[day][slot]["status"] === true) {
        result.push(id);
      }
    });
    return result;
  } else if (building === 2) {
    let data = await roomData.where("building", "==", "2").get();
    data.forEach((room) => {
      id = room.id;
      room = room.data();
      if (room[day][slot]["status"] === true) {
        result.push(id);
      }
    });
    return result;
  } else {
    return "Not a builing";
  }
  let doc = await roomData.get();
}
module.exports = { getRoom, whatsin, roomTable, getRooms };

console.log(currentSlot());
