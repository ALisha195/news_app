const express = require("express");
const cors = require("cors");
require("dotenv").config();
const newsController = require("./news_controller");
const app = express();
const PORT = process.env.PORT || 5050;

app.use(cors({ origin: "*" }));
app.use(express.json());

// Routes
app.get("/", (req, res) => res.send("Server is running 🚀"));
app.get("/news", newsController.fetchNews);

// Start Server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
