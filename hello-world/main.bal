import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get .() returns string|http:InternalServerError|error {
        do {
            log:printInfo("Greeting: " + greeting);
            log:printInfo("Greeting2: " + greeting2);
            return "Hello, World V6! Greeting: " + greeting;
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
