import ballerina/http;
import ballerina/io;

//http:Client lecturerClient = check new("http://localhost:9090");

public function main() returns error? {
    http:Client lecturerClient = check new ("http://localhost:9090");

    io:println("Welcome to the API client!");
    io:println("Please select an option:");
    io:println("1. Add user");
    io:println("2. Get all users");
    io:println("3. Get user by ID");
    io:println("4. Update user");
    io:println("5. Delete user");

    string option = io:readln("Enter your option: ");

    match option {
        "1" => {
            error? lecturerResult = addLecturer(lecturerClient);
            if lecturerResult is error {
                io:println("Error adding lecturer");
            }
        }

        "2" => {
            error? allLectures = getAllLectures(lecturerClient);
            if allLectures is error {
                io:println("cannot retrieve lecturers");
            }
        }

        "3" => {
            error? lecturerByStaffNumber = getLecturerByStaffNumber(lecturerClient);
            if lecturerByStaffNumber is error {
                io:println("cannot retrieve lecturer");
            }
        }

        "4" => {
            error? lecturer = updateLecturer(lecturerClient);
            if lecturer is error {
                io:println("cannot update lecturer");
            }
        }

        "5" => {
            error? lecturer = deleteLecturer(lecturerClient);
            if lecturer is error {
                io:println("unable to delete lecturer");
            }
        }

        "6" => {
            error? lecturersByCourseCode = getLecturersByCourseCode(lecturerClient);
            if lecturersByCourseCode is error {
                io:println("cannot retrieve lecturer");
            }
        }

        "7" => {
            error? lecturersByOfficeNumber = getLecturersByOfficeNumber(lecturerClient);
            if lecturersByOfficeNumber is error {

            }
        }
        _ => {
            io:println("Invalid option");
        }
    }
}

function addLecturer(http:Client lecturerClient) returns error? {

    // Prompt the user for the necessary information
    string staffNumber1 = check io:readln("Enter staff number: ");
    int|error staffNumber = int:fromString(staffNumber1);
    string officeNumber1 = check io:readln("Enter office number: ");
    int|error officeNumber = int:fromString(officeNumber1);

    string staffName = check io:readln("Enter staff name: ");
    string title = check io:readln("Enter title: ");
    string courseName = check io:readln("Enter course name: ");
    string courseCode = check io:readln("Enter course code: ");
    string nQFlevel = check io:readln("Enter NQF level: ");

    // Construct the lecturer record
    Lecturer lecturer = {
        staffNumber: check staffNumber,
        officeNumber: check  officeNumber,
        staffName: staffName,
        title: title,
        course: {courseName: courseName, coursseCode: courseCode, nQFlevel: nQFlevel}
    ,
        courseName: "",
        coursseCode: "",
        officeNumber: 0,
        nQFlevel: ""
    };

    // Send the request to add the lecturer
    http:Response|http:Error response = lecturerClient->post("/lecturers/addLecturer", lecturer);

    io:println("Response: ", response);
    return ();
}

function getAllLectures(http:Client lecturerClient) returns error? {
    http:Response|http:Error response = lecturerClient->get("/lecturers/allLectures");
    io:println("Response: ", response);
}

function getLecturerByStaffNumber(http:Client lecturerClient) returns error? {
    string staffNumber = check io:readln("Enter staff number: ");
    http:Response|http:Error response = lecturerClient->get("/lecturers/lecturersByStaffNumber?staffNumber=" + staffNumber);
    io:println("Response: ", response);
}

//function updateLecturer(http:Client lecturerClient) returns error? {
    string staffNumber2 = check io:readln("Enter staff number: ");
    int|error staffNumber = int:fromString(staffNumber2);
    string officeNumber1 = check io:readln("Enter office number: ");
    int|error officeNumber = int:fromString(officeNumber1);
    string staffName = check io:readln("Enter staff name: ");
    string title = check io:readln("Enter title: ");
    string courseName = check io:readln("Enter course name: ");
    string courseCode = check io:readln("Enter course code: ");
    string nQFlevel = check io:readln("Enter NQF level: ");

    Lecturer lecturer = {
        staffNumber: check staffNumber,
        officeN: check officeNumber,
        staffName: staffName,
        title: title,
        course: {courseName: courseName, coursseCode: courseCode, nQFlevel: nQFlevel}
    ,
        courseName: "",
        coursseCode: "",
        officeNumber: 0,
        nQFlevel: ""
    };

    http:Response|http:Error response = lecturerClient->put("/lecturers/updateLecturer", lecturer);
    io:println("Response: ", response);
//}

function deleteLecturer(http:Client lecturerClient) returns error? {
    string staffNumber = check io:readln("Enter staff number: ");
    http:Response|http:Error response = lecturerClient->delete("/lecturers/deleteLecturer?staffNumber=" + staffNumber);
    io:println("Response: ", response);
}

function getLecturersByCourseCode(http:Client lecturerClient) returns error? {
    string courseCode = check io:readln("Enter course code: ");
    http:Response|http:Error response = lecturerClient->get("/lecturers/getLecturersByCourseCode?courseCode=" + courseCode);
    io:println("Response: ", response);
}

function getLecturersByOfficeNumber(http:Client lecturerClient) returns error? {
    string officeNumber = check io:readln("Enter office number: ");
    http:Response|http:Error response = lecturerClient->get("/lecturers/getLecturersByOffice?officeNumber=" + officeNumber);
    io:println("Response: ", response);
}
