const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const app = express()
const db = require('./db/index.js')

app.use(cors())
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const { Pool } = require('pg')

const pool = new Pool({
  host: 'localhost',
  user: 'wor101',
  port: 5432,
  password: "root",
  database: "npc_tracker"
})



app.get('/api/data', cors(), (request, response) => {
  pool
    .connect()
    .then(client => {
      return client
        .query('SELECT * FROM characters')
        .then(res => {
          client.release()
          // console.log(res.rows)
          response.send(res.rows)
        })
        .catch(err => {
          client.release()
          console.log(err.stack)
        })
      })
})

app.post('/api/data/snack', (request, response) => {
  const snackName = request.body.name
  pool.query(`INSERT INTO characters (name) VALUES ('${snackName}');`, (err, res) => {
    if (err) {
      throw err
    }
    console.log(res.command)
    console.log(res)
    console.log(snackName)
  })  
})



const PORT = 3001
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})

app.delete('/api/data/snack/:id', (request, response) => {
  const snackId = request.params.id
  console.log(snackId)
  pool.query(`DELETE FROM characters WHERE id=${snackId}`, (err, res) => {
    if (err) {
      throw err
    } else {
      console.log(res.command)
      response.sendStatus(200)
    }
 })
})