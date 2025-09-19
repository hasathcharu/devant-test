import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service /countries on httpDefaultListener {
    resource function get data() returns error|json|http:InternalServerError {
        do {
            json response = check httpClient->get("/countries");
            // log:printInfo(response.toBalString());
            return response;
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
