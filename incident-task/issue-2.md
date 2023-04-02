# Issue 2

## Evaluation of the severity of the incident

I would start by identifying the number of affected customers. If there are more customers reaching out and reporting the issue, the incident might be critical. The impact of the issue on the customer is also an important factor. If there is any data loss or data corruption occurred because of this issue, it also indicates the severity is critical.

## Incident handling and escalation process

I would follow the below steps to handle the incident:

1. Gathering information from the customer is crucial. I would ask them about the steps they did and if they received any error message on the screen.
2. I would try to reproduce the issue in test or staging environments;
    - If it is reproducible, it may be affecting other customers too. I would trace the logs to catch any errors or exceptions.
    - If it is not reproducible, the issue may be specific to the reaching customer. I would try to trace the logs while the customer is repeating the process and see if any errors or exceptions occur.
3. After checking the logs, following cases might be the cause of the incident;
    - File system or database of the backup destination is full. Add more space to resolve the issue.
    - Replicas of the backup creation feature are not healthy. Check if there are any running pods for the service.
    - HAProxy Ingress controller is not routing the traffic to the correct service or pod. Check if backup creation feature is in fact receiving any requests.
    - A bug in the software is causing the issue. Open a ticket for the development team.
4. To temporarily resolve the issue of the customer, I could manually trigger a backup creation by writing a script and automate it until the problem is fixed.
5. After the issue is resolved, I would provide a report that subjects the root cause of the incident and the actions taken to prevent similar incidents in the future.