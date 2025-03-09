#!/bin/bash
set -e

host="${POSTGRES_HOST:-db}"
port="${POSTGRES_PORT:-5432}"

echo "⏳ Aguardando o banco de dados em $host:$port..."

while ! nc -z $host $port; do
  sleep 1
done

echo "✅ Banco de dados está pronto! Aplicação iniciando..."

# Aplica migrações do Django antes de iniciar o servidor
echo "🚀 Aplicando migrações do banco de dados..."
python manage.py migrate

# Coleta arquivos estáticos (se necessário)
echo "🎨 Coletando arquivos estáticos..."
python manage.py collectstatic --noinput

# Inicia o servidor Django com Gunicorn
echo "🔥 Iniciando Gunicorn..."
exec gunicorn project.wsgi:application --bind 0.0.0.0:8000 --workers=3 --threads=2 --timeout=120
