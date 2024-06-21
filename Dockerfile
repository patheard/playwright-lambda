FROM public.ecr.aws/lambda/nodejs:20.2024.04.24.10-x86_64

RUN dnf -y install \
    nss \
    dbus \
    atk \
    cups \
    at-spi2-atk \
    libdrm \
    libXcomposite \
    libXdamage \
    libXfixes \
    libXrandr \
    mesa-libgbm \
    pango \
    alsa-lib

COPY package*.json index.js ${LAMBDA_TASK_ROOT}

# Install dependencies
RUN npm install

# Intall the Playwright browser
ENV PLAYWRIGHT_BROWSERS_PATH=/var/task
RUN npx playwright install chromium

CMD [ "index.handler" ]