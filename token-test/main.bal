import ballerina/http;
import ballerina/io;

service /general on new http:Listener(8080) {

    resource function get grama/certificate(http:Request req) returns string|error {
        string[] headerNames = req.getHeaderNames();

        io:println("=== All Headers ===");
        foreach string headerName in headerNames {
            string[]|http:HeaderNotFoundError headerValues = req.getHeaders(headerName);
            if headerValues is string[] {
                io:println(headerName, ": ", headerValues);
            }
        }

        return "Success";
    }
}
