const { Pool } = require('pg')

const pool = new Pool({
  host: 'localhost',
  user: 'wor101',
  port: 5432,
  password: "root",
  database: "npc_tracker"
})


const getCharacters = async () => {
  let characters
  pool
    .connect()
    .then(client => {
      return client
        .query('SELECT * FROM characters')
        .then(res => {
          client.release()
          console.log(res.rows)
          characters = res.rows
        })
        .catch(err => {
          client.release()
          console.log(err.stack)
        })
      })
  return characters
}

// const getCharacters = () => {
//   pool.query('SELECT * FROM characters', (error, results) => {
//     if (error) {
//       throw error
//     }
//     console.log(results.rows)
//   })
// }

module.exports = {
  getCharacters,
}


