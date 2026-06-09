# Circlee Architecture

## 1. Product Architecture

Circlee is organized around five product loops:

1. `Identity Loop`: onboarding, profile, interests, intent, social energy, campus/local presence
2. `Belonging Loop`: circles, circle feed, membership, moderation, shared streaks, highlights
3. `Action Loop`: events, hangouts, RSVPs, reminders, collaborative planning
4. `Conversation Loop`: DMs, group chat, circle chat, reactions, replies, live rooms
5. `Growth Loop`: discovery, recommendations, friend-of-friend expansion, seasonal communities

The system should optimize for:

- fast access to the user's active circles and current plans
- realtime fanout without making every request websocket-dependent
- safe offline-first mutation queues for low-connectivity environments
- durable community state in PostgreSQL and ephemeral fanout state in Redis

## 2. Topology

```text
Flutter App
  |-- HTTPS REST --------------------------> API Gateway (Axum)
  |-- WebSocket ---------------------------> Realtime Gateway (Axum)
  |-- Signed Upload -----------------------> Cloudflare R2
  |-- WebRTC ------------------------------> LiveKit SFU Cluster

API Gateway
  |-- PostgreSQL --------------------------> primary relational store
  |-- Redis -------------------------------> presence, pub/sub, cache, rate limits
  |-- Redis Streams -----------------------> async domain jobs
  |-- Internal gRPC/HTTP ------------------> discovery, media, notifications workers

Realtime Gateway
  |-- Redis Pub/Sub -----------------------> fanout channels
  |-- Redis -------------------------------> connection registry and presence
  |-- PostgreSQL --------------------------> session resume and cursor recovery
```

## 3. Service Boundaries

Start with a modular monolith plus two specialized edge services.

### Edge Services

- `api`: authenticated HTTP API, orchestration, signed upload URLs, read models
- `realtime`: websocket sessions, presence, typing, room fanout, subscription management

### Core Modules Inside `api`

- `identity`: auth, sessions, devices, onboarding progress
- `profiles`: bio, goals, hobbies, badges, university, social energy
- `circles`: circle CRUD, membership, roles, tags, highlights, streak snapshots
- `events`: plans, RSVPs, reminders, waitlists, collaborative agenda
- `messaging`: conversation metadata, message persistence, read state
- `social_graph`: friend requests, friendships, mutual circles, accountability pairs
- `discovery`: candidate generation and ranking APIs
- `media`: attachment metadata, signed uploads, variant manifests
- `notifications`: inbox notifications, push dispatch orchestration

### Extracted Workers or Services When Load Demands It

- `discovery-worker`: recommendation generation and feature materialization
- `notification-worker`: APNs/FCM pushes, digests, retries, preference filtering
- `media-worker`: image/video/audio processing pipeline
- `feed-worker`: circle/activity feed fanout and aggregation

This keeps developer experience strong early while preserving clean future extraction points.

## 4. Backend Architecture

### Rust Workspace Layout

```text
backend/
  Cargo.toml
  crates/
    common/
  services/
    api/
    realtime/
  migrations/
```

### Why This Shape

- `common` holds shared config, auth claims, and realtime envelopes so mobile/backend contracts stay aligned
- `api` handles request-response workloads and transaction boundaries
- `realtime` scales independently because websocket connection count grows differently from API RPS

### Request Path

1. client sends authenticated request with JWT access token
2. `api` validates claims and idempotency key
3. domain module writes transactional state to PostgreSQL
4. same transaction appends an `outbox_events` row
5. background dispatcher publishes durable updates to Redis Streams and light fanout to Redis Pub/Sub
6. `realtime` receives fanout and forwards to subscribed sockets

That outbox pattern is the critical reliability boundary. It prevents "DB write succeeded but realtime event failed" drift.

## 5. Database Schema

Circlee should use PostgreSQL with `uuid`, `citext`, and optional `vector`.

### Core Tables

