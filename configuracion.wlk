import mueblesMapa.*
import mozo.*
import platos.*

object configuracion {
	method setGeneral() {
		game.width(15)
		game.height(15)
		game.cellSize(100)
		game.title("Wollok Dinner")
	}
	
	method setVisuals() {
		game.boardGround("fnd.jpg")
		
		game.addVisualCharacter(mesa1)
		game.addVisualCharacter(mesa2)
		game.addVisualCharacter(mesa3)
		game.addVisualCharacter(mesa4)
		game.addVisualCharacter(mesa5)
		game.addVisualCharacter(mozo)
	}
	
	method setKeyboard() {
		//	TECLADO
		//Mostrar contenido de la bandeja
		keyboard.space().onPressDo({ mozo.mostrarBandeja() })
		//agarrar y entregar plato
		
		keyboard.h().onPressDo({ mozo.agarrar(hamburguesa) })
		keyboard.enter().onPressDo({ mozo.entregar() })
	}
}