# Purchase Approval Workflow

A durable workflow that approves employee purchase requests, with a Finance approver in the loop for high-value items.

```
validateRequest → checkBudget → (Finance approval if > $500) → placeOrder → notifyRequester
```

| File | Contents |
| --- | --- |
| `workflow.bal` | The `purchaseApproval` workflow |
| `activities.bal` | The steps it calls (demo stubs, about 1 second each) |
| `types.bal` | Request, approval form and result types |

## Configuration

| Name | Default | Meaning |
| --- | --- | --- |
| `approvalThreshold` | `500.00` | Purchases above this need Finance approval |
| `departmentBudget` | `10000.00` | Purchases above this are rejected without review |

## Demo script

Start each run from the Devant console with the input shown.

**1. Auto-approved**: a small purchase goes straight through.

```json
{ "requestId": "PR-1001", "employee": "Jane Doe", "item": "Wireless mouse", "amount": 45.00 }
```

The result is `ORDERED`, with `approvedBy: "Auto-approved"`.

**2. Needs approval**: a high-value purchase pauses for Finance.

```json
{ "requestId": "PR-1002", "employee": "Jane Doe", "item": "MacBook Pro", "amount": 2499.00 }
```

The run waits at the approval step. A task titled *Approve MacBook Pro for Jane Doe ($2499.00)* appears in the inbox for the `Finance` role. Approve it and the run finishes as `ORDERED`, with the approver's name in `approvedBy`. Reject it, or submit with `approved` unticked, and the run finishes as `REJECTED` with the reason.

Optional: while the run is paused, restart the integration. The run is still waiting afterwards, which shows durability.

**3. Over budget**: rejected without anyone being asked.

```json
{ "requestId": "PR-1003", "employee": "Jane Doe", "item": "Company car", "amount": 45000.00 }
```

The result is `REJECTED`, and no task is created.
