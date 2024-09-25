const express = require('express')
const mongoose = require("mongoose");
const studentRoute = require("./routes/studentroutes.js");
const Student = require("./model/student.model.js");
const cors = require('cors'); 
const app = express()

//middleware to use json
app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: false }));

//route
app.use("/api/students", studentRoute);

app.get("/", function (req, res) {
  res.send("Hello World");
});


mongoose.connect("mongodb+srv://kedeleonesup:eTlY02cGZebg9Gv5@backenddb.sogkd.mongodb.net/?retryWrites=true&w=majority&appName=BackendDB")
.then(() => {
    console.log("Connected to database");
    app.listen(3000, () => {
      console.log("App listening on port 3000!");
});
})
.catch(() => {
    console.log("Connection failed");
});