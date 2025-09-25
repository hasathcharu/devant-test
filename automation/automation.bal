import ballerina/io;
import ballerina/log;
import ballerina/lang.runtime;

public function main() returns error? {
    do {
        int i = 0;
        while i < 10000 {
            io:println("Hello World ", i);
            runtime:sleep(2);
            i += 1;
        }
    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}
