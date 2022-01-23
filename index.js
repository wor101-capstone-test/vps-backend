const express = require('express')
const cors = require('cors')
const app = express()
const db = require('./db/index.js')

app.use(cors())


const { Pool } = require('pg')

const pool = new Pool({
  host: 'localhost',
  user: 'wor101',
  port: 5432,
  password: "root",
  database: "npc_tracker"
})


let data = [
  { id: 1,
    name: "Morgar Firebeard", 
    ancestory: "Dwarf",
    class: "Fighter"
  },
  {
    id: 2,
    name: "Barco the Barbarian",
    ancestory: "Human",
    class: "Barbarian"
  },
  {
    id: 3,
    name: "Theondondandolis",
    ancestory: "Human",
    class: "Bard"
  },
  {
    id: 4,
    name: "Professor Tidwick",
    ancestory: "Gnome",
    class: "Rogue"
  }
]


app.get('/api/data', cors(), (request, response) => {
  pool
    .connect()
    .then(client => {
      return client
        .query('SELECT * FROM characters')
        .then(res => {
          client.release()
          console.log(res.rows)
          response.send(res.rows)
        })
        .catch(err => {
          client.release()
          console.log(err.stack)
        })
      })
})

const PORT = 3001
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})