- `users`
- `profiles`
- `user_devices`
- `refresh_sessions`
- `interests`
- `user_interests`
- `circles`
- `circle_members`
- `circle_tags`
- `circle_posts`
- `events`
- `event_participants`
- `conversations`
- `conversation_members`
- `messages`
- `message_reactions`
- `message_reads`
- `friend_requests`
- `friendships`
- `notifications`
- `outbox_events`

### Data Rules

- soft delete user-generated content that affects moderation or auditability
- hard delete ephemeral presence and typing state from Redis only
- partition high-volume tables by time when needed: `messages`, `notifications`, `activity_events`
- use compound indexes built around access paths, not just foreign keys

### Read Models

Denormalized tables or materialized views should support:

- `circle_discovery_snapshot`
- `user_home_snapshot`
- `event_attendance_snapshot`
- `mutual_interest_edges`
- `trending_circle_scores`

## 6. Redis Strategy

Use Redis as an ephemeral speed layer, not as the source of truth.

### Key Families

- `presence:user:{user_id}`: current status, last heartbeat, active circle
- `typing:conv:{conversation_id}`: set of typing user ids with short TTL
- `conn:{connection_id}`: active socket metadata
- `user_conns:{user_id}`: set of connection ids for fanout
- `ratelimit:auth:{ip}`
- `ratelimit:message:{user_id}`
- `cache:circle:{circle_id}:summary`
- `cache:discover:{user_id}:{bucket}`

### Channels

- `fanout:user:{user_id}`
- `fanout:conversation:{conversation_id}`
- `fanout:circle:{circle_id}`
- `fanout:event:{event_id}`
- `fanout:system`

### Streams

- `stream:notifications`
- `stream:media`
- `stream:recommendations`
- `stream:feed`

### Sorted Sets

- `rank:circles:trending:{region}`
- `rank:events:hot:{campus_or_city}`

## 7. WebSocket Architecture

Use one websocket connection per device session. The websocket is for delivery and low-latency coordination, not primary persistence.

### Connection Lifecycle

1. app obtains short-lived realtime session token from `POST /v1/realtime/session`
2. app connects to `/ws?token=...&device_id=...`
3. server sends `hello` with subscribed scopes and last sequence
4. client sends `subscribe` commands for circles, conversations, events, and live rooms
5. every server event includes monotonic `seq` and `scope`
6. client acks highest contiguous `seq`
7. reconnect uses `resume_from_seq`; gaps are backfilled through REST sync

### Important Constraints

- never broadcast directly from database transactions
- keep websocket messages small and typed
- large list refreshes should be invalidation events, not full payload pushes
- read receipts and typing indicators stay ephemeral in Redis before periodic persistence

## 8. Realtime Messaging System

### Message Write Path

1. client creates local optimistic message with `client_nonce`
2. `POST /v1/conversations/{id}/messages`
3. server inserts message row and emits outbox event
4. realtime gateway fanouts `message.created`
5. sender reconciles optimistic item using `client_nonce`
6. recipients update timeline and unread counters

### Performance Decisions

- paginate by descending `created_at, id`
- precompute per-conversation unread counts
- store message attachments separately from message body
- keep reaction updates as narrow mutations, not full message reloads

### Moderation Safety

- attachment scanning and policy classification happen asynchronously
- message visibility can be downgraded after send if media processing fails policy

## 9. Event System Architecture

Events are first-class entities, not a side feature of circles.

### Event Types

- `hangout`
- `study_session`
- `watch_party`
- `fitness_session`
- `live_room`
- `creator_session`
- `temporary_circle_activation`

### Event Capabilities

- RSVP states: `going`, `interested`, `waitlisted`, `not_going`
- live attendance snapshots in Redis with periodic DB sync
- event chat backed by regular conversation infrastructure
- scheduled reminders emitted through notification worker
- collaborative agenda items stored as structured subdocuments

### Scaling Model

- low-cardinality event metadata in PostgreSQL
- high-frequency attendance pings and live roster in Redis
- fanout through `fanout:event:{event_id}`

## 10. Media Infrastructure

### Upload Flow

