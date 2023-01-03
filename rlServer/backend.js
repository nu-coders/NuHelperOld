const { initializeApp, cert } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const serviceAccount = require("./key.json");
const { setTimeout } = require("timers/promises");

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

let allRooms = {};
let b1Rooms = {};
let b2Rooms = {};
let suggetionsList = [];

function currentSlot() {
  let currentTime = new Date();
  let hour = currentTime.getHours();
  let minute = currentTime.getMinutes();

  if (hour in slots) {
    if (minute >= 30) {
      return slots[`${hour}30`];
    }
    return slots[`${hour}`];
  }

  return 0;
}

function emptyRooms(rooms) {
  let result = {};
  let day = new Date().getDay();
  let slot = currentSlot();
  for (let room in rooms) {
    if (rooms[room][day][slot]["status"] == true) {
      result[room] = rooms[room][day][slot];
    }
  }
  return result;
}

async function getRoom(room) {
  room = room.toLowerCase();
  if (room in allRooms) {
    let slot = currentSlot();
    if (slot != 0) {
      let day = new Date().getDay();
      let data = allRooms[room][day][slot];
      return data;
    }
    return 0;
  }
  return -1;
}

async function roomTable(room) {
  room = room.toLowerCase();
  if (room in allRooms) {
    let slot = currentSlot();
    if (slot != 0) {
      let day = new Date().getDay();
      let data = allRooms[room][day];
      return data;
    }
    return 0;
  }
  return -1;
}

async function roomsSuggestion() {
  return suggetionsList;
}

async function getRooms(building) {
  if (building == 3 || building == 2 || building == 1) {
    let slot = currentSlot();
    if (slot != 0) {
      if (building == 3) {
        return emptyRooms(allRooms);
      } else if (building == 2) {
        return emptyRooms(b2Rooms);
      }
      return emptyRooms(b1Rooms);
    }
    return 0;
  }
  return -1;
}

async function cachingData() {
  const roomsData = await db.collection("rooms").get();
  roomsData.forEach(async (doc) => {
    let room = doc.data();
    let id = doc.id.toLowerCase();

    suggetionsList.push(id);
    allRooms[id] = room;
    if (room.building == "1") {
      b1Rooms[id] = room;
    } else {
      b2Rooms[id] = room;
    }
  });
  console.log("Done Caching Data");
}

async function updateData() {
  let toWait;
  let currentMinute;

  while (true) {
    currentMinute = new Date().getMinutes();
    if (currentMinute < 30) {
      toWait = 30 - currentMinute;
    } else if (currentMinute >= 30) {
      toWait = 60 - currentMinute;
    }
    toWait *= 60000;
    await setTimeout(toWait);
    cachingData();
  }
  
}

module.exports = {
  getRoom,
  roomTable,
  getRooms,
  updateData,
  cachingData,
  roomsSuggestion
};
