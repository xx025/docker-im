
**Docker Hub :**  https://hub.docker.com/r/dockerhub036/paddlexocr

**Ref :** https://github.com/PaddlePaddle/PaddleOCR ，https://www.paddleocr.ai/latest/version3.x/pipeline_usage/OCR.html

**Run**

> 需要Nvidai显卡驱动 CUDA>=12.6

> 镜像比较大，可以先pull 下来镜像再启动

> 启动之后会下载权重

```
docker run -d --gpus all -p 8080:8080  dockerhub036/paddlexocr:3.2.2-gpu-cuda12.6
```

**Docker Compose**
```yaml
services:
  paddlexocr:
    image: dockerhub036/paddlexocr:3.2.2-gpu-cuda12.6
    ports:
      - "8080:8080"
    restart: always
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              capabilities: ["gpu"]
```


**Docker File**
```dockerfile
FROM dockerhub036/paddleocr:3.2.2-gpu-cuda12.6
RUN paddlex --install serving
CMD ["paddlex", "--serve", "--pipeline", "OCR"]
```
