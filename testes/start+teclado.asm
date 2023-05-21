; ****************************************************************************
; * Projeto primeira entrega
; * ist1105901 - Francisca Almeida
; * ist1106827 - Cecília Correia
; * ist1106943 - José Frazão

; * Descrição: Simula o jogo dos asteróides num computador de 16 bits.
; ****************************************************************************

; ****************************************************************************
; * Constantes

; ENDEREÇOS
COMANDOS				    EQU	6000H   ; endereço de base dos comandos do MediaCenter
MEMORIA_MC				    EQU	8000H   ; endereço de base da memória do MediaCenter
DISPLAYS                    EQU 0A000H  ; endereço dos displays de 7 segmentos (periférico POUT-1)
TEC_LIN                     EQU 0C000H  ; endereço das linhas do teclado (periférico POUT-2)
TEC_COL                     EQU 0E000H  ; endereço das colunas do teclado (periférico PIN)

; COMANDOS DE ESCRITA DO MEDIA CENTER
APAGA_ECRA                  EQU COMANDOS    ; comando que apaga todos os pixéis de um ecrã específico
APAGA_ECRAS                 EQU 6002H       ; comando que apaga todos os pixéis de todos os ecrãs
SELECIONA_ECRA              EQU 6004H       ; comando que seleciona o ecrã a ser utilizado
MOSTRA_ECRA                 EQU 6006H       ; comando que mostra o ecrã especificado
ESCONDE_ECRA                EQU 6008H       ; comando que esconde o ecrã especificado
DEFINE_LINHA                EQU 600AH       ; comando que define a linha
DEFINE_COLUNA               EQU 600CH       ; comando que define a coluna
DEFINE_PIXEL                EQU 600EH       ; comando que define o pixel
DEFINE_AUTO_INC             EQU 6010H       ; comando que define o auto-incremento
ALTERA_COR_PIXEL_C          EQU 6012H       ; comando que altera a cor do pixel corrente
DEFINE_COR_CANETA           EQU 6014H       ; comando que define a cor da caneta
ALTERA_COR_PIXEL_CAN_C      EQU 6016H       ; comando que altera a cor do pixel segundo a caneta
APAGA_PIXEL                 EQU 6018H       ; comando que apaga o pixel
ALTERA_COR_PIXEL_COR_CAN    EQU 601AH       ; comando que altera a cor do pixel corrente segundo a caneta
ALTERA_COR_8_PIXELS         EQU 601CH       ; comando que altera a cor de 8 pixels
ALTERA_COR_16_PIXELS        EQU 601EH       ; comando que altera a cor de 16 pixels
DESENHA_PADRAO              EQU 6020H       ; comando que desenha um padrão
DESENHA_PADRAO_GRADIENTE    EQU 6022H       ; comando que desenha um padrão com gradiente
APAGA_AVISO                 EQU 6040H       ; comando que apaga o cenário de fundo e elimina aviso
DEFINE_CENARIO              EQU 6042H       ; comando que define o cenário
APAGA_CENARIO_FRONTAL       EQU 6044H       ; comando que apaga o cenário frontal
DEFINE_CENARIO_FRONTAL      EQU 6046H       ; comando que define o cenário frontal
DEFINE_SOM_OU_VIDEO         EQU 6048H       ; comando que define o som/vídeo
DEFINE_VOLUME_SOM           EQU 604AH       ; comando que define o volume do som/vídeo
CORTA_SOM                   EQU 604CH       ; comando que corta o volume(mute) do som/vídeo
RETOMA_SOM                  EQU 604EH       ; comando que retoma o volume do som/vídeo
CORTA_SONS                  EQU 6050H       ; comando que corta os volumes(mute) de todos os sons/vídeos
RETOMA_SONS                 EQU 6052H       ; comando que retoma os volumes de todos os sons/vídeos
DEFINE_BRILHO               EQU 6054H       ; comando que define o brilho
DEFINE_PADRAO_TRANSICAO     EQU 6056H       ; comando que define o padrão de transição entre vídeos
DEFINE_NUM_REPETICOES       EQU 6058H       ; comando que define o número de vezes que um som/vídeo deve ser reproduzido
INICIA_REPRODUCAO           EQU 605AH       ; comando que inicia a reprodução do som/vídeo
REPRODUZ_EM_CICLO           EQU 605CH       ; comando que reproduz um som/vídeo em ciclo
PAUSA_SOM_OU_VIDEO          EQU 605EH       ; comando que pausa a reprodução do som/vídeo
CONTINUA_SOM_OU_VIDEO       EQU 6060H       ; comando que retoma a reprodução do som/vídeo
PAUSA_SONS_OU_VIDEOS        EQU 6062H       ; comando que pausa a reprodução de todos os sons/vídeos
CONTINUA_SONS_OU_VIDEOS     EQU 6064H       ; comando que retoma a reprodução de de todos os sons/vídeos
TERMINA_SOM_OU_VIDEO        EQU 6066H       ; comando que termina a reprodução do som/vídeo
TERMINA_SONS_OU_VIDEOS      EQU 6068H       ; comando que termina a reprodução de todos os sons/vídeos

