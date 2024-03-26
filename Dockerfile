# Use uma imagem base oficial do Node.js
FROM node:20.11.1 

# Define o diretório de trabalho dentro do container
WORKDIR /usr/src/app

# Instala as dependências do Puppeteer e do Express
# Nota: o Puppeteer precisa do Chrome, então estamos instalando dependências para o Chrome funcionar no Docker
RUN apt-get update \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable libxss1 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Copia os arquivos do projeto para o diretório de trabalho
COPY package*.json ./

# Instala todas as dependências do projeto, incluindo o Puppeteer e o Express
RUN npm install 

# Copia o restante dos arquivos do projeto
COPY . .

# Expõe a porta que sua aplicação Express.js vai usar
EXPOSE 3000

# Comando para rodar a aplicação
CMD ["npm", "start"]
