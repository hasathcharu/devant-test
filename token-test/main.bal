import ballerina/http;
import ballerina/io;

service /general on new http:Listener(8080) {

    resource function get grama/certificate(@http:Header string? x\-jwt\-assertion, @http:Header string? Authorization) returns string|error {
        io:println("Assertion: ");
        io:println(x\-jwt\-assertion);
        io:println("Authorization: ");
        io:println(Authorization);
        return "Success";
    }
}
