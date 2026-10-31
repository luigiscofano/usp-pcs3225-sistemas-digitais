# PCS3225 · Double-Dabble, calculadora e RISC-V

> Três projetos independentes em SystemVerilog: conversor binário–BCD, calculadora com ISA de estudo e núcleo de subconjunto RISC-V, com testbenches e formas de onda.

![Visão geral de PCS3225 · Double-Dabble, calculadora e RISC-V](assets/capa.svg)

[![Verificação](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/actions/workflows/verificacao.yml/badge.svg?branch=main)](https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais/actions/workflows/verificacao.yml)

[O que faz](#o-que-este-projeto-faz) · [Módulos](#funcionalidades-e-módulos) · [Executar](#como-executar) · [Aprendizagem](#o-que-desenvolvi-e-aprendi) · [Estado atual](#estado-atual) · [Documentação](#documentação-e-navegação)

## O que este projeto faz

Reúne três estudos de **Sistemas Digitais II — PCS3225**. O conversor transforma um número binário em dígitos decimais; a calculadora executa uma pequena ROM de instruções; o núcleo RISC-V decodifica e executa um subconjunto de instruções de 32 bits. São circuitos descritos em SystemVerilog e executados em **simulação**, não três modos de um aplicativo de terminal.

## Qual problema resolve

O projeto torna observável o caminho entre algoritmo e sinais: o que deve ser armazenado em registradores, qual ação a máquina de estados libera a cada clock e como uma instrução altera dados ou controle. Testbenches aplicam estímulos e verificam resultados; arquivos VCD guardam os sinais para inspeção.

## Funcionalidades e módulos

| Projeto independente | Entrada → saída | Código |
| --- | --- | --- |
| Double-Dabble | Número binário + start → dígitos BCD + done | [rtl/double_dabble/](rtl/double_dabble/README.md) |
| Calculadora | Programa de ROM → registradores, resultado e fim/falha | [rtl/calculadora/](rtl/calculadora/README.md) |
| Núcleo RISC-V | Instruções e memória fornecidas pelo ambiente → execução e trap | [rtl/riscv/](rtl/riscv/README.md) |

### 1. Double-Dabble e handshake

BCD representa cada dígito decimal em quatro bits. O algoritmo corrige nibbles maiores ou iguais a cinco somando três e desloca o próximo bit. A máquina de estados passa por INIT, CORRECT, SHIFT e WAIT. `start` captura a entrada; `done` e o resultado permanecem em WAIT até a liberação de `start`.

A parametrização foi testada com **8 e 18 bits**; a versão de 18 bits produz seis dígitos BCD. Para 42 decimal, a saída BCD termina em `0x42`, embora o binário de entrada seja `0x2A`. O controle e os dados estão agrupados no módulo sequencial, sem presumir arquivos UC e FD fisicamente separados.

### 2. Calculadora programável

Tem datapath de 32 bits, 16 registradores e ROM 32×16. A ISA desta edição contém HALT, LI, ADD, SUB, AND, OR e XOR. O programa de demonstração carrega 5 e 7, soma em r3 e termina com resultado 12. Para mudar o programa, edite a ROM e simule novamente: não há carregamento dinâmico de instruções.

Essa é uma **ISA de estudo própria**, distinta de RISC-V e identificada como nova na documentação. Opcodes não implementados acionam `fault`.

### 3. Núcleo RISC-V

Implementa ADDI, ADD, SUB, AND, OR, XOR, LW, SW, BEQ, BNE, LUI, AUIPC, JAL e JALR. Reconstrói imediatos I/S/B/U/J, preserva x0, acessa palavras alinhadas e sinaliza instrução ilegal ou desalinhamento por `trap` persistente. O testbench fornece memória e programas.

É um subconjunto didático, **não RV32I completo ou certificado**. Não há pipeline, cache, interrupções, CSRs, privilégios ou espera no barramento. Não depende da ISA da calculadora anterior.

## Como executar

**Requisitos:** Python 3.12, Icarus Verilog 12+ (`iverilog` e `vvp` no PATH), Git. GTKWave é opcional para inspecionar o VCD. Não é necessário possuir placa FPGA.

```sh
git clone https://github.com/luigiscofano/usp-pcs3225-sistemas-digitais.git
cd usp-pcs3225-sistemas-digitais
```

```sh
iverilog -V
vvp -V
python scripts/verificar.py
python scripts/figuras.py
```

O verificador compila e executa os testbenches `digitais_tb` e `riscv_tb`; falhas encerram a simulação. O segundo comando converte a captura real de Double-Dabble em `assets/double_dabble_42.svg` e preserva uma versão do VCD. O VCD original fica em `build/double_dabble.vcd`.

### Ler a forma de onda

```sh
gtkwave build/double_dabble.vcd
```

Observe reset, `start`, alternância CORRECT/SHIFT e a chegada a `done`. O SVG pode ser aberto no navegador sem GTKWave:

![Conversão real de 42 e sinais do handshake](assets/double_dabble_42.svg)

No Windows, use uma instalação compatível do Icarus ou um terminal WSL com as ferramentas no PATH. Se `python` não existir, use `python3`. Os scripts não instalam o simulador nem o GTKWave.

## O que desenvolvi e aprendi

As implementações desta edição relacionam conversão numérica, máquinas de estados, bancos de registradores, ULA, controle e formatos de instrução. Os testes e a geração de figuras conectam a explicação ao sinal observado. A [procedência](docs/PROCEDENCIA.md) distingue temas acadêmicos recuperados e decisões novas.

**Objetivos pedagógicos:** rastrear a conversão de 42, explicar o handshake, seguir uma instrução da ROM até a escrita e provocar uma falha controlada com uma palavra ilegal. [Atividades e rubrica](docs/OBJETIVOS_PEDAGOGICOS.md).

## Estado atual

| Disponível | Limite / evolução |
| --- | --- |
| Conversor W8/W18 e handshake | Sem validação para parâmetros arbitrários |
| Calculadora e programa 5+7 | ROM editável no fonte; sem upload dinâmico |
| Núcleo e programas de teste | Subconjunto de 14 instruções |
| VCD, SVG e testes | Sem síntese, pinagem, timing ou ensaio em FPGA nesta edição |

## Validação e limites

Há 1.005 conversões de 18 bits, teste exaustivo das 256 entradas de 8 bits, reset/handshake, programa da calculadora e cenários do núcleo. A simulação não constitui cobertura completa de ISA ou certificação física. A [validação](docs/VALIDACAO.md) explicita os casos exercitados.

O repositório [usp-labdig](https://github.com/luigiscofano/usp-labdig) contém os experimentos de Laboratório Digital e seus jogos; este concentra conversão e arquitetura de processadores da disciplina PCS3225.

## Documentação e navegação

[RTL](rtl/README.md) · [Testbenches](tests/README.md) · [Scripts](scripts/README.md) · [Formas de onda](assets/README.md) · [Guias por projeto](docs/topicos/README.md) · [Documentação](docs/README.md) · [Arquitetura e ISA](docs/ARQUITETURA.md) · [Branches](docs/BRANCHES.md) · [PRs](docs/PUBLICACAO.md)


## Autoria, referências e licença

**Luigi Scofano de Araujo · Engenharia de Computação, Poli-USP · USP 13680334.** Fontes recuperados, componentes de terceiros e trabalhos em grupo mantêm os créditos indicados nos arquivos e na documentação.

[Direitos e créditos](DIREITOS_E_CREDITOS.md) · [Procedência](docs/PROCEDENCIA.md) · [Como contribuir](CONTRIBUTING.md) · [Mudanças](CHANGELOG.md)

## Tópicos do repositório

`systemverilog` · `digital-design` · `double-dabble` · `bcd` · `risc-v` · `rv32i` · `datapath` · `finite-state-machine` · `icarus-verilog` · `computer-architecture` · `usp`
