import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get hi(@http:Header string x\-hi) returns error|json|http:InternalServerError {
        do {
            log:printInfo(x\-hi);
            return "You sent: " + x\-hi;

        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
