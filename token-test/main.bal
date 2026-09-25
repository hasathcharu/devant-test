import ballerina/http;
import ballerina/io;

service /general on new http:Listener(8080) {

    resource function get grama/certificate(@http:Header string x\-jwt\-assertion) returns string|error {
        io:println("Assertion: ");
        io:println(x\-jwt\-assertion);
        return "Success";
    }
}
