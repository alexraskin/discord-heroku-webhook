from fastapi.testclient import TestClient

from src.server import app


client = TestClient(app)


def test_read_index():
    response = client.get("/")
    assert response.status_code == 200


def test_bad_request():
    response = client.get("/api")
    assert response.status_code == 404
    assert response.json() == {"detail": "Not Found"}

def test_webhook():
    payload =        {
    "data": {
        "app": {
            "name": "lhcloudybot"
        },
        "user": {
            "email": "test@fastmail.fm"
        },
        "status": "succeeded",
        "pstable": {
            "worker": {
                "slug": {
                    "id": "8dd86052-c322-4ca9-978b-7ffc9007b48c"
                },
                "command": "python bot/bot.py"
            }
        }
    },
    "actor": {
        "id": "42a979b5-2880-458d-9e45-e9ac34af180b",
        "email": "alexraskin@fastmail.fm"
    }
    }
    response = client.get("/webhook", json=payload)
    assert response.status_code == 200
