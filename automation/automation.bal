import ballerina/io;
import ballerina/log;

public function main() returns error? {
    do {
        io:println("Hello World 1");
        io:println("Hello World 2");
        io:println("Hello World 3");
        io:println("Hello World 4");
        io:println("Hello World 5");
        io:println("Hello World 6");
        io:println("Hello World 7");
        io:println("Hello World 8");
        io:println("Hello World 9");
        io:println("Hello World 10");
        io:println("Hello World 11");
        io:println("Hello World 12");
        io:println("Hello World 13");
        io:println("Hello World 14");
        io:println("Hello World 15");
        io:println("Hello World 16");
        io:println("Hello World 17");
        io:println("Hello World 18");
        io:println("Hello World 19");
        io:println("Hello World 20");
        io:println("Hello World 21");
        io:println("Hello World 22");
        io:println("Hello World 23");
        io:println("Hello World 24");
        io:println("Hello World 25");
        io:println("Hello World 26");
        io:println("Hello World 27");
        io:println("Hello World 28");
        io:println("Hello World 29");
        io:println("Hello World 30");
    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}
