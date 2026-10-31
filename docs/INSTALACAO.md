# Instalação e reprodução

Ambiente: **SystemVerilog 2012, Icarus Verilog 12+ e Python 3.12**. Execute a partir da raiz. Use python ou python3 conforme seu sistema.

```sh
python scripts/verificar.py
python scripts/figuras.py
# Opcional, em ambiente gráfico:
gtkwave build/double_dabble.vcd
```

Artefatos gerados ficam em build/, ignorado pelo Git. O script deve encerrar com zero em sucesso. Em falha, confira versão, PATH, diretório corrente e fixture antes de alterar o contrato. Os scripts não contêm caminhos do computador do autor.

Consulte [ARQUITETURA.md](ARQUITETURA.md) para entradas e limites e [VALIDACAO.md](VALIDACAO.md) para a evidência efetiva.
