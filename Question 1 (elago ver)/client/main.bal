import ballerina/http;
import ballerina/io;

type Lecturer record {|
    readonly int staffNumber;
    string staffName;
    string courseCode?;
    int officeNumber?;
|};

function displayMenuOptions() {
    io:println();
    io:println("Please select an option:");
    io:println("1. Add lecturer");
    io:println("2. Get all lecturers");
    io:println("3. Get lecturer by staffNumber");
    io:println("4. Update lecturer");
    io:println("5. Delete lecturer");
    io:println("6. Get lecturers by course code");
    io:println("7. Get lecturers by office number");
    io:println("0. Exit");
    io:println();
}

public function main() returns error? {
    http:Client lecturerClient = check new ("http://localhost:9090/lecturers");

    io:println("------------------------------------------");
    io:println("Welcome to the managing staff client!");
    io:println("------------------------------------------");
    string option = "";
    boolean run = true;
    while (run) {
        displayMenuOptions();
        option = io:readln("Enter your option: ");

        match option {
            "1" => {
                check addLecturer(lecturerClient);
                break;
            }

            "2" => {
                check allLectures(lecturerClient);
                break;
            }

            "3" => {
                check getLecturerByStaffNumber(lecturerClient);
                break;
            }

            "4" => {
                check updateLecturer(lecturerClient);
                break;
            }

            "5" => {
                check deleteLecturer(lecturerClient);
                break;
            }

            "6" => {
                check getLecturersByCourseCode(lecturerClient);
                break;
            }

            "7" => {
                check getLecturersByOfficeNumber((lecturerClient));
                break;
            }
            "0" => {
                io:println("Closing program. Goodbye!");
                run = false;
            }
            _ => {
                io:println("Invalid option");
            }
        }
    }
}

function addLecturer(http:Client lecturerClient) returns error? {
    if (lecturerClient is http:Client) {
        io:println();

        // 01.a Prompt the user for type safe staffNumber
        string staffNumberString;
        int|error staffNumber = error("");

        staffNumberString = io:readln("Enter staff number: ");
        while (staffNumber is error) {
            staffNumber = int:fromString(staffNumberString);
            if (staffNumber is error ||
            (staffNumberString.length() !== 5)) {
                io:println("ERROR: Invalid entry.");
                io:println();
                staffNumberString = io:readln("Please re-enter staff number: ");
            }
        }

        // 01.b Prompt the user for a name
        string staffName = io:readln("Enter staff name: ");

        // 02 Construct the lecturer record
        Lecturer lecturer = {
        staffNumber: check staffNumber,
        staffName: staffName
        };

        // 03 Send the request to add the lecturer
        string message = check lecturerClient->/addLecturer.post(lecturer);
        io:println();
        io:println(message);

        // 04 Prompt user to go back to the main menu
        io:println("--------------------------");
        string exit = "";
        while (exit != "0") {
            exit = io:readln("Press 0 to go back. ");
        }
        io:print();

        error? mainResult = main();
        if mainResult is error {
            io:println("ERROR: You can't go back.");
        }
    }

}

function allLectures(http:Client lecturerClient) returns error? {
    if (lecturerClient is http:Client) {
        // 01 Retrieve and list all lecturers.
        Lecturer[] lecturers = check lecturerClient->/allLectures;
        foreach Lecturer lecturer in lecturers {
            io:println("     ----------");
            io:println("Lecturer staff number: ", lecturer.staffNumber);
            io:println("Lecturer staff name: ", lecturer.staffName);
            io:println("Lecturer course code: ", lecturer.courseCode);
            io:println("Lecturer office number: ", lecturer.officeNumber);
            
        }

        // 02 Prompt user to go back to the main menu
        io:println("--------------------------");
        string exit = "";
        while (exit != "0") {
            exit = io:readln("Press 0 to go back. ");
        }
        io:print();

        error? mainResult = main();
        if mainResult is error {
            io:println("ERROR: You can't go back.");
        }
    }
}

function getLecturerByStaffNumber(http:Client lecturerClient) returns error? {
    if (lecturerClient is http:Client) {

        // 01.a Prompt the user for type safe staffNumber
        string staffNumberString;
        int|error staffNumber = error("");

        staffNumberString = io:readln("Enter staff number: ");
        while (staffNumber is error) {
            staffNumber = int:fromString(staffNumberString);
            if (staffNumber is error ||
            (staffNumberString.length() !== 5)) {
                io:println("ERROR: Invalid entry.");
                io:println();
                staffNumberString = io:readln("Please re-enter staff number: ");
            }
        }

        // 2. Send the request to retrieve the lecturer by staff number.
        Lecturer|string lecturer = check lecturerClient->/lecturersByStaffNumber(staffNumber = check staffNumber);

        if (lecturer is string) {
            io:println(lecturer);
        } else if (lecturer is Lecturer) {
            io:println("     ----------");
            io:println("Lecturer staff number: ", lecturer.staffNumber);
            io:println("Lecturer staff name: ", lecturer.staffName);
            io:println("Lecturer course code: ", lecturer.courseCode);
            io:println("Lecturer office number: ", lecturer.officeNumber);
        }

        // 02 Prompt user to go back to the main menu
        io:println("--------------------------");
        string exit = "";
        while (exit != "0") {
            exit = io:readln("Press 0 to go back. ");
        }
        io:print();

        error? mainResult = main();
        if mainResult is error {
            io:println("ERROR: You can't go back.");
        }
    }
}

