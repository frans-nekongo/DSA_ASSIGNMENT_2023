import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.

# storage of variables
type Lecturer record {|
    string title;
    string artist;
    int   staffNumber;
|};

table<Lecturer> key(staffNumber) lecturers = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];


service / on new http:Listener(9090) {

   resource function accessor path() {
    
   }
}
