FROM python:3.9

WORKDIR /app

# Update the ENV information to the correct your production MySQL infos.
ENV APP_SECRET_STRING=P@ssW0rd
ENV DATABASE_USERNAME=user
ENV DATABASE_PASSWORD=P@ssW0rd
ENV DATABASE=fastapi_app_final_project_mobile
ENV DATABASE_HOST=127.0.0.1
ENV DATABASE_SOCKET=3309

RUN pip install --upgrade pip
COPY . .
RUN pip install --no-cache-dir -r  requirements.txt

ENV PORT 8200
EXPOSE 8200

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8200"]