docker run -d --name sshbox \
  -p 2222:22 \
  -e SSH_PUBLIC_KEY="$(cat ~/.ssh/id_ed25519.pub)" \
  docker.io/library/ubuntu:22.04-ssh