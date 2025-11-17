configurable string color = "red";
configurable record {
    string host;
    int port;
    string username;
    string password;
    record {|
        string nestedKey;
        int nestedValue;
    |} nestedRecord;
} demoConfig = ?;

