const express = require("express");

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
  let id = req.body["id"];
  if (id == null || id == "") {
    res.status(404).json({ error: "Not a room" });
  } else {
    let to_return  = await backend.getRoom(id);
    if (to_return === 0){
      res.status(404).json({ error: "Not a room" });
    }else{
      console.log(to_return);
      res.send({ "getroom": to_return });
    }
  }
});

router.get("/api/getrooms/", (req, res) => {
  // http://127.0.0.1:8080/api/getrooms/
  let building = req.body["building"];
  if (building == null || building == "") {
    res.status(404).json({ error: "Not a builing" });
  } else {
    res.send({ "getrooms": building });
  }
});

router.get("/api/roomtable", (req, res) => {
  // http://127.0.0.1:8080/api/roomtable/
  let id = req.body["id"];
  if (id == null || id == "") {
    res.status(404).json({ error: "Not a room" });
  } else {
    res.send({ "roomtable": id });
  }
});

router.get("/api/whatsin", async (req, res) => {
  // http://127.0.0.1:8080/api/whatsin/
  let id = req.body["id"];
  if (id == null || id == "") {
    await res.status(404).json({ error: "Not a room" });
  } else {
    await res.send({ "whatsin": id });
  }
});

app.use("/", router);

app.use((req, res) => {
  res.sendStatus(404);
});

app.listen(port, () => {
  console.log("runing server");
});
