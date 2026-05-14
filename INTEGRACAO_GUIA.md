# 🔗 Guia Completo: Integração Backend + Frontend

## 📋 Sumário
1. [Verificação Pré-Requisitos](#-1-verificação-pré-requisitos)
2. [Executar Backend](#-2-executar-o-backend)
3. [Configurar Frontend](#-3-configurar-o-frontend)
4. [Testar Integração](#-4-testar-a-integração)
5. [Troubleshooting](#-5-troubleshooting)
6. [Implantação](#-6-implantação)

---

## ✅ 1. Verificação Pré-Requisitos

### Backend (Java 17+)
```powershell
java -version
# Deve mostrar Java 17+
```

### Flutter (3.11.0+)
```bash
flutter doctor
# Deve estar com status OK
```

### Git (verificar)
```bash
git --version
```

---

## 🚀 2. Executar o Backend

### Opção A: Terminal Local (Recomendado para desenvolvimento)

```powershell
# Navegar para o backend
cd C:\Users\Windows\Desktop\Gustavo\git_projects\delivery-app\delivery_app_backend

# Limpar e construir
./gradlew clean build

# Executar
./gradlew bootRun
```

**✅ Backend estará rodando em:** `http://localhost:8080`

**Verificar se está funcionando:**
```bash
# Abrir no navegador ou terminal:
curl http://localhost:8080/restaurantes
```

Deve retornar: `[]` (array vazio) - é esperado na primeira execução.

---

### Opção B: IDE (IntelliJ IDEA)

1. Abrir a pasta `delivery_app_backend` como projeto
2. Ir em **Run → Edit Configurations**
3. Adicionar nova configuração "Gradle"
4. Task: `bootRun`
5. Clicar em **Run** (verde ▶️)

---

## 🔧 3. Configurar o Frontend

### Passo 1: Atualizar URL do Backend

**Arquivo:** `mobile/delivery_app_frontend/lib/core/constants/api_constants.dart`

#### Se Backend está LOCAL no seu PC:
```dart
static const String baseUrl = 'http://localhost:8080';
```

#### Se Backend está em OUTRA MÁQUINA DA MESMA REDE:

1. **Encontre o IP da máquina com o backend:**

```powershell
# No PC onde o backend está rodando:
ipconfig

# Procure por algo como: 192.168.1.x ou 192.168.0.x
# Exemplo: 192.168.1.100
```

2. **Edite o arquivo de constantes:**

```dart
static const String baseUrl = 'http://192.168.1.100:8080';
// Use o IP que encontrou acima
```

---

### Passo 2: Instalar Dependências Flutter

```bash
cd mobile/delivery_app_frontend

# Obter dependências
flutter pub get

# (Opcional) Gerar código do build_runner
flutter pub run build_runner build

# Analisar erros
flutter analyze
```

---

### Passo 3: Executar o Frontend

#### Em Emulador Android/iOS:
```bash
flutter run
```

#### Em Browser (Web):
```bash
flutter run -d chrome
```

#### Em Dispositivo Físico:
1. Conectar via USB
2. `flutter run`

---

## 🧪 4. Testar a Integração

### Teste 1: Verificar se Backend está acessível

**No terminal do Frontend:**
```bash
curl http://localhost:8080/restaurantes
```

Esperado: `[]`

---

### Teste 2: Criar um Restaurante via Backend

**Terminal/Postman/curl:**

```bash
curl -X POST http://localhost:8080/restaurantes \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Pizza do João",
    "endereco": "Rua das Flores, 123"
  }'
```

**Esperado:**
```json
{
  "id": 1,
  "nome": "Pizza do João",
  "endereco": "Rua das Flores, 123",
  "produtos": []
}
```

---

### Teste 3: Criar Produto

```bash
curl -X POST http://localhost:8080/produtos \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Pizza Margherita",
    "preco": 45.50,
    "restaurante": {
      "id": 1
    }
  }'
```

---

### Teste 4: No App Flutter

1. Ir para a aba **Home**
2. Você deve ver o restaurante "Pizza do João"
3. Clicar nele
4. Ver o produto "Pizza Margherita"

---

## 📍 5. Troubleshooting

### Problema: "Connection refused" ou "Unable to connect"

**Causa:** Backend não está rodando ou está em outro IP

**Solução:**
1. Verifique se o backend está rodando: `curl http://localhost:8080/restaurantes`
2. Se estiver em outro PC, use o IP correto em `api_constants.dart`
3. Verifique firewall do PC com backend (porta 8080)

---

### Problema: CORS Error

**Frontend no navegador complains:** 
```
Access to XMLHttpRequest blocked by CORS policy
```

**Solução:**
- Isso foi corrigido no `CorsConfig.java`
- Se o problema persistir, reinicie o backend

---

### Problema: "No database selected" ou erro de banco de dados

**Solução:**
- O H2 é um banco em memória
- Dados desaparecem ao reiniciar o backend
- Para persistir, altere em `application.properties`:
  ```properties
  spring.datasource.url=jdbc:h2:file:./data/delivery
  ```

---

### Problema: Flutter não encontra o backend

**Verifique:**
1. Backend rodando? `curl http://localhost:8080`
2. URL no `api_constants.dart` está correta?
3. Se for rede local: ambos na mesma rede WiFi?
4. Firewall bloqueando porta 8080?

---

## 📦 6. Implantação

### Para Produção com PostgreSQL

**1. Adicionar dependência no `build.gradle`:**
```groovy
runtimeOnly 'org.postgresql:postgresql:42.7.1'
```

**2. Criar `application-prod.properties`:**
```properties
spring.datasource.url=jdbc:postgresql://SEU_HOST:5432/delivery
spring.datasource.username=usuario
spring.datasource.password=senha
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=validate
```

**3. Executar:**
```bash
./gradlew bootRun --args='--spring.profiles.active=prod'
```

---

### Deploy do Backend

#### Opção 1: Docker

**Dockerfile:**
```dockerfile
FROM openjdk:17-slim
COPY build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
EXPOSE 8080
```

```bash
./gradlew build
docker build -t delivery-backend .
docker run -p 8080:8080 delivery-backend
```

#### Opção 2: Heroku
```bash
heroku login
heroku create seu-app-backend
git push heroku main
```

---

### Deploy do Frontend

#### APK (Android)
```bash
cd mobile/delivery_app_frontend
flutter build apk --release
# Arquivo em: build/app/outputs/apk/release/app-release.apk
```

#### iOS
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web --release
# Fazer upload da pasta build/web para seu servidor
```

---

## 🎯 Checklist Final

- [ ] Backend rodando em `http://localhost:8080` (ou IP correto)
- [ ] Frontend com URL correta em `api_constants.dart`
- [ ] Flutter `pub get` executado
- [ ] Sem erros ao executar `flutter analyze`
- [ ] App Flutter consegue listar restaurantes
- [ ] App consegue criar novo restaurante
- [ ] Logs do Dio aparecem corretamente no console

---

## 🔗 Referências

- [Spring Boot Docs](https://spring.io/projects/spring-boot)
- [Flutter Docs](https://flutter.dev/docs)
- [Dio Package](https://pub.dev/packages/dio)
- [Riverpod Docs](https://riverpod.dev)

---

**Dúvidas?** Abra uma issue no repositório! 🚀

