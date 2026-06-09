# Circlee

Circlee is a realtime community platform built to help people find and build meaningful circles around goals, hobbies, passions, and local experiences.

This repository now includes:

- a production-oriented product and systems blueprint
- a Flutter app structure with Riverpod, Hooks, and GoRouter
- a Rust backend workspace with Axum service scaffolds
- PostgreSQL schema and Redis/WebSocket contracts
- deployment and edge routing starter infrastructure

## Repository Map

- [docs/architecture.md](/home/kaleab/Documents/Circlee/docs/architecture.md)
- [docs/design-system.md](/home/kaleab/Documents/Circlee/docs/design-system.md)
- [contracts/realtime-events.md](/home/kaleab/Documents/Circlee/contracts/realtime-events.md)
- [backend/Cargo.toml](/home/kaleab/Documents/Circlee/backend/Cargo.toml)
- [backend/migrations/0001_initial.sql](/home/kaleab/Documents/Circlee/backend/migrations/0001_initial.sql)
- [mobile/README.md](/home/kaleab/Documents/Circlee/mobile/README.md)
- [infra/docker-compose.yml](/home/kaleab/Documents/Circlee/infra/docker-compose.yml)

## Product Principle

Circlee is not optimized for passive scrolling. The core loop is:

1. discover people and circles with strong intent overlap
2. join live conversations, events, and shared plans
3. convert lightweight digital interaction into repeated shared experiences
4. strengthen belonging through memory, presence, and momentum

## Delivery Strategy

The recommended implementation path is:

1. ship as a modular monolith plus dedicated realtime gateway
2. keep product domains isolated in code and data contracts
3. split latency-sensitive or independently scaling domains into services only when traffic justifies it

That gives Circlee the speed of a startup codebase without collapsing under realtime and community-scale load later.
