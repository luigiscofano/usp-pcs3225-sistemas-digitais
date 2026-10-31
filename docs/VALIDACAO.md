# Validação

## Evidência local — 31/10/2026

1.005 conversões W18; 256 conversões W8 exaustivas; reset e handshake; programa 5+7 da calculadora; programa RV32 com memória, branches, saltos, ULA, x0 e traps. Cobertura por cenários, sem certificação ISA.

## Limites da conclusão

Sem síntese Quartus, placa ou pinagem; calculadora com ISA nova e ROM editável; RV32I apenas subconjunto declarado; sem prova formal ou cobertura completa de instruções.

Um workflow configurado ou PR aberto não demonstra aprovação. A evidência remota e o commit testado serão registrados após conclusão do GitHub Actions.

O [registro local estruturado](validacao-local.json) preserva o comando e o log efetivamente obtidos.

## Evidência remota confirmada

[Execução 41227733916](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/actions/runs/41227733916) aprovada no commit `3691c5b369180a029171565ae9d36600696f04d8`.

- **testes (ubuntu-24.04)**: success.

Os artefatos podem exigir login no GitHub e têm prazo de retenção; os fontes permanecem no repositório.

- [evidencia-ubuntu-24.04](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/actions/runs/41227733916/artifacts/13052671215) — retenção até 2027-01-29T18:06:10Z.

O commit acima identifica exatamente a versão testada. Atualizações documentais posteriores não ampliam a conclusão funcional.
