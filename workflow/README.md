# Purchase Approval Workflow

A durable workflow for employee purchase requests: a budget check, then a Finance approval, then a Finance buyer makes the purchase.

```
checkBudget → approvePurchase (Finance approval) → purchaseItem (Finance task: vendor and actual amount)
```

| File | Contents |
| --- | --- |
| `workflow.bal` | The `purchaseApproval` workflow |
| `activities.bal` | `checkBudget`, and `approvePurchase`, which runs only once Finance approves |
| `types.bal` | Request, purchase form and result types |

## Configuration

| Name | Default | Meaning |
| --- | --- | --- |
| `departmentBudget` | `10000.00` | Requests predicted to cost more than this are rejected without review |

## Demo script

Start each run from the Devant console. You need two users with the `Finance` role, because the person who approves a request can't also buy it.

**1. Approve and buy**

```json
{ "employee": "Jane Doe", "item": "MacBook Pro", "predictedCost": 2499.00, "purpose": "Laptop for the new iOS developer joining next week" }
```

1. The run passes the budget check and waits for approval. An approval titled *Approve MacBook Pro for Jane Doe ($2499.00)* appears for `Finance`.
2. Finance user A approves it.
3. A task titled *Purchase MacBook Pro for Jane Doe* appears for `Finance`, but not for user A.
4. Finance user B enters the vendor and the actual amount, e.g. `Apple Store` and `2399.00`.

The result is `PURCHASED`, showing who approved, who bought it, the vendor, and the predicted and actual amounts.

Optional: while the run is waiting on a person, restart the integration. The run is still waiting afterwards, which shows durability.

**2. Rejected by Finance**: start the same input and reject it at the approval step. The result is `REJECTED`, with the approver's feedback.

**3. Over budget**: rejected without anyone being asked.

```json
{ "employee": "Jane Doe", "item": "Company car", "predictedCost": 45000.00, "purpose": "Client visits" }
```