; COMANDOS DE LEITURA DO MEDIA CENTER
NUM_COLUNAS_ECRA            EQU COMANDOS    ; comando que obtém o número de colunas do ecrã
NUM_LINHAS_ECRA             EQU 6002H       ; comando que obtém o número de linhas do ecrã
OBTEM_ECRA                  EQU 6004H       ; comando que obtém o ecrã
OBTEM_VISIBILIDADE          EQU 6006H       ; comando que obtém a visibilidade do ecrã
OBTEM_LINHA_POS_C           EQU 6008H       ; comando que obtém a linha da posição corrente
OBTEM_COLUNA_POS_C          EQU 600AH       ; comando que obtém a coluna da posição corrente
OBTEM_PIXEL_POS_C           EQU 600CH       ; comando que obtém o pixel da posição corrente
OBTEM_ESTADO_AUTO_INC       EQU 600EH       ; comando que obtém o estado do auto-incremento
OBTEM_COR_PIXEL_POS_C       EQU 6010H       ; comando que obtém a cor do pixel na posição corrente
OBTEM_COR_CANETA            EQU 6012H       ; comando que obtém a cor da caneta
OBTEM_ESTADO_COR_PIXEL_C    EQU 6014H       ; comando que obtém o estado da cor do pixel corrente
OBTEM_ESTADO_COR_8PIXELS_C  EQU 6016H       ; comando que obtém o estado da cor de 8 pixels
OBTEM_ESTADO_COR_16PIXELS_C EQU 6018H       ; comando que obtém o estado da cor de 16 pixels
OBTEM_NUM_IMAGENS           EQU 6040H       ; comando que obtém o número de imagens definidas
OBTEM_CENARIO_FUNDO         EQU 6042H       ; comando que obtém o cenário de fundo
OBTEM_CENARIO_FRONTAL       EQU 6044H       ; comando que obtém o cenário frontal
OBTEM_NUM_SONS_OU_VIDEOS    EQU 6046H       ; comando que obtém o número de sons/vídeos definidos
OBTEM_NUM_SOM_OU_VIDEO      EQU 6048H       ; comando que obtém o som/vídeo
OBTEM_VOLUME_SOM_OU_VIDEO   EQU 604AH       ; comando que obtém o volume do som/vídeo
OBTEM_MUTE_SOM_OU_VIDEO     EQU 604CH       ; comando que obtém o estado de mute do som/vídeo
OBTEM_BRILHO                EQU 604EH       ; comando que obtém o brilho
OBTEM_NUM_PADRAO_TRANSICAO  EQU 6050H       ; comando que obtém o padrão de transição
OBTEM_ESTADO_SOM_OU_VIDEO   EQU 6052H       ; comando que obtém o estado do som/vídeo
OBTEM_NUM_A_REPRODUZIR      EQU 6054H       ; comando que obtém o número de sons/vídeos a reproduzir
OBTEM_NUM_VEZES_A_REP       EQU 6056H       ; comando que obtém o número de vezes que o som/vídeo será reproduzido

; MEDIA
CENARIO_JOGO        EQU 1   ; número do cenário do fundo do jogo
CENARIO_PERDEU      EQU 2   ; número do cenário do fundo de quando se perde
CENARIO_MENU        EQU 0   ; número do cenário do fundo do menu

SOM_TEMA            EQU 0   ; número da música de fundo
SOM_START           EQU 1   ; número do som quando se começa o jogo

; ECRA
N_LINHAS        EQU  32     ; número de linhas do ecrã (altura)
N_COLUNAS       EQU  64     ; número de colunas do ecrã (largura)

; TECLADO
LIN_INI         EQU 1       ; primeira linha a testar (1ª linha, 0001b)
LIN_FIN         EQU 8       ; última linha (4ª linha, 1000b)
MASC_TEC        EQU 0FH     ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado

; PAINEL
LINHA_PNL       EQU 27      ; número da linha onde o painel começa
COLUNA_PNL_I    EQU 25      ; número da linha onde o painel começa
COLUNA_PNL_F    EQU 39      ; número da linha onde o painel termina

TECLA_START     EQU 0CH     ; tecla C

COR_PIXEL       EQU 0FF00H  ; cor do pixel: vermelho em ARGB (opaco e vermelho no máximo, verde e azul a 0)
; ****************************************************************************

; ****************************************************************************
; STACK POINTER
PLACE       1000H
; SP inicial do programa
STACK       100H
SP_inicial:
; ****************************************************************************

; **********
; * CODIGO *
; **********
PLACE       0

