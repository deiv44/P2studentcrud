const mongoose = require("mongoose");

const StudentSchema = new mongoose.Schema(
  {
    Firstname: {
      type: String,
      required: [true, "First name is required"],
    },

    Lastname: {
      type: String,
      required: [true, "Last name is required"],
      default: 0,
    },

    Course: {
      type: String,
      required: [true, "Course is required"],
      default: 0,
    },
    Year: {
      type: String,
      required: [true, "Year  is required"],
      default: 0,
    },
    Enrolled: {
      type: Boolean,
      required: [true, "Enrolled  is required"],
      default: false,
    },
  },
  {
    timestamps: true,
  }
);

const Student = mongoose.model("Student", StudentSchema);

module.exports = Student;