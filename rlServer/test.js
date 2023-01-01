const rooms = require("./rooms.json");
// console.log(j);
let b1 = {};
let b2 = {};

// all.forEach((room) => {
//   if (room.building == "1"){
//     console.log(room);
//   }
// });
for(let roomid in rooms){
  if (rooms[roomid].building == '1'){
    b1[roomid] = rooms[roomid];
  } 
  else{
    b2[roomid] = rooms[roomid];
  }

}
