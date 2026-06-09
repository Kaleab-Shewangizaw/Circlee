use std::net::SocketAddr;

use axum::{
    Router,
    extract::ws::{Message, WebSocket, WebSocketUpgrade},
    response::IntoResponse,
    routing::get,
};
use circlee_common::{
    config::RealtimeConfig,
    realtime::{EventEnvelope, HelloPayload, Scope},
};
use tracing::info;
use uuid::Uuid;

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt()
        .with_env_filter("info")
        .init();

    let config = RealtimeConfig::default();
    let app = Router::new().route("/ws", get(upgrade_socket));

    let address: SocketAddr = format!("{}:{}", config.host, config.port)
        .parse()
        .expect("valid realtime address");

    info!("circlee realtime listening on {}", address);

    let listener = tokio::net::TcpListener::bind(address)
        .await
        .expect("bind realtime listener");

    axum::serve(listener, app).await.expect("serve realtime");
}

async fn upgrade_socket(ws: WebSocketUpgrade) -> impl IntoResponse {
    ws.on_upgrade(handle_socket)
}

async fn handle_socket(mut socket: WebSocket) {
    let hello = EventEnvelope {
        id: format!("evt_{}", Uuid::now_v7()),
        seq: 1,
        scope: Scope {
            r#type: "system".to_string(),
            id: "global".to_string(),
        },
        kind: "hello".to_string(),
        sent_at: "2026-05-29T00:00:00Z".to_string(),
        payload: HelloPayload {
            connection_id: format!("conn_{}", Uuid::now_v7()),
            user_id: "user_demo".to_string(),
            resume_supported: true,
            heartbeat_interval_ms: 20_000,
        },
    };

    if socket
        .send(Message::Text(
            serde_json::to_string(&hello).expect("serialize hello").into(),
        ))
        .await
        .is_err()
    {
        return;
    }

    while let Some(Ok(message)) = socket.recv().await {
        match message {
            Message::Text(text) => {
                let message = text.to_string();
                let echo = EventEnvelope {
                    id: format!("evt_{}", Uuid::now_v7()),
                    seq: 2,
                    scope: Scope {
                        r#type: "system".to_string(),
                        id: "global".to_string(),
                    },
                    kind: "debug.echo".to_string(),
                    sent_at: "2026-05-29T00:00:00Z".to_string(),
                    payload: serde_json::json!({ "message": message }),
                };

                if socket
                    .send(Message::Text(
                        serde_json::to_string(&echo).expect("serialize echo").into(),
                    ))
                    .await
                    .is_err()
                {
                    break;
                }
            }
            Message::Close(_) => break,
            _ => {}
        }
    }
}
