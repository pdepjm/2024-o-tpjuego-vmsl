import mueblesMapa.*
import mozo.*
import platos.*

object configuracion {
	method setGeneral() {
		game.width(30)
		game.height(15)
		game.cellSize(100)
		game.title("Wollok Dinner")
	}
	
	method setVisuals() {
		game.boardGround("fnd.jpg")
		mesas.forEach({mesa => game.addVisual(mesa)})
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