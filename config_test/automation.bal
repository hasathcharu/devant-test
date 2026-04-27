import ballerina/io;
import ballerina/log;

public function main() returns error? {
    do {

        io:println("Configured Value: ", greeting);
        io:println("Configured Value 1: ", greeting2);
        io:println("Configured Value 2: ", greeting3);
        io:println("Configured Value 3: ", greeting4);
    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}
