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

import ballerina/workflow;

# Purchases above this amount (USD) need Finance approval. Lower amounts are auto-approved.
configurable decimal approvalThreshold = 500.00;

# Purchase approval with a human in the loop.
#
# 1. Validate the request
# 2. Reject it if it is over the department budget
# 3. Pause for Finance approval if it is above the approval threshold
# 4. Place the order and notify the employee
#
# The workflow is durable while it waits for approval: restarting the worker does not lose the request.
#
# + ctx - Workflow context for calling activities
# + request - The purchase request
# + return - The outcome of the request, or an error
@workflow:Workflow
function purchaseApproval(workflow:Context ctx, PurchaseRequest request) returns PurchaseResult|error {

    // Step 1: Validate the request
    string _ = check ctx->callActivity(validateRequest,
            {"item": request.item, "amount": request.amount, "purpose": request.purpose});

    // Step 2: Check the department budget
    boolean withinBudget = check ctx->callActivity(checkBudget,
            {"employee": request.employee, "amount": request.amount});
    if !withinBudget {
        string message = string `Your request for ${request.item} exceeds the remaining department budget.`;
        string _ = check ctx->callActivity(notifyRequester, {"employee": request.employee, "message": message});
        return {status: "REJECTED", message};
    }

    // Step 3: Ask Finance to approve high-value purchases
    string approvedBy = "Auto-approved";
    if request.amount > approvalThreshold {
        ApprovalDecision|workflow:HumanTaskError decision = ctx->awaitHumanTask("approvePurchase",
                {
                    employee: request.employee,
                    item: request.item,
                    amount: request.amount,
                    purpose: request.purpose
                },
                userRoles = "Finance",
                title = string `Approve ${request.item} for ${request.employee} ($${request.amount})`,
                description = string `${request.employee} wants to buy ${request.item} for $${request.amount}: ${request.purpose}. `
                    + string `Purchases above $${approvalThreshold} need Finance approval.`);

        // The approver can reject from the inbox, or submit the form with "approved" unticked
        string? rejectionReason = ();
        if decision is workflow:HumanTaskRejectedError {
            rejectionReason = decision.detail().reason;
        } else if decision is workflow:HumanTaskError {
            return decision;
        } else if !decision.approved {
            rejectionReason = decision.reason ?: "no reason given";
        }

        if rejectionReason is string {
            string message = string `Finance rejected your request for ${request.item}: ${rejectionReason}`;
            string _ = check ctx->callActivity(notifyRequester, {"employee": request.employee, "message": message});
            return {status: "REJECTED", message};
        }
        approvedBy = ctx.lastHumanTaskCompletion()?.completedBy ?: "Finance";
    }

    // Step 4: Place the order and let the employee know
    string orderNumber = check ctx->callActivity(placeOrder, {"item": request.item});
    string message = string `Your ${request.item} has been ordered (${orderNumber}).`;
    string _ = check ctx->callActivity(notifyRequester, {"employee": request.employee, "message": message});

    return {status: "ORDERED", approvedBy, orderNumber, message};
}
