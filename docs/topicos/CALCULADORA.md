# Calculadora: programa e datapath

O programa fica em ROM 32×16 e o datapath trabalha com 32 bits e 16 registradores. A ISA de estudo é nova: HALT, LI, ADD, SUB, AND, OR e XOR. O formato normal usa quatro campos de quatro bits; LI usa os oito bits baixos como imediato com sinal.

ROM demonstra r1=5, r2=7, r3=r1+r2 e HALT. Para alterar o programa nesta edição, edite rom.sv e simule de novo. Não há carregamento dinâmico. Opcodes 7–15 geram fault, e todos os registradores são graváveis.

**Atividade:** identifique as linhas da ROM para 5+7 e acompanhe o enable de escrita do banco até resultado=12. Explique quais campos mudariam para subtrair os dois operandos.

[Código e arquivos](../../rtl/calculadora/README.md) · [Formato completo](../ARQUITETURA.md)
