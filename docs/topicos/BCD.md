# Double-Dabble: número, estado e clock

| Sinal | Papel |
| --- | --- |
| binary | Capturado ao iniciar |
| start | Mantido alto até observar done |
| done | Verdadeiro em WAIT |
| bcd | Resultado por nibbles, preservado em WAIT |
| rst | Reset síncrono que aborta a conversão |

INIT captura; CORRECT aplica add-3 a cada dígito ≥5; SHIFT incorpora o próximo bit. Após W iterações, WAIT mantém o resultado. Baixar start libera a próxima operação. Os tamanhos testados são W=8 e W=18.

```sh
python scripts/verificar.py
python scripts/figuras.py
gtkwave build/double_dabble.vcd
```

**Atividade:** acompanhe 42 na [captura real](../../assets/README.md). Diferencie binary=0x2A do BCD=0x42, e explique por que ambos representam o mesmo número em codificações distintas.

**Verificação:** casos exaustivos W8, 1.005 casos W18, reset e handshake. A forma de onda é simulada; não é captura de placa.
