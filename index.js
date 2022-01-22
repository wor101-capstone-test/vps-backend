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

app.get('/', (request, response) => {
  response.send('<h1>Hello World</h1>')
})

app.get('/api/data', (request, response) => {
  response.send(data)
})



const PORT = 3001
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})