inicio:
    MOV     SP, SP_inicial

    MOV     [APAGA_AVISO], R0				; apaga o aviso de nenhum cenário selecionado
    MOV     [APAGA_ECRA], R0				; apaga todos os pixels
	MOV	    R0, CENARIO_MENU				; cenário do menu
    MOV     [DEFINE_CENARIO], R0            ; seleciona o cenário de fundo

    MOV     R1, SOM_TEMA                    ; endereço da música de fundo
    MOV     [DEFINE_SOM_OU_VIDEO], R1       ; seleciona a música de fundo
    MOV     [REPRODUZ_EM_CICLO], R1         ; começa a música de fundo

menu:
    MOV     R0, TECLA_START                 ; tecla que inicia o jogo
    CALL    teclado                         ; lê uma tecla
	CMP     R3, R0					        ; verifica se a tecla de start foi pressionada
	JNZ     menu				            ; se não, volta ao ciclo do menu
	JMP     start						    ; se foi, começa o jogo

start:
	MOV	    R0, CENARIO_JOGO				; cenário de fundo número
    MOV     [DEFINE_CENARIO], R0	        ; seleciona o cenário de fundo

    MOV     R1, SOM_TEMA                    ; endereço da música de fundo
    MOV     [DEFINE_SOM_OU_VIDEO], R1       ; seleciona a música de fundo
    MOV     [TERMINA_SOM_OU_VIDEO], R1      ; termina a música de fundo

    MOV     R1, SOM_START                   ; endereço da música de start
    MOV     [DEFINE_SOM_OU_VIDEO], R1       ; seleciona a música de start
    MOV     [INICIA_REPRODUCAO], R1         ; reproduz o som de start

fim:
    JMP     fim                             ; termina o programa


;**********
; ROTINAS *
;**********

;******************************************
; Descrição: Lê a tecla do teclado premida.
; Entradas:  -------------------
; Saídas:    R3 - Valor da tecla
;******************************************
teclado:
    PUSH    R0
    PUSH    R1
    PUSH    R2
    PUSH    R4
    PUSH    R5
    PUSH    R6
    PUSH    R7
    PUSH    R8

inicializações:		
    MOV     R2, TEC_LIN   ; endereço do periférico das linhas
    MOV     R3, TEC_COL   ; endereço do periférico das colunas
    MOV     R4, DISPLAYS  ; endereço do periférico dos displays
    MOV     R5, MASC_TEC  ; isola os 4 bits de menor peso, ao ler as colunas do teclado
    MOV     R6, LIN_INI   ; primeira linha a ser testada (1ª linha, 0001b)
    MOV     R7, LIN_FIN   ; linha final

varre_linhas:	          ; varre cada linha, uma a uma
    MOV     R1, R6        ; testa cada linha
    MOVB    [R2], R1      ; escreve no periférico de saída (linhas)
    MOVB    R0, [R3]      ; lê do periférico de entrada (colunas)
    AND     R0, R5        ; elimina bits para além dos bits 0-3
    CMP     R0, 0         ; há tecla premida?
    JNZ     converte      ; se sim, converte a linha e a coluna para uma tecla

verifica_ultima:          ; verifica se já percorreu todas as linhas 
    CMP     R6, R7        ; é a última linha?
    JZ      sai_tecl      ; se sim, repete o processo desde o início
    SHL     R6, 1         ; se não, testa a linha seguinte na próxima iteração
    JMP     varre_linhas  ; passa para a linha seguinte

converte:                 ; converte a linha e a coluna para uma tecla
    MOV     R2, R1        ; copia a linha
    MOV     R3, 0         ; começa na primeira linha (= 0)
    JMP     linha         ; converte a linha para um número entre 0 e 3

exit_linha:
    MOV     R4, 4         ; prepara a multiplicação
    MUL     R3, R4        ; multiplica a linha por 4
    MOV     R4, R3        ; copia o valor da linha convertida * 4
    MOV     R4, 0         ; começa na primeira coluna (= 0)
    MOV     R2, R0        ; copia a coluna
    JMP     coluna        ; converte a coluna para um número entre 0 e 3

exit_coluna:
    ADD     R3, R4        ; valor = 4*linha + coluna
    JMP     sai_tecl      ; sai da rotina

linha:                    ; loop para converter a linha
    SHR     R2, 1         ; desloca os bits da linha uma poisção para a direita
    CMP     R2, 0         ; já converteu a linha?
    JNZ     out_linha     ; se não, passa para a linha seguinte
    JMP     exit_linha    ; se já converteu, sai do loop

out_linha:
    ADD     R3, 1         ; incrementa a linha em 1
    JMP     linha         ; repete o processo

coluna:                   ; loop para converter a coluna
    SHR     R2, 1         ; desloca os bits da coluna uma posição para a direita
    CMP     R2, 0         ; já converteu a coluna
    JNZ     out_coluna    ; se não, passa para a coluna seguinte
    JMP     exit_coluna   ; se já converteu, sai do loop

out_coluna:
    ADD     R4, 1         ; incrementa a coluna em 1
    JMP     coluna        ; repete o processo

sai_tecl:
    POP     R8
    POP     R7
    POP     R6
    POP     R5
    POP     R4
    POP     R2
    POP     R1
    POP     R0
    RET