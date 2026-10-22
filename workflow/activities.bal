// Copyright (c) 2026 WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/lang.runtime;
import ballerina/random;
import ballerina/workflow;

// Activities are stubs for the demo. Each one pauses briefly so the steps
// are easy to follow on the execution timeline.

# Remaining department budget in USD. Requests above this are rejected outright.
configurable decimal departmentBudget = 10000.00;

# Checks that the request names an item, gives a purpose and has a positive amount.
#
# + item - What is being purchased
# + amount - Total cost in USD
# + purpose - Why the purchase is needed
# + return - `Valid` if the request is well-formed, or an error
@workflow:Activity
function validateRequest(string item, decimal amount, string purpose) returns string|error {
    io:println(string `[Validate] ${item}, $${amount}, purpose: ${purpose}`);
    runtime:sleep(1);
    if item.trim() == "" {
        return error("Item must not be empty");
    }
    if purpose.trim() == "" {
        return error("Purpose must not be empty");
    }
    if amount <= 0d {
        return error("Amount must be greater than zero");
    }
    return "Valid";
}

# Checks whether the department still has budget for this purchase.
#
# + employee - Employee raising the request
# + amount - Total cost in USD
# + return - true if the amount fits in the remaining budget
@workflow:Activity
function checkBudget(string employee, decimal amount) returns boolean|error {
    io:println(string `[Budget] ${employee} requested $${amount} (remaining budget $${departmentBudget})`);
    runtime:sleep(1);
    return amount <= departmentBudget;
}

# Places the purchase order with the supplier.
#
# + item - What is being purchased
# + return - The purchase order number, or an error
@workflow:Activity
function placeOrder(string item) returns string|error {
    io:println(string `[Order] Placing order for ${item}`);
    runtime:sleep(1);
    int orderId = check random:createIntInRange(10000, 100000);
    return string `PO-${orderId}`;
}

# Tells the employee what happened to their request.
#
# + employee - Employee to notify
# + message - Outcome to send
# + return - Confirmation, or an error
@workflow:Activity
function notifyRequester(string employee, string message) returns string|error {
    io:println(string `[Notify] To ${employee}: ${message}`);
    runtime:sleep(1);
    return "Sent";
}
