# Núcleo RISC-V: subconjunto declarado

Instruções implementadas: ADDI, ADD, SUB, AND, OR, XOR, LW, SW, BEQ, BNE, LUI, AUIPC, JAL e JALR. Isso não é RV32I completo nem núcleo certificado.

| Componente | Decisão observável |
| --- | --- |
| Gerador de imediatos | Reconstrói campos I/S/B/U/J com sinal |
| Registradores | x0 não aceita escrita |
| Memória | LW/SW com alinhamento de quatro bytes |
| Saltos | PC e destinos tomados alinhados; JALR limpa bit zero |
| Falhas | trap persistente e escritas desabilitadas |

```sh
python scripts/verificar.py
```

**Atividade:** acompanhe o programa de testes desde ADDI até SW/LW e BEQ. Depois troque uma instrução por uma palavra ilegal e preveja trap e ausência de escrita.

O ambiente fornece memória combinacional e fiscaliza seus limites. Não há wait states, pipeline, cache ou interrupções. FPGA requer síntese, constraints e verificação física separadas.

[Módulos](../../rtl/riscv/README.md) · [Arquitetura](../ARQUITETURA.md)