1. client requests signed upload intent from `api`
2. `api` validates quota, mime type, and auth
3. client uploads directly to Cloudflare R2
4. `media-worker` consumes upload event and generates derivatives
5. processed variants become available through CDN URLs
6. metadata row updates attachment manifest

### Derivatives

- images: thumbnail, feed, detail, original
- video: poster, preview clip, adaptive HLS ladder
- audio: waveform JSON, normalized AAC, opus voice-note variant

### Storage Rules

- immutable object keys
- variant manifest persisted in PostgreSQL
- signed URLs only for private circle/private DM assets
- public CDN URLs for public circle media variants

## 11. Voice and Video Architecture

Do not build a custom SFU in phase one. Use LiveKit or equivalent self-hosted SFU infrastructure and keep Circlee responsible for orchestration.

### Voice Rooms

- LiveKit room per Circlee voice room
- Circlee backend issues short-lived room tokens
- speaker queue, moderator controls, and stage permissions live in Circlee DB and realtime layer
- presence and reactions replicated back to app via websocket for unified UI state

### Livestreams

- creator publishes via WebRTC or RTMP ingress
- LiveKit handles SFU for interactive viewers
- optional HLS egress for large passive audiences
- comments, reactions, and room state stay on Circlee websocket to avoid split product state

### Watch Parties

- media playback authority lives in Circlee event service
- realtime sync distributes play/pause/seek deltas
- late joiners recover canonical playback cursor via REST or websocket snapshot

## 12. Authentication Flow

### Session Model

- access token JWT: 15 minutes
- refresh session token: 30 days rotating, device-bound
- device table stores push token, platform, app version, last active

### Login Paths

- email magic link or passwordless code
- Google OAuth
- onboarding completion gate before full app access

### Security Controls

- rotate refresh sessions on every refresh
- revoke on device logout
- enforce nonce-based OAuth completion
- store only hashed refresh tokens
- add IP and device fingerprint anomaly scoring before sensitive actions

## 13. API Architecture

### HTTP Surface

- `POST /v1/auth/email/start`
- `POST /v1/auth/google/complete`
- `POST /v1/auth/refresh`
- `POST /v1/auth/logout`
- `GET /v1/me`
- `PATCH /v1/me/profile`
- `GET /v1/discover/home`
- `GET /v1/discover/circles`
- `GET /v1/discover/people`
- `POST /v1/circles`
- `GET /v1/circles/{circle_id}`
- `POST /v1/circles/{circle_id}/join`
- `POST /v1/circles/{circle_id}/leave`
- `GET /v1/circles/{circle_id}/feed`
- `POST /v1/events`
- `POST /v1/events/{event_id}/rsvp`
- `GET /v1/conversations`
- `POST /v1/conversations`
- `GET /v1/conversations/{conversation_id}/messages`
- `POST /v1/conversations/{conversation_id}/messages`
- `POST /v1/media/upload-requests`
- `GET /v1/notifications`
- `POST /v1/realtime/session`

### Contract Discipline

- all mutations accept `idempotency_key`
- all list endpoints use opaque cursor pagination
- return lightweight embedded objects, not massive nested payloads
- keep feed cards normalized enough for cache merges

## 14. Flutter Architecture

Use feature-first clean architecture, but keep it lightweight.

### Layers

- `presentation`: widgets, routes, animations, UI state glue
- `application`: Riverpod controllers, use-cases, optimistic orchestration
- `domain`: entities, value objects, repository contracts
- `data`: DTOs, adapters, repositories, local cache, remote clients

### State Strategy

- `AsyncNotifier` or `Notifier` for screen/view-model state
- `StateProvider` only for tiny ephemeral flags
- hooks for local transient widget state and animation orchestration
- normalized local cache for messages, circles, events, and users

### Offline Strategy

- enqueue mutations with stable local operation ids
- apply optimistic UI immediately
- replay queue on reconnect
- reconcile by server id or `client_nonce`

## 15. Navigation Structure

Use a 4-tab shell to avoid clutter:

