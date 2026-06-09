# Circlee Realtime Events

## Envelope

```json
{
  "id": "evt_01JXZ3MSA4A1M4F2F2VMY5X0D6",
  "seq": 104422,
  "scope": {
    "type": "conversation",
    "id": "conv_01JXZ34H5N4Q4WN50FQ13FDXGP"
  },
  "kind": "message.created",
  "sent_at": "2026-05-29T12:40:10Z",
  "payload": {}
}
```

## Client Commands

### Subscribe

```json
{
  "kind": "subscribe",
  "payload": {
    "scopes": [
      {"type": "conversation", "id": "conv_01"},
      {"type": "circle", "id": "circle_01"}
    ]
  }
}
```

### Ack

```json
{
  "kind": "ack",
  "payload": {
    "seq": 104422
  }
}
```

### Typing

```json
{
  "kind": "typing.set",
  "payload": {
    "conversation_id": "conv_01",
    "is_typing": true
  }
}
```

## Server Events

### Hello

```json
{
  "kind": "hello",
  "payload": {
    "connection_id": "conn_01",
    "user_id": "user_01",
    "resume_supported": true,
    "heartbeat_interval_ms": 20000
  }
}
```

### Message Created

```json
{
  "kind": "message.created",
  "payload": {
    "conversation_id": "conv_01",
    "message": {
      "id": "msg_01",
      "client_nonce": "nonce_01",
      "sender_id": "user_01",
      "body": "Anyone up for a late coding circle tonight?",
      "created_at": "2026-05-29T12:40:10Z"
    }
  }
}
```

### Circle Presence Snapshot

```json
{
  "kind": "circle.presence",
  "payload": {
    "circle_id": "circle_01",
    "active_count": 42,
    "typing_count": 3,
    "live_room_active": true
  }
}
```

### Event Attendance Delta

```json
{
  "kind": "event.attendance.updated",
  "payload": {
    "event_id": "event_01",
    "counts": {
      "going": 26,
      "interested": 14,
      "waitlisted": 2
    },
    "recent_user_ids": ["user_01", "user_02", "user_03"]
  }
}
```

### Live Room State

```json
{
  "kind": "live.room.state",
  "payload": {
    "room_id": "room_01",
    "stage_user_ids": ["user_01", "user_07"],
    "listener_count": 128,
    "raised_hand_count": 9
  }
}
```

## Delivery Rules

- all events are append-only from the client perspective
- missing sequences trigger REST backfill
- typing and presence may be dropped under reconnect pressure
- message, RSVP, and membership events must be durable and recoverable
