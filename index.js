const express = require('express')
const cors = require('cors')
const app = express()

app.use(cors())


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
  console.log("Data requested")
  response.send(data)
})

const PORT = 3001
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})