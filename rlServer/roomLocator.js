const express = require("express");
const app = express();
app.use(express.json());
const router = express.Router();
const port = 8080;

router.get("/api", (req, res) => {
  res.send({ NuCoders: "Hello World" });
});
router.get("/api/getroom/", (req, res) => {
  // 127.0.0.1:8080/api/getroom/
  if (req.query.id == null || req.query.id == "") {
    res.status(404).json({ error: "Not a room" });
  } else {
    res.send({ getroom: req.query.id });
  }
});
router.get("/api/getrooms/", (req, res) => {
  // http://127.0.0.1:8080/api/getrooms/
  if (req.query.bu == null || req.query.bu == "") {
    res.status(404).json({ error: "Not a builing" });
  } else {
    res.send({ getroom: req.query.bu });
  }
});
router.get("/api/roomtable", (req, res) => {
  if (req.query.id == null || req.query.id == "") {
    res.status(404).json({ error: "Not a room" });
  } else {
    res.send({ getroom: req.query.id });
  }
});
router.get("/api/whatsin", (req, res) => {
  console.log(req.body["test"]);
  res.send("done");
  // res.send("whatsin");
});

app.use("/", router);

app.use((req, res) => {
  res.sendStatus(404);
});

app.listen(port, () => {
  console.log("runing server");
});
