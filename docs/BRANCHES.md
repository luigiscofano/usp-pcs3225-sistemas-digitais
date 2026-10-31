# Branches e entregas

Use `main` para clonar e executar a versão consolidada. As branches abaixo preservam o ponto de entrega de cada assunto; depois da integração, podem estar atrás de `main`.

Cada branch está ligada a uma alteração concreta. A organização foi feita nesta edição: os nomes não indicam trabalho em datas antigas nem revisão de outras pessoas.

| Branch | Finalidade | Acesso |
| --- | --- | --- |
| `main` | Código e documentação consolidados | [Abrir](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/tree/main) |
| `docs/evidencia-da-ci` | Registrar validacao remota e artefatos reproduziveis | [PR #5](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/pull/5) |
| `docs/objetivos-e-arquitetura` | Documentar objetivos pedagogicos, arquitetura e procedencia | [PR #4](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/pull/4) |
| `feat/aplicacoes-e-acervo` | Adicionar calculadora e nucleo didatico RISC-V | [PR #2](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/pull/2) |
| `feat/fundamentos` | Implementar Double-Dabble sequencial parametrizado | [PR #1](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/pull/1) |
| `test/verificacao-automatica` | Adicionar testes executaveis e GitHub Actions | [PR #3](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/pull/3) |
| `docs/conversor-bcd` | Guia de Double-Dabble e leitura de formas de onda | [Guia](../docs/topicos/BCD.md) · [Branch](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/tree/docs/conversor-bcd) |
| `docs/calculadora-programavel` | Guia da calculadora e de sua ISA de estudo | [Guia](../docs/topicos/CALCULADORA.md) · [Branch](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/tree/docs/calculadora-programavel) |
| `docs/nucleo-riscv` | Guia de formatos RISC-V, memória e traps | [Guia](../docs/topicos/RISCV.md) · [Branch](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/tree/docs/nucleo-riscv) |

## Como continuar

Parta da versão atual de `main`, crie uma branch para uma mudança delimitada e abra um PR explicando comportamento, motivo e validação. Não use branches antigas como base para novos assuntos sem atualizar a base.

```sh
git switch main
git pull --ff-only
git switch -c docs/nova-atividade
```

[Guias por assunto](topicos/README.md) · [Registro de publicação](PUBLICACAO.md) · [Todos os PRs](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/pulls?q=is%3Apr)
