import random
from os import getenv

from discord_webhook import DiscordEmbed, DiscordWebhook
from fastapi import FastAPI, Request


def web_hook(
    title: str,
    app: str,
    status: str,
    user: str,
    webhook_url: str = getenv("WEBHOOK_URL"),
):
    webhook = DiscordWebhook(url=webhook_url)
    embed = DiscordEmbed(title=title, color=random.randint(0, 0xFFFFFF))
    embed.add_embed_field(name="App:", value=app)
    embed.add_embed_field(name="Status:", value=status)
    embed.add_embed_field(name="User:", value=user)
    webhook.add_embed(embed)
    webhook.execute()
    return True


app = FastAPI()


@app.get("/")
async def index():
    """
    The index function is the main page of the website.
    
    :return: dict
    """
    return {"message": "healthy", "statusCode": 200}


@app.post("/webhook")
async def webhook(request: Request):
    """
    The webhook function is used to send a notification to a discord channel
    
    :param request:Request: Used to get the request body.
    :return: a json object that is used to determine what to do with the webhook data.
    """
    data = await request.json()
    web_hook(
        title="Herkou Deploy",
        app=data["data"]["app"]["name"],
        status=data["data"]["status"],
        user=data["data"]["user"]["email"]
    )
    return {"message": "success", "statusCode": 200}
