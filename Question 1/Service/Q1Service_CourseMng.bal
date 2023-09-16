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
    // Check if the lecturer already exists in the table
    if (lecturerTable.hasKey(lecture.staffNumber)) {
        // Send a conflict response
        http:Response response = new;
        response.statusCode = 409;
        response.setPayload("Lecturer with staff number " + lecture.staffNumber.toString() + " already exists");
        check caller->respond(response);
        return error("Duplicate entry");
    }

    // Add the lecturer to the table
    error? result = lecturerTable.add(lecture);
    if (result is error) {
        // Send a bad request response
        http:Response response = new;
        response.statusCode = 400;
        response.setPayload("Incorrect add lecturer request.");
        check caller->respond(response);
        return error("Bad request");
    } else {
        http:Response response = new;
        response.statusCode = 200;
        response.setPayload("Lecturer added successfully");
        check caller->respond(response);
        return ();
    }
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
   resource function put updateLecturer(http:Caller caller, http:Request req, @http:Payload Lecturer updatedLecturer) returns error? {
    // Check if the lecturer exists in the table
    if (!lecturerTable.hasKey(updatedLecturer.staffNumber)) {
        // Send a not found response
        http:Response response = new;
        response.statusCode = 404;
        response.setPayload("No lecturer found with staff number " + updatedLecturer.staffNumber.toString());
        check caller->respond(response);
        return error("Lecturer not found");
    }

    // Update the lecturer in the table
    error? result = lecturerTable.put(updatedLecturer);
    if (result is error) {
        // Send a bad request response
        http:Response response = new;
        response.statusCode = 400;
        response.setPayload("Incorrect update lecturer command.");
        check caller->respond(response);
        return error("Bad request");
    } else {
        http:Response response = new;
        response.statusCode = 200;
        response.setPayload("Lecturer updated successfully");
        check caller->respond(response);
        return ();
    }
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
        var filteredLecturers = lecturerTable.filter(lecturer => lecturer.coursseCode === courseCode);
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

    resource function get getLecturersByOffice(http:Caller caller, int officeNumber) returns error? {
        var filteredLecturers = lecturerTable.filter(lecturer => lecturer.officeNumber === officeNumber);
        if (filteredLecturers.length() > 0) {
            http:Response response = new;
            response.setJsonPayload(filteredLecturers.toJsonString());
            check caller->respond(response);
        } else {
            http:Response response = new;
            response.statusCode = 404;
            response.setPayload("No lecturers found for office number " + officeNumber.toString());
            check caller->respond(response);
        }
    }

}

//http:Caller caller: This represents the remote HTTP client that initiated the HTTP request. This is used to send back the HTTP response to the client.
//check caller->respond(response); sends the response to the client. If there is an error when sending the response, the check keyword will cause the function to return the error
//The http:Request type represents an HTTP request received by the service.