- `Home`: active circles, today’s plans, live now, recent activity
- `Discover`: people, circles, events, campus/local recommendations
- `Inbox`: DMs, circle chat inbox, notifications pivot
- `You`: profile, badges, saved plans, settings

Primary creation uses a floating action cluster:

- create circle
- create event
- start live room
- invite friends

Deep links:

- `/circle/:id`
- `/event/:id`
- `/chat/:id`
- `/profile/:id`
- `/live/:id`

## 16. UI Design System

Circlee should feel warm, premium, and alive without becoming noisy.

### Visual Direction

- dark-first graphite surfaces with deep ocean gradients
- mint/cyan energy accents with selective coral warmth for social actions
- high-contrast typography with strong spacing discipline
- subtle glass overlays only on live surfaces and hero cards

### Components

- live cards with animated presence rings
- circle chips with density-aware pill states
- stacked avatar rows with mutual-interest badges
- timeline cards with compact metadata and one dominant CTA
- bottom sheets for join flows and quick planning

See [docs/design-system.md](/home/kaleab/Documents/Circlee/docs/design-system.md) for tokens, motion, and screen guidance.

## 17. Discovery and Recommendation System

Use a hybrid system rather than a single model.

### Candidate Generation

- explicit interest overlap
- location radius and campus affinity
- friend-of-friend paths
- shared event attendance
- active-now circles
- trending circles by region
- text semantic similarity with tag embeddings

### Ranking Features

- shared goals count
- shared interest weight
- social energy compatibility
- current activity freshness
- geographic relevance
- circle health score
- mutual graph strength
- event schedule overlap
- new-user diversity boost

### Example Score

```text
score =
  0.22 * shared_interest_similarity +
  0.14 * goal_alignment +
  0.12 * social_energy_match +
  0.12 * geo_relevance +
  0.10 * graph_proximity +
  0.10 * event_schedule_overlap +
  0.10 * circle_health_score +
  0.06 * recency_boost +
  0.04 * exploration_bonus
```

### Anti-Spam Constraints

- penalize communities with low retention and high invite churn
- rate-limit aggressive invite or DM behavior
- optimize for join-to-return rate, not raw clickthrough

## 18. Deployment Architecture

### Runtime Topology

- `nginx`: TLS termination, websocket upgrade proxy, static rules
- `api`: multiple stateless Axum instances
- `realtime`: websocket instances with sticky-free auth and Redis-backed routing
- `postgres`: primary plus read replica
- `redis`: primary plus replica or managed cluster
- `workers`: discovery, media, notification
- `livekit`: SFU nodes

### Scaling Rules

- scale `realtime` on concurrent connections and outbound fanout
- scale `api` on p95 latency and CPU saturation
- scale workers by queue lag
- move hot read paths to replicas only after query shapes are stable

### Reliability Rules

- health checks for every service
- outbox + retry semantics for async events
- distributed tracing across REST and websocket fanout
- SLOs for `message_send`, `join_circle`, `create_event`, `resume_socket`

## 19. Performance Guardrails

### Mobile

- app startup under 2.2s on mid-range Android
- scroll jank below 1% missed frames on chat/discovery lists
- image prefetch and list item size stability
- local first render before network refresh on home/inbox

### Backend

- `POST /messages` p95 under 180ms at normal load
- websocket fanout p95 under 120ms within region
- join/leave circle mutations under 150ms
- discovery home request under 250ms from cached candidate sets

### Data

- avoid N+1 graph hydration in feed and discover APIs
- use batched member/profile fetches
- prefer append-only activity tables for analytics

## 20. Implementation Roadmap

### Phase 1

- auth, onboarding, profiles
- circles, events, DMs, circle chat
- discovery v1
- push notifications
- direct uploads

### Phase 2

- voice rooms
- shared challenge systems
- collaborative bucket lists
- seasonal communities
- watch parties

### Phase 3

- ranking model improvements
- large-scale livestreams
- university graph expansion
- creator tooling and moderation suite
