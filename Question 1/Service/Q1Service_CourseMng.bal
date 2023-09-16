import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.

# storage of variables

type Lecturer record {|
    readonly int staffNumber;
    *officeN;
    string staffName;
    string title;
    *course;

|};

type officeN record {|
    int officeNumber;

|};

type course record {|
    string courseName;
    string coursseCode;
    string nQFlevel;

|};

table<Lecturer> key(staffNumber) lecturerTable = table [
    {officeNumber: 0, staffNumber: 1, staffName: "John", title: "Lecturer", courseName: "Data Structures and algorithms", coursseCode: "DSA611", nQFlevel: "7"}
    ];

service /lecturers on new http:Listener(9090) {

    resource function post addLecturer(http:Caller caller, @http:Payload Lecturer lecture) returns error? {
        lecturerTable.add(lecture);
        http:Response response = new;
        response.statusCode = 200;
        response.setPayload("user added successfully");

        //after header is sent checks if the client recieved the header
        check caller->respond(response);
    }

    resource function get allLectures(http:Caller caller) returns error? {
        var lecturers = lecturerTable.toArray();
        http:Response response = new;
        response.setJsonPayload(lecturers);
        checkpanic caller->respond(response);
    }

    resource function get lecturersByStaffNumber(http:Caller caller, int staffNumber) returns error? {
        var lecturer = lecturerTable[staffNumber];
        if (lecturer is Lecturer) {
            http:Response response = new;
            response.setJsonPayload(lecturer);
            return caller->respond(response);
        } else {
            http:Response response = new;
            response.statusCode = 404;
            response.setPayload("No lecturer found with staff number " + staffNumber.toString());
            check caller->respond(response);
        }

    }
    resource function put updateLecturer(http:Caller caller, http:Request req, int staffNumber) returns error? {

    }
    resource function delete deleteLecturer(http:Caller caller, http:Request req, int staffNumber) returns error? {
        // Check if the lecturer exists in the table
        if (lecturerTable.hasKey(staffNumber)) {
            // Remove the lecturer from the table
            _ = lecturerTable.remove(staffNumber);

            // Send a success response
            http:Response response = new;
            response.statusCode = 200;
            response.setPayload("Lecturer with staff number " + staffNumber.toString() + " deleted successfully");
            check caller->respond(response);
        } else {
            // Send a not found response
            http:Response response = new;
            response.statusCode = 404;
            response.setPayload("No lecturer found with staff number " + staffNumber.toString());
            check caller->respond(response);
        }
    }

    resource function get getLecturersByCourseCode(http:Caller caller, string courseCode) returns error? {
<<<<<<< Updated upstream
        var filteredLecturers = lecturerTable.filter(function(Lecturer lecturer) returns boolean {
            return lecturer.course.courseCode == courseCode;
        });
=======
        var filteredLecturers = lecturerTable.filter(lecturer => lecturer.coursseCode === courseCode);
>>>>>>> Stashed changes
        if (filteredLecturers.length() > 0) {
            http:Response response = new;
            response.setJsonPayload(filteredLecturers.toJsonString());
            check caller->respond(response);
        } else {
            http:Response response = new;
            response.statusCode = 404;
            response.setPayload("No lecturers found for course code " + courseCode);
            check caller->respond(response);
        }
    }

}
