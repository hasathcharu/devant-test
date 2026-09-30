import ballerina/http;
import ballerina/io;
import ballerina/jwt;

// JWKS endpoint used to verify the token signature.
configurable string jwksUrl = ?;
// Header carrying the JWT. A "Bearer " prefix is stripped if present.
configurable string tokenHeader = "x-jwt-assertion";
// Optional claim checks. Leave unset to skip.
configurable string? issuer = ();
configurable string[]? audience = ();
configurable decimal clockSkew = 0;

final jwt:ValidatorConfig & readonly validatorConfig = {
    issuer: issuer,
    audience: audience,
    clockSkew: clockSkew,
    signatureConfig: {
        jwksConfig: {url: jwksUrl}
    }
};

service /general on new http:Listener(8080) {

    isolated resource function get grama/certificate(http:Request req) returns string|http:Unauthorized {
        string[] headerNames = req.getHeaderNames();

        io:println("=== All Headers ===");
        foreach string headerName in headerNames {
            string[]|http:HeaderNotFoundError headerValues = req.getHeaders(headerName);
            if headerValues is string[] {
                io:println(headerName, ": ", headerValues);
            }
        }

        io:println("=== Token Validation ===");
        string|http:HeaderNotFoundError headerValue = req.getHeader(tokenHeader);
        if headerValue is http:HeaderNotFoundError {
            io:println("No token found in header: ", tokenHeader);
            return <http:Unauthorized>{body: "Missing token in header: " + tokenHeader};
        }

        string token = headerValue.trim();
        if token.toLowerAscii().startsWith("bearer ") {
            token = token.substring(7).trim();
        }

        jwt:Payload|jwt:Error result = jwt:validate(token, validatorConfig);
        if result is jwt:Error {
            io:println("Token validation failed: ", result.message());
            return <http:Unauthorized>{body: "Invalid token: " + result.message()};
        }

        io:println("Token is valid. Payload: ", result.toString());
        return "Success";
    }
}
