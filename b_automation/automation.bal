import ballerina/io;
import ballerina/log;

public function main() returns error? {
    do {
        io:println("Hello from Another 2 Branch");
    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}
