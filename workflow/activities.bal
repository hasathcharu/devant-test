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
import ballerina/workflow;

# Remaining department budget in USD. Requests predicted to cost more are rejected outright.
configurable decimal departmentBudget = 10000.00;

# Checks whether the department still has budget for this purchase.
#
# + item - What is being purchased
# + predictedCost - Estimated cost in USD
# + return - true if the predicted cost fits in the remaining budget
@workflow:Activity
function checkBudget(string item, decimal predictedCost) returns boolean|error {
    io:println(string `[Budget] ${item}: $${predictedCost} (remaining budget $${departmentBudget})`);
    return predictedCost <= departmentBudget;
}

# Records that Finance approved the purchase. The workflow gates this call behind a
# Finance approval, so it runs only once someone approves.
#
# + employee - Employee raising the request
# + item - What is being purchased
# + predictedCost - Estimated cost in USD
# + purpose - Why the purchase is needed
# + return - Confirmation, or an error
@workflow:Activity
function approvePurchase(string employee, string item, decimal predictedCost, string purpose)
        returns string|error {
    io:println(string `[Approval] Approved ${item} for ${employee} ($${predictedCost}): ${purpose}`);
    return "Approved";
}
