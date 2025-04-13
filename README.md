# routina

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Routina

**Routina** é um aplicativo de gerenciamento de tarefas desenvolvido com Flutter, pensado especialmente para pessoas dentro do espectro autista ou com dificuldades de adaptação a mudanças de rotina. O objetivo principal do app é oferecer uma interface simples, acolhedora e funcional, que auxilie na criação e organização de tarefas com foco em previsibilidade e conforto.

## 🧠 Propósito do Projeto

Pessoas com TEA ou dificuldades de adaptação geralmente sentem desconforto com mudanças repentinas na rotina. Por isso, o Routina vai além de apenas listar tarefas: ele será capaz de prever possíveis quebras de rotina ao inserir novas tarefas, alertando o usuário com sugestões ou confirmações para manter a consistência.

## ✅ O que já foi feito até agora

- **Definição do conceito do app**
  - Criado com base em empatia e acessibilidade.
  - Foco em usabilidade, clareza e conforto visual.
  
- **Wireframes**
  - Telas desenhadas com foco em simplicidade e UX acessível.
  - Inclui telas como Home, Lista de Tarefas, Adição de Tarefas, Configurações e Login.

- **Nome do App**
  - Após brainstorming, o nome **Routina** foi definido por transmitir organização e rotina de maneira suave.

- **Criação do projeto Flutter**
  - Projeto inicializado com o comando `flutter create routina`.
  - SDK Dart atualizado para 3.7.2.
  - Uso de `Stateful` e `Stateless` widgets relembrado e aplicado.

- **Estrutura de pastas**
  - Telas adicionadas à pasta `lib/` com organização modular.
  - `main.dart` configurado para importar e exibir a tela Home.

- **Implementação de Widgets**
  - Uso de `Container`, `Column`, `Row`, `IconButton`, `Text`, entre outros.
  - Centralização e alinhamento configurados com `Alignment`, `MainAxisAlignment`, e `CrossAxisAlignment`.
  - Testes com `Icons.check_circle_outline` e ícones relacionados a listas de tarefas.

- **Design e UX**
  - Testado alinhamento com `TopCenter`, `CenterLeft`, entre outros.
  - Aplicado `Container` com `alignment`, `margin`, `padding` e `border` personalizados.
  - Fontes e tamanhos ajustados para melhor leitura.

- **Tratamento de Logs**
  - Substituição do `print()` por uso da biblioteca `logger` para práticas seguras em produção.
  - Configuração do `.gitignore` para ignorar arquivos desnecessários no Git.

- **Controle de Versão**
  - Projeto iniciado com Git.
  - Projeto criado e estruturado para ser hospedado no GitHub.

## 📌 Próximos passos

- [ ] Implementar lógica para detectar possíveis quebras de rotina ao adicionar tarefas.
- [ ] Criar sistema de login com fluxo condicional para usuários logados e visitantes.
- [ ] Melhorar visual com animações e transições suaves.
- [ ] Finalizar persistência de dados (com banco local ou Firebase).
- [ ] Publicar app em fase beta para testes com público-alvo.

## 🛠 Tecnologias utilizadas

- **Flutter** (SDK 3.7.2)
- **Dart**
- **Logger**
- **Git e GitHub**

## 📚 Recursos Úteis

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter API Reference](https://api.flutter.dev/)

---

*Este projeto está em desenvolvimento e será atualizado constantemente com melhorias baseadas em testes e feedback de usuários reais.*

