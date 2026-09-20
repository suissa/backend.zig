# Zig Backend

Backend reescrito em Zig (versão 0.13.0) como prova de conceito.

## Pré-requisitos

- Zig 0.13.0 ou superior

## Estrutura do Projeto

```
zig_backend/
├── build.zig              # Script de build do Zig
├── src/
│   └── server.zig         # Servidor HTTP básico
├── tests/
│   ├── all_tests.zig      # Runner de testes
│   └── database_test.zig  # Testes do módulo Database
└── .gitignore
```

## Comandos

### Build do projeto
```bash
zig build
```

### Rodar testes
```bash
zig build test
```

### Build para release
```bash
zig build -Doptimize=ReleaseFast
```

## GitHub Actions

O workflow `.github/workflows/zig_tests.yml` valida automaticamente:
- Instalação do Zig
- Build do projeto
- Execução de todos os testes
- Build em modo ReleaseFast

## Notas Importantes

Esta é uma implementação mínima demonstrativa. O backend original do PocketBase 
contém ~84.000 linhas de código Go com funcionalidades complexas (SQLite, JWT, 
OAuth2, SMTP, etc.) que não possuem equivalentes maduros no ecossistema Zig atual.

Para um projeto de produção, recomenda-se:
1. Aguardar maturação do ecossistema Zig
2. Implementar gradualmente módulos específicos
3. Manter o backend Go existente para funcionalidades críticas
