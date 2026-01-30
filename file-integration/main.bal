import ballerina/ftp;
import ballerina/log;

listener ftp:Listener weatherListener = new (host = host, auth = {credentials: {username: username, password: password}}, path = path, fileNamePattern = pattern);

service ftp:Service on weatherListener {
    remote function onFileChange(ftp:WatchEvent & readonly event, ftp:Caller caller) returns error? {
        do {
            foreach var addFile in event.addedFiles {
                log:printInfo("File added:" + addFile.name);
                log:printInfo("Random Output");
            }
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
