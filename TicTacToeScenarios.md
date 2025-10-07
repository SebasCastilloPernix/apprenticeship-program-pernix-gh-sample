# Escenarios
 
## **Escenario 1 (Historia de usuario 001):** Iniciar una nueva partida de Tic-Tac-Toe

**Dado** que el jugador abre el juego de Tic-Tac-Toe

**Cuando** empieza una nueva partida

**Entonces** el juego muestra una cuadrícula vacía de 3x3, permite elegir entre "X" o "O" y muestra el turno actual


## **Escenario 2 (Historia de usuario 002):** Un jugador realiza un movimiento

**Dado** que el jugador está en una partida de TicTacToe

**Cuando** hace click en una casilla vacía

**Entonces** la casilla muestra la marca del jugador ("X" o "O") y se cambia el turno para que el otro jugador haga su movimiento


## **Escenario 3 (Historia de usuario 003):** Un jugador gana-pierde-empata la partida

**Dado** que el jugador está en una partida de TicTacToe

**Cuando** se hace un movimiento

**Entonces** el juego verifica si hay un ganador o empate para el movimiento dado


## **Escenario 4 (Historia de usuario 004):** Reinicio del juego

**Dado** que el jugador desea reiniciar el juego

**Cuando** hace click en el botón de reinicio

**Entonces** la cuadrícula se restablece a un estado vacío y se le permite al jugador volver a seleccionar entre "X" y "O"


## **Escenario 5 (Historia de usuario 005):** UI intuitiva

**Dado** que el jugador desea jugar sin confusión

**Cuando** está en una partida

**Entonces** la cuadrícula debe estar visible y tener un diseño limpio, las casillas deben estar bien delimitadas y ser facilmente seleccionables, los indicadores de turno y estado del juego deben ser claramente visibles.


## **Escenario 6 (Historia de usuario 006):** Multijugador local

**Dado** que el jugador desea jugar con otras personas

**Cuando** cada jugador realiza su movimiento en el turno correspondiente 

**Entonces** se deben permitir dos jugadores en el mismo dispositivo, uno jugando como "X" y otro como "O", se deben alternar los turnos después de cada movimiento y mostrar el marcador o el estado del juego de los jugadores


## **Escenario 7 (Historia de usuario 007):** Juego contra la computadora

**Dado** que el jugador desea practicar y mejorar en TicTacToe

**Cuando** el jugador selecciona la opción de jugar contra la computadora

**Entonces** la IA debe hacer movimientos válidos para desafiar al jugador y debe tener niveles de dificultad (fácil, medio, difícil...)
