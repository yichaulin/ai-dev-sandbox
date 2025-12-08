FROM ubuntu:latest

WORKDIR /app

# Set the PATH environment variable
ENV PATH="/root/.local/bin:$PATH"

RUN apt-get update && apt-get install -y curl socat bubblewrap
RUN curl -fsSL https://claude.ai/install.sh | bash

CMD ["bash"]
