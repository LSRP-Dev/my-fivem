import discord
from discord.ext import commands, tasks
import datetime

STAFF_CHANNEL_NAME = "staff-updates"
CHANGELOG_CHANNEL_NAME = "changelog"

class AutoSyncUpdates(commands.Cog):
    def init(self, bot):
        self.bot = bot
        self.sync_updates.start()

    def cog_unload(self):
        self.sync_updates.cancel()

    @tasks.loop(minutes=1)
    async def sync_updates(self):
        now = datetime.datetime.utcnow()
        target_hour = 17  # 17:30 UK time = 17:30 GMT
        target_minute = 30

        if now.hour == target_hour and now.minute == target_minute:
            for guild in self.bot.guilds:
                staff_channel = discord.utils.get(guild.channels, name=STAFF_CHANNEL_NAME)
                changelog_channel = discord.utils.get(guild.channels, name=CHANGELOG_CHANNEL_NAME)

                if not staff_channel or not changelog_channel:
                    continue

                messages = await staff_channel.history(limit=100).flatten()
                cutoff = now.timestamp() - 86400  # last 24 hours
                recent = [m for m in messages if not m.author.bot and m.created_at.timestamp() > cutoff]

                if not recent:
                    continue

                formatted = "\n".join([f"- {m.content}" for m in reversed(recent)])
                embed = discord.Embed(
                    title=f" Changelog — {now.strftime('%Y-%m-%d')}",
                    description=formatted,
                    color=discord.Color.green(),
                    timestamp=now
                )
                embed.set_footer(text="Auto-synced from staff updates")
                await changelog_channel.send(embed=embed)

    @sync_updates.before_loop
    async def before_sync(self):
        await self.bot.wait_until_ready()

async def setup(bot):
    await bot.add_cog(AutoSyncUpdates(bot))