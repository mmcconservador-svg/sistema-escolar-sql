# sistema-escolar-sql

Projeto de banco de dados para gerenciamento escolar - MySQL.

## Arquivos

| Arquivo | Descrição |
|---|---|
| `escola.sql` | Script completo: banco, tabelas, INSERT, UPDATE, DELETE e 4 views |
| `escola.mwb` | Modelo do MySQL Workbench (4 tabelas, 3 chaves estrangeiras) |
| `diagrama_escola.png` | Diagrama ER (4 tabelas, 3 relacionamentos) |
| `tutorial_passo_a_passo.pdf` | Tutorial interativo (índice clicável, imagens e checklist) |

## Como executar

```bash
mysql -u root -p < escola.sql
```

O DELETE do desafio (passo 5.3) está comentado no script, pois gera erro 1451 de propósito (chave estrangeira).

## Testes realizados

Script executado do zero sem erros: 4 tabelas criadas, 15 alunos inseridos (14 após o DELETE), 12 associações professor-turma (11 após o DELETE), UPDATEs conferidos, erro 1451 confirmado no desafio 5.3 e as 4 views retornando os dados esperados.
