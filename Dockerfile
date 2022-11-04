FROM teracy/ubuntu:20.04-dind-20.10.13

# Environment variables
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ENV JULIA_VERSION=1.8.2

RUN apt update; apt-get install -y wget curl python3 python3-pip unzip ca-certificates

# RUN pip install awscliv2

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
   ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

# AWS credentials
RUN aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
RUN aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
RUN aws configure set region us-east-1

# Installing julia
RUN mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz

RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

# Copy the project files
RUN mkdir /financial-math
COPY . /financial-math/

# Start Julia on load
RUN ["chmod", "+x", "/financial-math/entrypoint.sh"]
ENTRYPOINT ["sh", "/financial-math/entrypoint.sh"]