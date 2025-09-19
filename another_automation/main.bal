import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service /hi on httpDefaultListener {
    resource function get greeting() returns error|json|http:InternalServerError {
        do {
            log:printInfo("HI");
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
