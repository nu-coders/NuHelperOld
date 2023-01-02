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

function currentSlot() {
  let currentTime = new Date();
  let hour = currentTime.getHours();
  let minute = currentTime.getMinutes();

  // if (!(hour in slots)) {
  //   return 0;
  // } else if (minute >= 30) {
  //   return slots[`${hour}30`];
  // }
  // return slots[`${hour}`];

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
  for (let room in rooms){
    if (rooms[room][day][slot]["status"] == true) {
      result[room] = rooms[room][day][slot];
    }
  }
  return result;
}

async function getRoom(room) {
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

  // if (slot == 0) {
  //   if (building == 3) {
  //     let data = await roomData.get();
  //     result = toArray(data);
  //   } else if (building == 1 || building == 2) {
  //     let data = await roomData.where("building", "==", `${building}`).get();
  //     result = toArray(data);
  //   }
  // } else if (building == 3) {
  //   let data = await roomData.where(`${day}.${slot}.status`, "==", true).get();
  //   result = toArray(data);
  // } else if (building == 1 || building == 2) {
  //   let data = await roomData
  //     .where("building", "==", `${building}`)
  //     .where(`${day}.${slot}.status`, "==", true)
  //     .get();
  //   result = toArray(data);
  // } else {
  //   return 0;
  // }
  // return result;
}

async function cachingData() {
  const roomsData = await db.collection("rooms").get();
  roomsData.forEach(async (doc) => {
    let room = doc.data();
    allRooms[doc.id] = room;
    if (room.building == "1") {
      b1Rooms[doc.id.toLowerCase()] = room;
    } else {
      b2Rooms[doc.id.toLowerCase()] = room;
    }
  });
  console.log("Done Caching Data");
}

async function updateData() {
  let toWait;
  let currentMinute;

  while (true) {
    currentMinute = new Date().minute();
    if (currentMinute < 30) {
      toWait = 30 - currentMinute;
    } else if (currentMinute >= 30) {
      toWait = 60 - currentMinute;
    }
    await setTimeout(toWait * 60 * 1000);
    cachingData();
  }
}
module.exports = {
  getRoom,
  // whatsin,
  roomTable,
  getRooms,
  updateData,
  cachingData,
};
// cachingData();