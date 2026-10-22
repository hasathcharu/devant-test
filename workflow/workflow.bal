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

# Purchase approval with people in the loop.
#
# 1. Check the predicted cost against the department budget
# 2. A Finance approver approves or rejects the request
# 3. A different Finance buyer makes the purchase and records the vendor and actual amount
#
# The workflow is durable while it waits on people: restarting the worker does not lose the request.
#
# + ctx - Workflow context for calling activities
# + request - The purchase request
# + return - The outcome of the request, or an error
@workflow:Workflow
function purchaseApproval(workflow:Context ctx, PurchaseRequest request) returns PurchaseResult|error {

    // Step 1: Check the department budget
    boolean withinBudget = check ctx->callActivity(checkBudget,
            {"item": request.item, "predictedCost": request.predictedCost});
    if !withinBudget {
        return {
            status: "REJECTED",
            predictedCost: request.predictedCost,
            message: string `${request.item} exceeds the remaining department budget.`
        };
    }

    // Step 2: Finance approves the request
    string|error approval = ctx->callActivity(approvePurchase,
            {
                "employee": request.employee,
                "item": request.item,
                "predictedCost": request.predictedCost,
                "purpose": request.purpose
            },
            approvalPolicy = {
                userRoles: "Finance",
                title: string `Approve ${request.item} for ${request.employee} ($${request.predictedCost})`,
                description: string `${request.employee} wants to buy ${request.item}, predicted to cost `
                    + string `$${request.predictedCost}. Purpose: ${request.purpose}`
            });
    if approval is error {
        if approval is workflow:ReviewRejectedError {
            return {
                status: "REJECTED",
                predictedCost: request.predictedCost,
                message: string `Finance rejected the request: ${approval.detail().feedback ?: "no reason given"}`
            };
        }
        return approval;
    }
    string approvedBy = ctx.lastReviewDecision()?.decidedBy ?: "Finance";

    // Step 3: A different Finance member buys the item and records what was paid
    PurchaseDetails|workflow:HumanTaskError purchase = ctx->awaitHumanTask("purchaseItem",
            {
                employee: request.employee,
                item: request.item,
                predictedCost: request.predictedCost,
                purpose: request.purpose,
                approvedBy
            },
            userRoles = "Finance",
            excludedUsers = approvedBy,
            title = string `Purchase ${request.item} for ${request.employee}`,
            description = string `Approved by ${approvedBy}, predicted to cost $${request.predictedCost}. `
                + "Buy the item, then enter the vendor and the actual amount paid.");
    if purchase is error {
        if purchase is workflow:HumanTaskRejectedError {
            return {
                status: "REJECTED",
                approvedBy,
                predictedCost: request.predictedCost,
                message: string `The purchase was not made: ${purchase.detail().reason}`
            };
        }
        return purchase;
    }

    return {
        status: "PURCHASED",
        approvedBy,
        purchasedBy: ctx.lastHumanTaskCompletion()?.completedBy ?: "Finance",
        vendor: purchase.vendor,
        predictedCost: request.predictedCost,
        actualAmount: purchase.actualAmount,
        message: string `Bought ${request.item} from ${purchase.vendor} for $${purchase.actualAmount}.`
    };
}
