# ⚡ COMECE AQUI - Integração Backend + Frontend

## 🎯 Objetivo
Fazer seu app Flutter se conectar ao backend Spring Boot e exibir dados em tempo real.

---

## ✅ O que foi feito?

### 5 Problemas Identificados e CORRIGIDOS:

1. ❌ **Faltava arquivo de configuração do Spring Boot**
   - ✅ Criado: `application.properties`

2. ❌ **Frontend em outro PC não conseguia conectar ao backend**
   - ✅ Corrigido: `CorsConfig.java` agora aceita múltiplos IPs

3. ❌ **Endpoint GET /{id} não existia no RestaurantController**
   - ✅ Adicionado: `GET /restaurantes/{id}`

4. ❌ **Desenvolvedor não sabia como configurar URL do backend**
   - ✅ Documentado: `api_constants.dart` com comentários

5. ❌ **Logs do Dio eram confusos e não ajudavam no debug**
   - ✅ Melhorado: Logging visual com emojis e bordas

---

## 🚀 PRÓXIMOS PASSOS (Escolha 1 opção)

### Opção A: Backend no MESMO PC (Mais simples) ✅

#### Passo 1: Iniciar o Backend
```powershell
cd C:\Users\Windows\Desktop\Gustavo\git_projects\delivery-app\delivery_app_backend
./gradlew bootRun
```

**Espere até ver:**
```
Started DeliveryApplication in 5.xxx seconds
```

#### Passo 2: Verificar se está funcionando
```bash
# Em outro terminal PowerShell:
Invoke-WebRequest http://localhost:8080/restaurantes
# Deve retornar: []
```

#### Passo 3: Iniciar o Frontend
```bash
cd C:\Users\Windows\Desktop\Gustavo\git_projects\delivery-app\mobile\delivery_app_frontend
flutter pub get
flutter run
```

**Pronto!** ✅ Seu app deve conectar e puxar dados do backend!

---

### Opção B: Backend em OUTRO PC (Mesma rede WiFi)

#### Passo 1: Encontrar IP do PC com backend
**No PC onde será rodado o backend:**
```powershell
ipconfig
# Procure por "IPv4 Address"
# Exemplo: 192.168.1.100
```

#### Passo 2: Editar arquivo do Frontend
**Arquivo:** `mobile/delivery_app_frontend/lib/core/constants/api_constants.dart`

```dart
// De:
static const String baseUrl = 'http://localhost:8080';

// Para (use seu IP):
static const String baseUrl = 'http://192.168.1.100:8080';
```

#### Passo 3-5: Seguir os mesmos passos da Opção A

---

## 📱 Testar no Emulador Android

```bash
# Se não tiver um emulador criado:
flutter emulators --launch Pixel_5_API_33

# Esperar abrir, depois:
flutter run
```

---

## 🌐 Testar no Browser

```bash
flutter run -d chrome
```

---

## 🧪 Verificar se está funcionando

### No App Flutter:
1. Abrir app
2. Ir para aba "Home"
3. Deve ver lista vazia ou restaurantes
4. Sem erros de conexão

### No Console (Logs):
Procure por algo assim:
```
═════════════════════════════════════════
[Dio] 🌐 REQUEST
[Dio] URL: http://localhost:8080/restaurantes
[Dio] Method: GET
═════════════════════════════════════════
═════════════════════════════════════════
[Dio] ✅ RESPONSE
[Dio] Status: 200
[Dio] Data: []
═════════════════════════════════════════
```

Se ver isso, **está funcionando corretamente!** 🎉

---

## ❌ Se der erro

### "Connection refused"
```
Significado: Backend não está rodando
Solução: Abra outro terminal e execute ./gradlew bootRun
```

### "CORS Error" (no navegador)
```
Significado: Backend rejeitou requisição da origem
Solução: Pode acontecer em localhost:port, reinicie backend
```

### "Timeout" (requisição demora)
```
Significado: Backend muito lento ou não é acessível
Solução: Verifique firewall, check IP/porta está correta
```

---

## 📚 Documentação Completa

Leia os arquivos criados na ordem:

1. **QUICK_FIX.md** ← Resumão de 5 minutos
2. **INTEGRACAO_GUIA.md** ← Guia passo a passo completo
3. **ARQUITETURA.md** ← Entender como funciona
4. **MUDANCAS_REALIZADAS.md** ← O que foi alterado

---

## 💡 Próximas Features para Implementar

Agora que integração está funcionando:

- [ ] Listar restaurantes na Home
- [ ] Ver detalhes do restaurante
- [ ] Ver produtos do restaurante
- [ ] Carrinho de compras
- [ ] Fazer pedido
- [ ] Acompanhar status do pedido
- [ ] Histórico de pedidos

---

## 🔗 Endpoints Disponíveis

```
GET  http://localhost:8080/restaurantes
GET  http://localhost:8080/restaurantes/{id}
POST http://localhost:8080/restaurantes

GET  http://localhost:8080/produtos
GET  http://localhost:8080/produtos/{id}
GET  http://localhost:8080/produtos/restaurante/{id}
POST http://localhost:8080/produtos

GET  http://localhost:8080/pedidos
GET  http://localhost:8080/pedidos/{id}
POST http://localhost:8080/pedidos
PUT  http://localhost:8080/pedidos/{id}/status
```

---

## 🆘 Precisa de Ajuda?

1. **Erro de compilação?**
   - Execute: `./gradlew clean build`
   - Verifique Java 17+: `java -version`

2. **Erro de conexão?**
   - Verifique firewall está liberando porta 8080
   - Confira URL em `api_constants.dart`

3. **Banco de dados perdeu dados?**
   - Banco H2 em memória apaga ao reiniciar o backend
   - Para persistir, veja em INTEGRACAO_GUIA.md

4. **Outros problemas?**
   - Abra issue no GitHub
   - Compartilhe os logs do console

---

## ✨ Status Atual

```
Backend:    ✅ Compilado com sucesso
Frontend:   ✅ Pronto para conectar
Integração: ✅ Configurada e testada
Docs:       ✅ Completas e detalhadas
```

**Você está pronto para começar! 🚀**

---

**Última atualização:** 13 de Maio de 2026
**Sistema:** Windows PowerShell + Java 17 + Flutter
**Frameworks:** Spring Boot 4.0.6 + Flutter 3.11.0+

Boa sorte! 💪

