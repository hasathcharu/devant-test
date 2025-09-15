import ballerina/io;
import ballerina/log;

public function main() returns error? {
    do {
        io:println("Hello from Another 2 Branch", "Update 2");
    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}
