import asyncio
from typing import AsyncGenerator

import pandas as pd
from faker import Faker
import random
import string

from src.app.core.db.database import async_get_db
from src.app.core.security import get_password_hash
from src.app.models import User

fake = Faker()

async def generate_and_save_users(num_users: int) -> None:
    data = []
    async for db in async_get_db():  # Use the async generator
        for _ in range(num_users):
            name = fake.name()
            username = fake.user_name()
            password = ''.join(random.choices(string.ascii_letters + string.digits + "!@#$%", k=12))
            email = fake.email()
            comment = ""

            # Create user instance
            user = User(
                name=name,
                username=username,
                email=email,
                hashed_password=get_password_hash(password=password)
            )

            # Add and commit user to database
            db.add(user)
            await db.commit()
            await db.refresh(user)

            # Append data for Excel
            data.append([name, username, password, email, comment])

    # Create DataFrame and save to Excel
    df = pd.DataFrame(data, columns=['name', 'username', 'password', 'email', 'comment'])
    df.to_excel('user_data.xlsx', index=False)
    print("Excel file 'user_data.xlsx' has been created.")

# Example bot command placeholder (integrate with your bot framework)
async def handle_generate_excel_command(chat_id: int) -> None:
    await generate_and_save_users(num_users=100)
    # Placeholder for sending the file via bot (e.g., Telegram)
    # await bot.send_document(chat_id=chat_id, document=open('user_data.xlsx', 'rb'))
    print(f"Excel file ready for chat {chat_id}. Implement bot send logic here.")

# Run the function (for testing)
if __name__ == "__main__":
    asyncio.run(generate_and_save_users(num_users=100))