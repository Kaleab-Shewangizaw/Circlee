use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Scope {
    pub r#type: String,
    pub id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EventEnvelope<T> {
    pub id: String,
    pub seq: u64,
    pub scope: Scope,
    pub kind: String,
    pub sent_at: String,
    pub payload: T,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct HelloPayload {
    pub connection_id: String,
    pub user_id: String,
    pub resume_supported: bool,
    pub heartbeat_interval_ms: u64,
}