function updateLecturer(http:Client lecturerClient) returns error? {
    if (lecturerClient is http:Client) {

        // 01.a Prompt the user for type safe staffNumber
        string staffNumberString;
        int|error staffNumber = error("");

        staffNumberString = io:readln("Enter staff number: ");
        while (staffNumber is error) {
            staffNumber = int:fromString(staffNumberString);
            if (staffNumber is error ||
            (staffNumberString.length() !== 5)) {
                io:println("ERROR: Invalid entry.");
                io:println();
                staffNumberString = io:readln("Please re-enter staff number: ");
            }
        }
        // 2. Confirm if the staff number exists
        boolean isLecturer = check lecturerClient->/checkLecturer(staffNumber = check staffNumber);

        // 3. If it does continue with the rest of the program
        if (isLecturer) {
            // 01.b Prompt the user for a name
            string staffName = io:readln("Enter staff name: ");

            // 02 Construct the lecturer record
            Lecturer lecturer = {
            staffNumber: check staffNumber,
            staffName: staffName
            };

            // 03 Send the request to add the lecturer
            string message = check lecturerClient->/updateLecturer.put(lecturer);
            io:println();
            io:println(message);
        } else {
            io:println(`ERROR: Lecturer with staff number ${staffNumber} does not exists`);
        }

        // Prompt user to go back to the main menu
        io:println("--------------------------");
        string exit = "";
        while (exit != "0") {
            exit = io:readln("Press 0 to go back. ");
        }
        io:print();

        error? mainResult = main();
        if mainResult is error {
            io:println("ERROR: You can't go back.");
        }

    }
}

function deleteLecturer(http:Client lecturerClient) returns error? {
    if (lecturerClient is http:Client) {

        // 01.a Prompt the user for type safe staffNumber
        string staffNumberString;
        int|error staffNumber = error("");

        staffNumberString = io:readln("Enter staff number: ");
        while (staffNumber is error) {
            staffNumber = int:fromString(staffNumberString);
            if (staffNumber is error ||
            (staffNumberString.length() !== 5)) {
                io:println("ERROR: Invalid entry.");
                io:println();
                staffNumberString = io:readln("Please re-enter staff number: ");
            }
        }
        // 2. Confirm if the staff number exists
        boolean isLecturer = check lecturerClient->/checkLecturer(staffNumber = check staffNumber);

        // 3. If it does continue with the rest of the program
        if (isLecturer) {
            // 03 Send the request to add the lecturer
            string message = check lecturerClient->/deleteLecturer.delete(staffNumber = check staffNumber);
            io:println();
            io:println(message);
        } else {
            io:println(`ERROR: Lecturer with staff number ${staffNumber} does not exists`);
        }

        // Prompt user to go back to the main menu
        io:println("--------------------------");
        string exit = "";
        while (exit != "0") {
            exit = io:readln("Press 0 to go back. ");
        }
        io:print();

        error? mainResult = main();
        if mainResult is error {
            io:println("ERROR: You can't go back.");
        }

    }
}

function getLecturersByCourseCode(http:Client lecturerClient) returns error? {
    if (lecturerClient is http:Client) {
        // 01 Prompt user for course code.
        string courseCode = io:readln("Enter course code: ");

        // 02 Retrieve and list all lecturers.
        Lecturer[] lecturers = check lecturerClient->/getLecturersByCourseCode(courseCode = courseCode);
        if (lecturers.length() < 1) {
            io:println("No lecturers found.");
        } else {
            foreach Lecturer item in lecturers {
                io:println("     ----------");
                io:println("Lecturer staff number: ", item.staffNumber);
                io:println("Lecturer staff name: ", item.staffName);
                io:println("Lecturer course code: ", item.courseCode);
                io:println("Lecturer office number: ", item.officeNumber);
            }
        }

        // 02 Prompt user to go back to the main menu
        io:println("--------------------------");
        string exit = "";
        while (exit != "0") {
            exit = io:readln("Press 0 to go back. ");
        }
        io:print();

        error? mainResult = main();
        if mainResult is error {
            io:println("ERROR: You can't go back.");
        }
    }
}

function getLecturersByOfficeNumber(http:Client lecturerClient) returns error? {
    if (lecturerClient is http:Client) {
        // 01.a Prompt the user for type safe officeNumber
        string officeNumberString;
        int|error officeNumber = error("");

        officeNumberString = io:readln("Enter office number: ");
        while (officeNumber is error) {
            officeNumber = int:fromString(officeNumberString);
            if (officeNumber is error ||
            (officeNumberString.length() !== 3)) {
                io:println("ERROR: Invalid entry.");
                io:println();
                officeNumberString = io:readln("Please re-enter office number: ");
            }
        }

        // 02 Retrieve and list all lecturers.
        Lecturer[] lecturers = check lecturerClient->/getLecturersByOffice(officeNumber = check officeNumber);
        if (lecturers.length() < 1) {
            io:println("No lecturers found.");
        } else {
            foreach Lecturer item in lecturers {
                io:println("     ----------");
                io:println("Lecturer staff number: ", item.staffNumber);
                io:println("Lecturer staff name: ", item.staffName);
                io:println("Lecturer course code: ", item.courseCode);
                io:println("Lecturer office number: ", item.officeNumber);
            }
        }

        // 02 Prompt user to go back to the main menu
        io:println("--------------------------");
        string exit = "";
        while (exit != "0") {
            exit = io:readln("Press 0 to go back. ");
        }
        io:print();

        error? mainResult = main();
        if mainResult is error {
            io:println("ERROR: You can't go back.");
        }
    }
}
