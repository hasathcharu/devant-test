import ballerina/http;
import ballerina/io;

service / on new http:Listener(9090) {

    resource function get .() returns OutputResponse|http:InternalServerError {
        io:println("Calling endpoint: ", serviceUrl);
        string|http:ClientError response = configApiClient->get("");
        if response is http:ClientError {
            return {
                body: {message: "Failed to call API: " + response.toString()}
            };
        }
        return {output: response};
    }
}
