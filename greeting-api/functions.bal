import ballerina/http;
import ballerina/log;

// Logs every received header, including Authorization, as one log line.
function logRequest(http:Request req) {
    map<string[]> headers = {};
    foreach string name in req.getHeaderNames() {
        string[]|http:HeaderNotFoundError values = req.getHeaders(name);
        if values is string[] {
            headers[name] = values;
        }
    }
    log:printInfo("Received request", method = req.method, path = req.rawPath, headers = headers);
}
