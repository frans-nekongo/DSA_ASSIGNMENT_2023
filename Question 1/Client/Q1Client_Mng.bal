import ballerina/http;
import ballerina/io;

//http:Client lecturerClient = check new("http://localhost:9090");

function displayMenuOptions() {
    io:println("Please select an option:");
    io:println("1. Add lecturer");
    io:println("2. Get all lecturers");
    io:println("3. Get lecturer by staffNumber");
    io:println("4. Update lecturer");
    io:println("5. Delete lecturer");
    io:println("6. Get lecturers by course code");
    io:println("7. Get lecturers by office number");
    io:println("0. Exit");

}

public function main() returns error? {
    http:Client lecturerClient = check new ("http://localhost:9090/lecturers");

    io:println("Welcome to the managing staff client!");

    while (true) {
        displayMenuOptions();
        string option = io:readln("Enter your option: ");

        match option {
            "1" => {
                error|http:Response lecturerResult = addLecturer(lecturerClient);
                if lecturerResult is error {
                    io:println("Error adding lecturer");
                }
            }

            "2" => {
                http:Response|error allLectures = getAllLectures(lecturerClient);
                if allLectures is error {
                    io:println("cannot retrieve lecturers");
                }
            }

            "3" => {
                error|http:Response lecturerByStaffNumber = getLecturerByStaffNumber(lecturerClient);
                if lecturerByStaffNumber is error {
                    io:println("cannot retrieve lecturer");
                }
            }

            "4" => {
                error|http:Response lecturer = updateLecturer(lecturerClient);
                if lecturer is error {
                    io:println("cannot update lecturer");
                }
            }

            "5" => {
                error|http:Response lecturer = deleteLecturer(lecturerClient);
                if lecturer is error {
                    io:println("unable to delete lecturer");
                }
            }

            "6" => {
                error|http:Response lecturersByCourseCode = getLecturersByCourseCode(lecturerClient);
                if lecturersByCourseCode is error {
                    io:println("cannot retrieve lecturer");
                }
            }

            "7" => {
                error|http:Response lecturersByOfficeNumber = getLecturersByOfficeNumber(lecturerClient);
                if lecturersByOfficeNumber is error {

                }
            }
            "0" => {
                // Exit the client
                break;
            }
            _ => {
                io:println("Invalid option");
            }
        }
    }
}

function addLecturer(http:Client lecturerClient) returns error|http:Response {

    // Prompt the user for the necessary information
    string staffNumber1 = check io:readln("Enter staff number: ");
    int staffNumber = check int:fromString(staffNumber1);
    string officeNumber1 = check io:readln("Enter office number: ");
    int officeNumber = check int:fromString(officeNumber1);

    string staffName = check io:readln("Enter staff name: ");
    string title = check io:readln("Enter title: ");
    string courseName = check io:readln("Enter course name: ");
    string courseCode = check io:readln("Enter course code: ");
    string nQFlevel = check io:readln("Enter NQF level: ");

    // Construct the lecturer record
    Lecturer lecturer = {
        officeNumber: officeNumber,
        courseName: courseName,
        coursseCode: courseCode,
        nQFlevel: nQFlevel,
        staffName: staffName,
        staffNumber: staffNumber,
        title: title
    };

    // Send the request to add the lecturer
    string resourcePath = string `/addLecturer`;
    http:Request request = new;
    json jsonBody = lecturer.toJson();
    request.setPayload(jsonBody, "application/json");
    http:Response response = check lecturerClient->post(resourcePath, request);
    //io:println(jsonBody);
    io:println("succesfully added lecturer");
    return response;
}

function getAllLectures(http:Client lecturerClient) returns http:Response|error {
    string resourcePath = string `/allLectures`;
    http:Response response = check lecturerClient->get(resourcePath);
    io:println(response.getJsonPayload());
    return response;
}

function getLecturerByStaffNumber(http:Client lecturerClient) returns error|http:Response {

    string staffNumber = io:readln("enter staff number: ");

    string resourcePath = string `/lecturersByStaffNumber`;
    map<anydata> queryParam = {"staffNumber": staffNumber};
    resourcePath = resourcePath + check getPathForQueryParam(queryParam);
    http:Response response = check lecturerClient->get(resourcePath);
    io:println(response.getJsonPayload());
    return response;
}

function updateLecturer(http:Client lecturerClient) returns error|http:Response {

    // Prompt the user for the necessary information
    string staffNumber2 = check io:readln("Enter staff number: ");
    int staffNumber = check int:fromString(staffNumber2);
    string officeNumber1 = check io:readln("Enter office number: ");
    int officeNumber = check int:fromString(officeNumber1);

    string staffName = io:readln("Enter staff name: ");
    string title = check io:readln("Enter title: ");
    string courseName = check io:readln("Enter course name: ");
    string courseCode = check io:readln("Enter course code: ");
    string nQFlevel = check io:readln("Enter NQF level: ");

    // Construct the lecturer record
    Lecturer lecturer = {
        officeNumber: officeNumber,
        courseName: courseName,
        coursseCode: courseCode,
        nQFlevel: nQFlevel,
        staffName: staffName,
        staffNumber: staffNumber,
        title: title
    };

    // Send the request to add the lecturer
    string resourcePath = string `/updateLecturer`;
    http:Request request = new;
    json jsonBody = lecturer.toJson();
    request.setPayload(jsonBody, "application/json");
    http:Response response = check lecturerClient->put(resourcePath, request);
    //io:println(jsonBody);
    io:println("succesfully updated lecturer");
    return response;
}

function deleteLecturer(http:Client lecturerClient) returns error|http:Response {

    string staffNumber = io:readln("enter staff number: ");

    string resourcePath = string `/deleteLecturer`;
    map<anydata> queryParam = {"staffNumber": staffNumber};
    resourcePath = resourcePath + check getPathForQueryParam(queryParam);
    // TODO: Update the request as needed;
    http:Request request = new;
    http:Response response = check lecturerClient->delete(resourcePath, request);
    io:println("succesfully deleted lecturer");
    return response;

}

function getLecturersByCourseCode(http:Client lecturerClient) returns error|http:Response {

    string courseCode = io:readln("Enter course code: ");

    string resourcePath = string `/getLecturersByCourseCode`;
    map<anydata> queryParam = {"courseCode": courseCode};
    resourcePath = resourcePath + check getPathForQueryParam(queryParam);
    http:Response response = check lecturerClient->get(resourcePath);
    io:println(response.getJsonPayload());
    return response;
}

function getLecturersByOfficeNumber(http:Client lecturerClient) returns error|http:Response {
    string officeNumber = io:readln("Enter office number: ");

    string resourcePath = string `/getLecturersByOffice`;
    map<anydata> queryParam = {"officeNumber": officeNumber};
    resourcePath = resourcePath + check getPathForQueryParam(queryParam);
    http:Response response = check lecturerClient->get(resourcePath);
    io:println(response.getJsonPayload());
    return response;
}
