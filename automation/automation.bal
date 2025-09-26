import ballerina/io;
import ballerina/log;
import ballerina/lang.runtime;

public function main() returns error? {
    do {
        int i = 0;
        while i < 10000 {
            if (i % 2 == 0) {
                io:println("Hello World ", i);   
            } else {
                io:println("This is a very long log message to simulate very long text on the runtime logs view component. Let's see how it behaves with a large character count. I just want to test the UI.", i);
            }
            runtime:sleep(5);
            i += 1;
        }
    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}
