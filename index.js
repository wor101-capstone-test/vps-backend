const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const app = express()
const db = require('./db/index.js')
const { MongoInsertOne, MongoDeleteOne, MongoFindAll } = require('./services/mongodb')

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
    response.sendStatus(200)
  })  
})

// app.delete('/api/data/snack/:id', (request, response) => {
//   const snackId = request.params.id
//   console.log(snackId)
//   pool.query(`DELETE FROM characters WHERE id=${snackId}`, (err, res) => {
//     if (err) {
//       throw err
//     } else {
//       console.log(res.command)
//       response.sendStatus(200)
//     }
//  })
// })

app.delete('/api/data/snack/:id', (request, response) => {
  const snackId = request.params.id
  console.log("Delete RequestBody: ",request.body)
  pool
    .query(`DELETE FROM characters WHERE id=${snackId}`)
    .then(res => {
      console.log('DELETE from postgreSQL successful')
      response.sendStatus(200)
      try {
        MongoInsertOne(request.body)
      } catch(error) {
        console.error(error)
      }
    })
    .catch(err => console.error('Error executing delete to postgreSQL', err.stack))
})



app.get('/api/data/bowels', (request, response) => {
  console.log('Stomach contents requested!')
  //let contents = []
  
  async function getContents(response) {
    const contents = await MongoFindAll()
    console.log(contents)
    response.send(contents)
  } 
  
  getContents(response)
  //console.log('Contents: ', contents)
  // const getContents = async () = {
  //   contents = await MongoFindAll()
  // }
  //getContents()
  //response.send(contents)
})

app.delete('/api/data/bowels', (request, response) => {
  console.log('Request to poop received!')
  try {
    MongoDeleteOne()
    response.sendStatus(200)
  } catch(error) {
    console.error(error)
  }
})




const PORT = 3001
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})

