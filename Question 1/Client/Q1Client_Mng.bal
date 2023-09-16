import ballerina/io;
import ballerina/http;

http:Client|http:ClientError lecturerClient = new("http://localhost:9090");

public function main() returns error {
    io:println("Welcome to the API client!");
    io:println("Please select an option:");
    io:println("1. Add user");
    io:println("2. Get all users");
    io:println("3. Get user by ID");
    io:println("4. Update user");
    io:println("5. Delete user");

    string option = io:readln("Enter your option: ");

    match option {
        "1" => {addLecturer();}
        "2" => {getAllLectures();}
        "3" => {getLectureById();}
        "4" => {updateLecture();}
        "5" => {deleteLecture();}
        _ => {io:println("Invalid option");}
    }
}
function fromString(string s) returns int|error{}
//function addLecturer() returns error? {
    // Prompt the user for the necessary information
    string staffNumber1 = check io:readln("Enter staff number: ");
    int|error staffNumber = int:fromString(staffNumber1);
    string officeNumber = check io:readln("Enter office number: ");
    string staffName = check io:readln("Enter staff name: ");
    string title = check io:readln("Enter title: ");
    string courseName = check io:readln("Enter course name: ");
    string courseCode = check io:readln("Enter course code: ");
    string nQFlevel = check io:readln("Enter NQF level: ");

    // Construct the lecturer record
    Lecturer lecturer = {
        staffNumber:  check staffNumber,
        officeN: { officeNumber: officeNumber },
        staffName: staffName,
        title: title,
        course: { courseName: courseName, coursseCode: courseCode, nQFlevel: nQFlevel }
    ,courseName: "", coursseCode: "", officeNumber: 0, nQFlevel: ""};

    // Send the request to add the lecturer
    var response = lecturerClient->post("/lecturers/addLecturer", lecturer);

    io:println("Response: ", response);
//}

//function getAllLecturers() returns error? {
    var response = lecturerClient->get("/lecturers/allLectures");
    io:println("Response: ", response);
//}

function getLectureById() {
    // Code for getting a user by ID
}

function updateLecture() {
    // Code for updating a user
}

function deleteLecture() {
    // Code for deleting a user
}
