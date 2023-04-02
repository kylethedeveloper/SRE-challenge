# Issue 1

## Overview

High load of traffic could have different reasons. In case of such a situation, there has to be actions to take in order. The first thing to do is mitigating the load. This helps to prevent unhappy customers and save time to investigate the issue further. Then, the reason for high load must be determined; either it is legitimate or due to some kind of attack. According to the outcome, necessary actions must be taken. Lastly, an automation and/or alert mechanism should be set up for similar situations in the future.

## Controlling the load

The first thing I would do is **scaling up the pods** to reduce unhandled requests. As we have 2 replicas for HAproxy Ingress deployment, it could be better to increase it to 4. Also, I would check Grafana with the metrics collected to determine which websites (pods) receives the higher traffic and increase the number of pods for these websites.

## Investigating the issue

It is important to separate a false alarm with the actual problem. Detecting a DDoS attack can be challenging, however there are several things that could indicate that the system is under attack. To start investigating, I would use the existing resources such as Grafana and Prometheus. 

- Traffic coming from a single or few sources may point out a DDoS attack. By sorting the IP addresses that make request, it can be determined if the incoming high traffic is from a single IP address, or several IP addresses. If so, it should be noted.
- Unusual traffic sources such as a high number of requests coming from different geographic regions might be an indication of DDoS attack.
- High number of requests coming to non-existing endpoints or a single endpoint could be a signal of DDoS attack. This may be also an indication of websites being scanned.

### Actions to take

After an investigation, it must be decided whether there is a DDoS attack or the load is legitimate. If one of the above scenarios occur, I would take an immediate action to restrict the requests from the determined source of attack. This could be blocking a source of IP addresses or blocking a region using ACLs.

## Automated actions for further cases

It is important to implement automated remediations to prevent similar issues in the future. The actions I would take is in below:

1. Adding an autoscaling feature to the Kubernetes cluster so that when pods reach to a certain percentage of CPU/MEM usage, replica count would increase.
2. HAProxy Ingress controller has a feature to rate limit requests in order to prevent DDoS attacks. By examining the rate of requests in a regular situation from a single source of IP, I would implement this feature with the defined rates.
3. Using Prometheus and Alertmanager, I would implement additional alerts based on rate of incoming requests whether they are from a single source (IP address, geolocation, user-agent). Also, I would add alerts in case of pod numbers reach to a certain number.