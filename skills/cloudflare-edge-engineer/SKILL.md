---
name: cloudflare-edge-engineer
description: Cloudflare edge engineering for DNS, WAF, rate limits, custom rules, API Shield, mTLS, SSL/TLS, Workers, Pages, redirects, caching, bot controls, firewall events, and Terraform-managed Cloudflare resources. Use for Cloudflare 4xx/5xx, 429s, DNS/proxy issues, certificate/mTLS failures, and edge-security rule review.
---

# Cloudflare Edge Engineer

Use this skill for Cloudflare DNS, proxying, WAF/custom rules, rate limiting, API Shield, mTLS, SSL/TLS, redirects, cache behavior, Workers, and edge security troubleshooting.

## Shared Safety Rules

- Prefer read-only inspection before Cloudflare or DNS changes.
- Never print API tokens, client certificates, private keys, origin secrets, mTLS secrets, or sensitive request payloads.
- Ask before DNS, WAF, mTLS, redirect, cache, bot control, Worker, route, or production edge changes.
- Use current Cloudflare docs when behavior, Terraform provider arguments, managed rules, or API behavior may have changed.

## Workflow

1. Identify zone, hostname, environment, path, HTTP status, `cf-ray`, client IP class, time window, and production impact.
2. Inspect local IaC/config first: DNS records, WAF rules, rate limits, mTLS, API Shield schemas, Workers/routes, redirects, and cache rules.
3. Gather read-only live evidence from Cloudflare dashboard/API/logs when available.
4. Separate origin failures from edge policy blocks, DNS/proxy routing, certificate/TLS, cache, bot/rate-limit, and schema validation issues.
5. Recommend the smallest rule/config change and include validation plus rollback.

## Read-Only Checks

Use the relevant subset:

```bash
rg -n "cloudflare|waf|rate|ratelimit|ruleset|api_shield|mtls|dns|record|zone" .
curl -I https://<host>/<path>
dig <host>
```

For Terraform-managed Cloudflare, start with the affected `terragrunt.hcl`, variables, and generated plan. Treat `plan` as read-only but environment-sensitive.

## Require Approval Before

- DNS record or proxy status changes.
- WAF/custom rule/rate limit/API Shield/mTLS changes.
- SSL/TLS mode, certificate, redirect, cache, Worker, route, or bot-control changes.
- Production Terraform apply or state changes.

## Review Focus

Check zone/record ownership, proxied vs DNS-only state, host/path matching, rule order, action precedence, skip rules, characteristics keys, shared egress IPs, API Shield schema match, mTLS certificate bindings, SSL/TLS mode, origin health, cache status, Worker routes, redirect loops, and rollback paths.
