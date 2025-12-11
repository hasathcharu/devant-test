import ballerina/io;
import ballerina/lang.runtime;
import ballerina/random;

public function main() returns error? {
    io:println("Starting automation job...");
    io:println("This job will print logs every 3 seconds with random numbers");
    io:println("Press Ctrl+C to stop the job");
    io:println("---------------------------------------------------");

    int logCount = 1;

    // Run indefinitely until manually stopped
    while true {
        // Generate a random number between 1 and 1000
        int randomNumber = check random:createIntInRange(1, 1001);

        // Print log with timestamp-like counter and random number
        io:println(string `[Log #${logCount}] Automation job running`);
        runtime:sleep(3);
        io:println(string `[Log #${logCount}] Processing task with ID: ${randomNumber}`);
        runtime:sleep(3);
        io:println(string `[Log #${logCount}] Status: Active | Generated number: `);
        io:println("---------------------------------------------------");

        // Increment log counter
        logCount += 1;

        // Wait for 3 seconds before next iteration
        runtime:sleep(3);
    }
}
