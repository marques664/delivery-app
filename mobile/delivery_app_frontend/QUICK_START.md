# 🏃‍♂️ Quick Start - Execute em 5 Minutos

## 1. Verificar Dependências ✅
```bash
# Já foi feito! Todas as dependências estão instaladas
# Confirmar:
flutter pub get        # ~2 minutos
flutter analyze        # 0 erros, apenas warnings (info)
```

## 2. Configurar Backend 🔧
Editar arquivo:
```
lib/core/constants/api_constants.dart
```

Atual:
```dart
static const String baseUrl = 'http://localhost:8080';
```

Substituir por seu IP (ex: seu backend rodando em máquina local):
```dart
static const String baseUrl = 'http://192.168.x.x:8080';
// ou
static const String baseUrl = 'http://seu-dominio.com';
```

## 3. Executar Aplicativo 🚀
```bash
# iOS Simulator/Emulador Android
flutter run

# Ou especificar device
flutter run -d "device-id"

# Com verbose para debug
flutter run -v
```

## 4. Testar Fluxo Completo 🧪

### Tela Home
1. App abre ✅
2. Lista de restaurantes carrega ✅
3. Tap em restaurante navega ✅
4. Pull-to-refresh funciona ✅

### Tela Restaurant Detail
1. Produtos do restaurante carregam ✅
2. Badge de carrinho mostra quantidade ✅
3. Tap em "+" adiciona ao carrinho ✅

### Tela Cart
1. Items aparecem listados ✅
2. Incrementar/decrementar quantidade funciona ✅
3. Total calcula automaticamente ✅
4. Botão "Finalizar Pedido" navega ✅

### Tela Checkout
1. Resumo mostra todos items ✅
2. Total está correto ✅
3. Botão "Confirmar" cria pedido ✅
4. Redireciona para tracking ✅

### Tela Order Tracking
1. Número do pedido aparece ✅
2. Timeline mostra status ✅
3. Informações do restaurante aparecem ✅
4. Items do pedido listados ✅

## 5. Debugging 🐛

### Ver Logs HTTP
Automaticamente imprime todas as requisições:
```
[Dio] Request: GET /restaurantes
[Dio] Headers: {...}
[Dio] Response: 200 /restaurantes
```

### Verificar Erros
```bash
flutter analyze
```

### Usar Flutter DevTools
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

## 6. Estrutura de URLs Esperada

Seu backend deve ter:
```
GET    /restaurantes           → List<Restaurant>
POST   /restaurantes           → Restaurant
GET    /restaurantes/:id       → Restaurant

GET    /produtos               → List<Product>
GET    /produtos/restaurante/:id → List<Product>
POST   /produtos               → Product
GET    /produtos/:id           → Product

GET    /pedidos                → List<Order>
GET    /pedidos/:id            → Order
POST   /pedidos                → Order
PUT    /pedidos/:id/status     → Order
```

## 7. JSON Esperado

### Restaurant
```json
{
  "id": 1,
  "nome": "Restaurante X",
  "endereco": "Rua Y, 123"
}
```

### Product
```json
{
  "id": 1,
  "nome": "Pizza Margherita",
  "preco": 35.90,
  "restaurante": {
    "id": 1,
    "nome": "Restaurante X",
    "endereco": "Rua Y, 123"
  }
}
```

### Order (Resposta)
```json
{
  "id": 1,
  "status": "CRIADO",
  "total": 71.80,
  "restaurante": {
    "id": 1,
    "nome": "Restaurante X",
    "endereco": "Rua Y, 123"
  },
  "itens": [
    {
      "id": 1,
      "quantidade": 2,
      "produto": {
        "id": 1,
        "nome": "Pizza Margherita",
        "preco": 35.90,
        "restaurante": { "id": 1 }
      }
    }
  ]
}
```

### Order (Request)
```json
{
  "restaurante": {
    "id": 1
  },
  "itens": [
    {
      "produto": {
        "id": 1
      },
      "quantidade": 2
    }
  ]
}
```

## 8. Problemas Comuns & Soluções

### Erro: conexão recusada
```
❌ Erro: Connection refused to 127.0.0.1:8080

✅ Solução:
1. Backend não está rodando
2. Usar IP correto (não localhost)
3. Verificar firewall
4. Porta incorreta
```

### Erro: JSON parsing
```
❌ Erro: type 'Null' is not a subtype of type 'String'

✅ Solução:
1. Resposta da API não corresponde ao modelo
2. Nome do campo em JSON diferente
3. Tipo de dado errado
4. Campo obrigatório vazio
```

### Erro: timeout
```
❌ Erro: Timeout while connecting to the server

✅ Solução:
1. Backend lento
2. Aumentar timeout em ApiConstants
3. Verificar conexão de rede
4. Backend offline
```

### UI não atualiza
```
❌ Problema: Tela não recarrega após ação

✅ Solução:
1. Usar ref.invalidate(provider) para recarregar
2. Verificar se widget é ConsumerWidget
3. State não está sendo alterado
4. Provider não está sendo witnessado
```

## 9. Versões Importantes

Verifique o seu:
```bash
flutter --version
dart --version
```

Esperado:
- Flutter: 3.x
- Dart: 3.x

## 10. Performance Tips

### Para Development
- ✅ Usar `flutter run` sem release
- ✅ Hot reload automático
- ✅ Logging debug

### Para Production
- ✅ Build release: `flutter build apk --release`
- ✅ Remove debug logging
- ✅ Enable obfuscation

## 11. Estrutura de Commits Recomendada

```bash
# Feature nova
git checkout -b feature/nova-funcionalidade

# Commit padrão
git commit -m "feat: adiciona nova tela"
git commit -m "fix: corrige bug no carrinho"
git commit -m "style: formata código"
git commit -m "docs: atualiza documentação"

# Push
git push origin feature/nova-funcionalidade

# Pull request
```

## 12. Documentação Detalhada

Para mais informações, ver:
- `ARCHITECTURE.md` - Decisões arquiteturais
- `SETUP_GUIDE.md` - Setup completo
- `IMPLEMENTATION_SUMMARY.md` - O que foi feito

## ✅ Checklist de Sucesso

- [ ] Backend rodando em http://seu-ip:8080
- [ ] `flutter pub get` executado
- [ ] `flutter analyze` sem erros (0 errors)
- [ ] `flutter run` liga o app
- [ ] Tela Home carrega restaurantes
- [ ] Navega entre telas corretamente
- [ ] Carrinho funciona
- [ ] Checout cria pedido
- [ ] Tracking mostra status

## 🎉 Sucesso!

Se tudo passou no checklist, você tem um **app delivery totalmente funcional** pronto para:
- ✅ Desenvolvimento
- ✅ Publicação
- ✅ Feedback dos usuários
- ✅ Iteração e melhoria

---

**Próximos passos sugeridos:**
1. Integrar autenticação
2. Adicionar persistência local
3. Implementar notificações push
4. Publicar nas stores
5. Coletar feedback

**Bom desenvolvimento!** 🚀

