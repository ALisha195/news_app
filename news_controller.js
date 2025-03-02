const axios = require("axios");

const fetchNews = async (req, res) => {
  const query = req.query.q || "India"; // Default query is "India"
  const NEWS_API_KEY = process.env.NEWS_API_KEY || "e203f2b3bbf3497c8dee5387db9f719a";
  const NEWS_API_URL = `https://newsapi.org/v2/everything?q=${query}&apiKey=${NEWS_API_KEY}`;

  try {
    const response = await axios.get(NEWS_API_URL);
    res.status(200).json({ articles: response.data.articles });
  } catch (error) {
    console.error("Error fetching news:", error);
    res.status(500).json({ message: "Failed to fetch news", error: error.message });
  }
};

module.exports = { fetchNews };
