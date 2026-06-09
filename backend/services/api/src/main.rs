use std::net::SocketAddr;

use axum::{
    Json, Router,
    extract::Path,
    http::StatusCode,
    response::IntoResponse,
    routing::{get, patch, post},
};
use circlee_common::config::HttpConfig;
use serde::{Deserialize, Serialize};
use tower_http::{cors::CorsLayer, trace::TraceLayer};
use tracing::info;
use uuid::Uuid;

#[derive(Debug, Serialize)]
struct HealthResponse {
    status: &'static str,
    service: &'static str,
}

#[derive(Debug, Serialize)]
struct SessionResponse {
    access_token: String,
    refresh_token: String,
    user_id: String,
}

#[derive(Debug, Deserialize)]
struct CreateCircleRequest {
    name: String,
    tagline: String,
    privacy: String,
    primary_tag: String,
}

#[derive(Debug, Serialize)]
struct CircleSummary {
    id: String,
    name: String,
    tagline: String,
    privacy: String,
    member_count: u32,
}

#[derive(Debug, Serialize)]
struct DiscoverResponse {
    headline: &'static str,
    circles: Vec<CircleSummary>,
}

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt()
        .with_env_filter("info,tower_http=info")
        .init();

    let config = HttpConfig::default();
    let app = Router::new()
        .route("/health", get(health))
        .route("/v1/auth/refresh", post(refresh))
        .route("/v1/me/profile", patch(update_profile))
        .route("/v1/circles", post(create_circle))
        .route("/v1/circles/{circle_id}", get(get_circle))
        .route("/v1/discover/home", get(discover_home))
        .route("/v1/media/upload-requests", post(create_upload_request))
        .route("/v1/realtime/session", post(create_realtime_session))
        .layer(CorsLayer::permissive())
        .layer(TraceLayer::new_for_http());

    let address: SocketAddr = format!("{}:{}", config.host, config.port)
        .parse()
        .expect("valid socket address");

    info!("circlee api listening on {}", address);

    let listener = tokio::net::TcpListener::bind(address)
        .await
        .expect("bind api listener");

    axum::serve(listener, app).await.expect("serve api");
}

async fn health() -> impl IntoResponse {
    Json(HealthResponse {
        status: "ok",
        service: "circlee-api",
    })
}

async fn refresh() -> impl IntoResponse {
    Json(SessionResponse {
        access_token: format!("access_{}", Uuid::now_v7()),
        refresh_token: format!("refresh_{}", Uuid::now_v7()),
        user_id: "user_demo".to_string(),
    })
}

async fn update_profile() -> impl IntoResponse {
    StatusCode::NO_CONTENT
}

async fn create_circle(Json(payload): Json<CreateCircleRequest>) -> impl IntoResponse {
    let circle = CircleSummary {
        id: format!("circle_{}", Uuid::now_v7()),
        name: payload.name,
        tagline: payload.tagline,
        privacy: payload.privacy,
        member_count: 1,
    };

    let _ = payload.primary_tag;

    (StatusCode::CREATED, Json(circle))
}

async fn get_circle(Path(circle_id): Path<String>) -> impl IntoResponse {
    Json(CircleSummary {
        id: circle_id,
        name: "Late Night Builders".to_string(),
        tagline: "Ship together after class.".to_string(),
        privacy: "public".to_string(),
        member_count: 284,
    })
}

async fn discover_home() -> impl IntoResponse {
    Json(DiscoverResponse {
        headline: "People and circles that match your energy this week",
        circles: vec![
            CircleSummary {
                id: "circle_anime_watch".to_string(),
                name: "Campus Anime Nights".to_string(),
                tagline: "Weekly co-watch sessions and live reactions.".to_string(),
                privacy: "public".to_string(),
                member_count: 913,
            },
            CircleSummary {
                id: "circle_gym_crew".to_string(),
                name: "6AM Gym Accountability".to_string(),
                tagline: "Check-ins, lifts, and shared streaks.".to_string(),
                privacy: "private".to_string(),
                member_count: 51,
            },
        ],
    })
}

async fn create_upload_request() -> impl IntoResponse {
    Json(serde_json::json!({
        "upload_id": format!("upl_{}", Uuid::now_v7()),
        "method": "PUT",
        "url": "https://r2.example.com/circlee/media/upl_demo",
        "headers": {
            "content-type": "image/jpeg"
        }
    }))
}

async fn create_realtime_session() -> impl IntoResponse {
    Json(serde_json::json!({
        "token": format!("rt_{}", Uuid::now_v7()),
        "expires_in_seconds": 120,
        "recommended_scopes": [
            { "type": "system", "id": "global" }
        ]
    }))
}
