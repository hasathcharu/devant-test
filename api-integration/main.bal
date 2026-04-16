import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service /countries on httpDefaultListener {
    resource function get data() returns error|json|http:InternalServerError {
        do {
            json response = check httpClient->get("/countries");
            log:printInfo("Response received from the API: " + response.toString());
            return response;
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
