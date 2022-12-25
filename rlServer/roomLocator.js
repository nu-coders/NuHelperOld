const express = require("express");
const { database } = require("firebase-admin");

const backend = require("./backend.js");

const app = express();
app.use(express.json());

const router = express.Router();
const port = 8080;

router.get("/api", (req, res) => {
  res.send({ NuCoders: "Hello World" });
});

// ok
router.get("/api/getroom/", async (req, res) => {
  // 127.0.0.1:8080/api/getroom/
  let id = req.query.id;
  if (id == null || id == "") {
    res.status(404).json({ error: "Not a room" });
  } else {
    let response = await backend.getRoom(id);
    if (response === 0) {
      res.status(404).json({ error: "Not a room" });
    } else {
      res.send( response );
    }
  }
});

//ok
router.get("/api/getrooms/", async (req, res) => {
  // http://127.0.0.1:8080/api/getrooms/
  let building = req.query.building;
  if (building == null || building == "") {
    res.status(404).json({ error: "Not a building" });
  } else {
    let response = await backend.getRooms(building);
    if (response === 0) {
      res.status(404).json({ error: "Not a building" });
    } else {
      res.send( response );
    }
  }
});

// ok
router.get("/api/roomtable", async (req, res) => {
  // http://127.0.0.1:8080/api/roomtable/
  let id = req.query.id;
  if (id == null || id == "") {
    res.status(404).json({ error: "Not a room" });
  } else {
    let response = await backend.roomTable(id);
    if (response === 0) {
      res.status(404).json({ error: "Not a room" });
    } else {
      res.send( response );
    }
  }
});

// ok
router.get("/api/whatsin", async (req, res) => {
  // http://127.0.0.1:8080/api/whatsin/
  let id = req.query.id;
  if (id == null || id == "") {
    res.status(404).json({ error: "Not a room" });
  } else {
    let response = await backend.whatsin(id);
    if (response === 0) {
      res.status(404).json({ error: "Not a room" });
    } else {
      res.send( response );
    }
  }
});

app.use("/", router);

app.use((req, res) => {
  res.sendStatus(404);
});

app.listen(port, () => {
  console.log("runing server");
});
