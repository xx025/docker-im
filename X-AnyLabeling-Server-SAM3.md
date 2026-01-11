Docker HUB : https://hub.docker.com/r/dockerhub036/x-anylabeling-server

Ref: https://github.com/CVHub520/X-AnyLabeling-Server

Docker Run

```shell
docker run -d \
  --name x-anylabeling-server \
  --restart always \
  --gpus all \
  -p 8000:8000 \
  dockerhub036/x-anylabeling-server:latest
 ```

Docker Compose
```yaml
services:
  x-anylabeling-server:
    image: dockerhub036/x-anylabeling-server:latest
    container_name: x-anylabeling-server
    restart: always
    ports:
      - "8000:8000"
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              capabilities: ["gpu"]
```


Docker File

```dockerfile
# PyTorch GPU base with CUDA 12.8 + cuDNN 9
FROM pytorch/pytorch:2.9.1-cuda12.8-cudnn9-runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
	PYTHONUNBUFFERED=1 \
	PIP_NO_CACHE_DIR=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
	git \
	ffmpeg \
	libgl1 \
	libglib2.0-0 \
	&& rm -rf /var/lib/apt/lists/*

COPY . .

RUN pip install --upgrade pip uv
RUN uv pip install --system --no-cache .[all]

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

