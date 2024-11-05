import mueblesMapa.*
import mozo.*
import platos.*

class Estrella {
	var property image = "star.png"
	var property position
}

const vidas = [
	new Estrella(position = game.at(29, 14)),
	new Estrella(position = game.at(28, 14)),
	new Estrella(position = game.at(27, 14))
]

object vida {
	method perderVida() {
		if (vidas.size() > 0) {
			game.removeVisual(vidas.head())
			vidas.remove(vidas.head())
		}
	}
}

object configuracion {
	method setGeneral() {
		game.width(30)
		game.height(15)
		game.cellSize(100)
		game.title("Wollok Dinner")
	}
	
	method setVisuals() {
		game.boardGround("fondo.jpg")
		mesas.forEach({ mesa => game.addVisual(mesa) })
		vidas.forEach({ vida => game.addVisual(vida) })
		platos.forEach({plato => game.addVisual(plato)})
		rellenos.forEach({relleno => game.addVisual(relleno)})
		game.addVisualCharacter(mozo)
	}
	
	method setKeyboard() {
		//	TECLADO
		//Mostrar contenido de la bandeja
		keyboard.space().onPressDo({ mozo.mostrarBandeja() })
		//agarrar y entregar plato
		
		keyboard.h().onPressDo({ mozo.agarrar(hamburguesa) })
		keyboard.f().onPressDo({ mozo.interactuarConCliente() })
	}
}