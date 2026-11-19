# sistema-escolar-sql

Projeto de banco de dados para gerenciamento escolar - MySQL.

## Arquivos

| Arquivo | Descrição |
|---|---|
| `escola.sql` | Script completo: banco, tabelas, INSERT, UPDATE, DELETE e 4 views |
| `diagrama_escola.png` | Diagrama ER (4 tabelas, 3 relacionamentos) |
| `tutorial_passo_a_passo.pdf` | Tutorial interativo (índice clicável, imagens e checklist) |

## Como executar

```bash
mysql -u root -p < escola.sql
```

O DELETE do desafio (passo 5.3) está comentado no script, pois gera erro 1451 de propósito (chave estrangeira).
