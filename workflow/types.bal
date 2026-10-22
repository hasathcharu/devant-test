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

# A purchase request raised by an employee.
#
# + employee - Name of the employee raising the request
# + item - What is being purchased
# + amount - Total cost in USD
# + purpose - Why the purchase is needed, shown to the approver
type PurchaseRequest record {|
    string employee;
    string item;
    decimal amount;
    string purpose;
|};

# Decision submitted by a Finance approver from the task inbox.
#
# + approved - Approve (true) or reject (false) the purchase
# + reason - Optional note explaining the decision
type ApprovalDecision record {|
    boolean approved;
    string reason?;
|};

# Final outcome of a purchase request.
#
# + status - `ORDERED` if the purchase went ahead, `REJECTED` otherwise
# + approvedBy - Who approved the purchase: the Finance approver, or `Auto-approved`
# + orderNumber - Purchase order number, present only when the item was ordered
# + message - Human-readable summary of the outcome
type PurchaseResult record {|
    "ORDERED"|"REJECTED" status;
    string approvedBy?;
    string orderNumber?;
    string message;
|};
