# Usa a imagem slim para manter o container pequeno
FROM python:3.12-slim

WORKDIR /app

# Instala dependências do sistema para compilar pacotes e rodar PostgreSQL
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc libpq-dev netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Instala o gerenciador de pacotes UV
RUN pip install --no-cache-dir uv

# Copia apenas o arquivo de dependências primeiro (para melhor caching)
COPY requirements.txt /app/

# Usa o UV para instalar os pacotes Python
RUN uv pip install --system --no-cache-dir -r requirements.txt

# Copia o restante do código
COPY . /app/

# Permissão para o script de espera do banco de dados
COPY wait-for-db.sh /app/
RUN chmod +x /app/wait-for-db.sh

# Coleta arquivos estáticos
RUN python manage.py collectstatic --noinput

# Expõe a porta do Django
EXPOSE 8000

# Comando final para iniciar a aplicação
CMD ["sh", "/app/wait-for-db.sh", "gunicorn", "project.wsgi:application", "--bind", "0.0.0.0:8000", "--workers=3", "--threads=2", "--timeout=120"]
