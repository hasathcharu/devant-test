import ballerina/http;

final http:Client configApiClient = check new (serviceUrl);
