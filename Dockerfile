FROM node:20-alpine

WORKDIR /app

# ===== 关键1：禁用 IPv6 优先 =====
ENV NODE_OPTIONS=--dns-result-order=ipv4first

# ===== 关键2：基础工具 =====
RUN corepack enable

# ===== 关键4：npm 镜像加速 =====
RUN pnpm config set registry https://registry.npmmirror.com

# ===== 安装依赖 =====
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

# ===== 复制代码 =====
COPY . .

RUN pnpm build

EXPOSE 3000

CMD ["pnpm", "start"]