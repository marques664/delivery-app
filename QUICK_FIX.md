# 🚀 QUICK START - 5 Minutos para Integração Funcionar

## ⚡ TL;DR (Resumão)

### Backend
```powershell
cd delivery_app_backend
./gradlew bootRun
# Sucesso: http://localhost:8080/restaurantes retorna []
```

### Frontend
```bash
cd mobile/delivery_app_frontend
flutter pub get
flutter run
```

---

## 🔧 CONFIGURAÇÃO PARA REDE LOCAL

Se o **backend está em OUTRO PC**:

### 1️⃣ Encontrar IP da máquina com backend

**No PC onde backend roda:**
```powershell
ipconfig

# Procure por "IPv4 Address" - será algo como:
# IPv4 Address. . . . . . . . . . : 192.168.1.100
```

### 2️⃣ Editar file no frontend

**Arquivo:** `lib/core/constants/api_constants.dart`

```dart
// De:
static const String baseUrl = 'http://localhost:8080';

// Para:
static const String baseUrl = 'http://192.168.1.100:8080';
// ☝️ Use o IP encontrado acima
```

### 3️⃣ Testar conexão

```bash
# No PC onde backend roda, execute:
curl http://192.168.1.100:8080/restaurantes
```

---

## ✅ Verificação Rápida

### Backend
- [ ] Terminal mostra: `Started DeliveryApplication`
- [ ] Curl retorna: `curl http://localhost:8080/restaurantes`

### Frontend
- [ ] Sem erros de compilação
- [ ] Logs do Dio mostram requisições (console)
- [ ] Tela inicial mostra lista vazia ou restaurantes

---

## ❌ Erro Comum: Connection Refused

**Vai acontecer:** `Connection refused` no app Flutter

**Solução rápida:**
1. Cheque URL: `http://localhost:8080/restaurantes` no navegador
2. Se não funcionar: Backend não está rodando
3. Se funcionar mas app não conecta: URL no `api_constants.dart` está errada

**Debug:**
```dart
// Veja os logs do Dio no console do Flutter:
// Deve mostrar a URL real sendo usada
```

---

## 📱 Testar no Emulador Android

```bash
flutter emulators --launch Pixel_5_API_33
# Esperar abrir
flutter run
```

---

## 🌍 Testar no Browser (Web)

```bash
flutter run -d chrome
```

---

## 💾 Dados Persistem?

**NÃO** - banco H2 em memória apaga ao reiniciar backend.

Para persistir dados, editar `application.properties`:
```properties
# De:
spring.datasource.url=jdbc:h2:mem:testdb

# Para:
spring.datasource.url=jdbc:h2:file:./data/delivery
```

---

## ✨ Próximos Passos

1. ✅ Backend rodando
2. ✅ Frontend conectando
3. 📝 Criar dados de teste
4. 🧪 Implementar Features (carrinho, pedidos, etc)
5. 📦 Deploy

---

**Tá tudo funcionando?** Parabéns! 🎉

