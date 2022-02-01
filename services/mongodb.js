const mongo = require('mongodb')
const MongoClient = mongo.MongoClient
const url = "mongodb://localhost:27017/owlbear"
const dbname = "owlbear"
const collection = "scallets"


const MongoInsertOne = (object) => {
  MongoClient.connect(url, function(err, db) {
    if (err) throw err
    const dbo = db.db(dbname)
    dbo.collection(collection).insertOne(object, function(err, res) {
      if (err) throw err;
      console.log("1 document inserted")
      db.close()
      return res
    })
  })
}
// MongoInsertOne({name: "adventurer"})

const MongoInsertMany = (objects) => {
  MongoClient.connect(url, function(err, db) {
    if (err) throw err
    const dbo = db.db(dbname)
    dbo.collection(collection).insertMany(objects, function(err, res) {
      if (err) throw err
      console.log("Number of documents inserted: " + res.insertedCount)
      db.close()
    })
  })
}
// const scallets = [
//   {name: "frog"},
//   {name: "wolf"},
//   {name: "kobold"},
//   {name: "rock"}
// ]
// MongoInsertMany(scallets)

const MongoFindOne = (params = {}) => {
  MongoClient.connect(url, function(err, db) {
    if (err) throw err
    const dbo = db.db(dbname)
    dbo.collection(collection).findOne(params, function(err, result) {
      if (err) throw err
      console.log(result)
      db.close()
      return result
    })
  })
}
//MongoFindOne({name: "kobold"})

const MongoFindAll = async (query = {}) => {
  let client
  try {
    client = await MongoClient.connect(url)
    const db = client.db(dbname)
    const col = db.collection(collection)
    const docs = await col.find(query).toArray()
    return docs
  } catch (err) {
    console.error(err)
  }
}

const MongoFindSome = (query = {}, proj = {}) => {
  MongoClient.connect(url, function(err, db) {
    if (err) throw err
    const dbo = db.db(dbname)
    dbo.collection(collection).find(query, {projection: proj}).toArray(function(err, result) {
      if (err) throw err
      console.log(result)
      db.close()
      return result
    })
  })
}
//MongoFindSome({}, {_id: 0, name: 1})

const MongoDeleteOne = (query = {}) => {
  MongoClient.connect(url, function(err, db) {
    if (err) throw err
    const dbo = db.db(dbname)
    dbo.collection(collection).deleteOne(query, function(err, obj) {
      if (err) throw err
      console.log("1 document deleted")
      db.close()
      console.log("Poop obj:", obj)
      return obj
    })
  })
}
//MongoDeleteOne({name: "adventurer"})

exports.MongoInsertOne = MongoInsertOne
exports.MongoInsertMany = MongoInsertMany
exports.MongoFindOne = MongoFindOne
exports.MongoFindAll = MongoFindAll
exports.MongoFindSome = MongoFindSome
exports.MongoDeleteOne = MongoDeleteOne
// export { 
//   MongoInsertOne, 
//   MongoInsertMany,
//   MongoFindOne, 
//   MongoFindAll,
//   MongoFindSome,
//   MongoDeleteOne,
// }