import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get .() returns error|json|http:InternalServerError {
        do {
            log:printInfo("Hello There");
            return "Hello There";
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
