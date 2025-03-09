
---

### 📌 **`README.md` - Django com Docker**
```md
# 🐍 Django Base com Docker 🚀

Este repositório é uma **base estruturada para desenvolvimento de aplicações Django** utilizando **Docker e PostgreSQL**. Ele fornece um ambiente completo e pronto para iniciar novos projetos.

## 📦 Tecnologias Utilizadas
- **Python 3.12** (Slim)
- **Django** (Framework Web)
- **Gunicorn** (Servidor de aplicação WSGI)
- **PostgreSQL** (Banco de dados)
- **Nginx** (Proxy reverso)
- **Docker & Docker Compose** (Gerenciamento de containers)
- **UV** (Substituto otimizado para `pip`)

---

## 🚀 Como Configurar o Projeto

### 🔧 **1. Pré-requisitos**
Antes de começar, você precisa ter instalado:
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

---

### 🏗 **2. Clonar o Repositório**
```sh
git clone https://github.com/seu-usuario/django-docker-base.git
cd django-docker-base
```

---

### ⚙️ **3. Configurar Variáveis de Ambiente**
Crie um arquivo **`.env`** na raiz do projeto e adicione as configurações do banco:

```ini
POSTGRES_DB=meubanco
POSTGRES_USER=usuario
POSTGRES_PASSWORD=senha
POSTGRES_HOST=db
POSTGRES_PORT=5432
```

---

### 🐳 **4. Subir os Containers**
Para **construir e iniciar os containers**, execute:
```sh
docker-compose up --build
```
Isso fará o seguinte:
✅ Criará um container para o Django  
✅ Criará um container para o PostgreSQL  
✅ Criará um container para o Nginx  

Agora, acesse o projeto via:  
📌 **Django** → `http://localhost:8000`  
📌 **Aplicação via Nginx** → `http://localhost`

---

### 📜 **5. Executar Migrações**
Após o primeiro build, aplique as migrações do Django:
```sh
docker exec -it django_app python manage.py migrate
```

Se precisar criar um superusuário:
```sh
docker exec -it django_app python manage.py createsuperuser
```

---

## 📂 Estrutura do Projeto

```
📦 base_docker/               # Pasta raiz do projeto
├── 📂 docs/                  # Documentação do projeto
├── 📂 nginx/                 # Configuração do Nginx
│   └── 📄 nginx.conf
├── 📂 project/               # Código-fonte do Django
│   ├── 📂 __pycache__/
│   ├── 📄 __init__.py
│   ├── 📄 asgi.py
│   ├── 📄 settings.py
│   ├── 📄 urls.py
│   ├── 📄 wsgi.py
├── 📂 static/                # Arquivos estáticos coletados
├── 📂 media/                 # Arquivos de mídia (upload)
├── 📂 scripts/               # Scripts auxiliares
│   └── 📄 wait-for-db.sh     # Script de espera do banco
├── 📄 .dockerignore          # Ignorar arquivos desnecessários no Docker
├── 📄 .gitignore             # Ignorar arquivos no Git
├── 📄 .env                   # Configurações do ambiente
├── 📄 docker-compose.yml     # Orquestração dos containers
├── 📄 Dockerfile             # Configuração do container Django
├── 📄 manage.py              # Script principal do Django
├── 📄 requirements.txt       # Dependências do Python
└── 📄 README.md              # Documentação do projeto

```

---

## 🛠 Comandos Úteis

### **Verificar logs**
```sh
docker logs django_app
docker logs nginx
docker logs postgres_db
```

### **Entrar no container Django**
```sh
docker exec -it django_app sh
```

### **Executar comandos Django**
```sh
docker exec -it django_app python manage.py shell
```

### **Derrubar containers**
```sh
docker-compose down -v
```

---

## 🛠 Possíveis Erros e Soluções

### **1️⃣ `django_app exited with code 127`**
**Causa:** O script `wait-for-db.sh` pode não ter sido copiado corretamente.  
**Solução:**
```sh
chmod +x scripts/wait-for-db.sh
docker-compose up --build
```

### **2️⃣ `nginx: [emerg] host not found in upstream "web"`**
**Causa:** O Nginx não encontrou o serviço Django.  
**Solução:** Certifique-se de que o `nginx.conf` aponta corretamente para:
```nginx
proxy_pass http://django_app:8000;
```
Depois, reinicie:
```sh
docker-compose down -v
docker-compose up --build
```

---

## 🎯 Próximos Passos
- 📌 Adicionar suporte para `.env.example`
- 📌 Configurar CI/CD (GitHub Actions)
- 📌 Melhorar logs e monitoramento

---

## 📜 Licença
Este projeto está sob a licença MIT. Sinta-se livre para usar e modificar! 🚀

---