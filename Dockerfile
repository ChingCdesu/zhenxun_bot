# FROM node:lts-ubuntu as web-build
# WORKDIR /build

# RUN apt update
# RUN apt install -y git

# RUN git clone https://github.com/HibiKier/zhenxun_bot_webui.git
# WORKDIR /build/zhenxun_bot_webui
# RUN yarn install
# RUN yarn build

FROM ubuntu:22.04
WORKDIR /app

RUN apt update
RUN apt install -y git python3 python3-pip curl

RUN git clone https://github.com/HibiKier/zhenxun_bot.git

WORKDIR /app/zhenxun_bot
RUN git checkout 0.1.6.7
RUN rm -rf .git/
RUN pip3 install poetry
RUN poetry install
RUN poetry run playwright install chromium
RUN poetry run playwright install-deps chromium

RUN apt clean
RUN poetry cache clear ali --all -n

CMD ["poetry", "run", "python3", "bot.py"]
