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

请查看 [dockerfil](dockerfile)
