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
		game.title("Wollok Diner")
	}
	
	method setVisuals() {
		game.boardGround("fondo.jpg")
		game.addVisual(puntaje)
		mesas.forEach({ mesa => game.addVisual(mesa) })
		vidas.forEach({ vida => game.addVisual(vida) })
		comidas.forEach({plato => game.addVisual(plato)})

		rellenos.forEach({relleno => game.addVisual(relleno)})
		game.addVisualCharacter(mozo)
	}
	
	method setKeyboard() {
		//	TECLADO

		//movimiento mozo
		//intento de que el mozo no pase por encima de las mesas
		/*
		keyboard.up().onPressDo { mozo.moverse(mozo.position().up(1)) }
		keyboard.down().onPressDo { mozo.moverse(mozo.position().down(1)) }
		keyboard.left().onPressDo { mozo.moverse(mozo.position().left(1)) }
		keyboard.right().onPressDo { mozo.moverse(mozo.position().right(1)) }
		*/

		//Mostrar contenido de la bandeja
		keyboard.space().onPressDo({ mozo.mostrarBandeja() })
		//Agarrar platos(Mozo)
		keyboard.e().onPressDo({ mozo.agarrar()})
		//Interaccion con el cliente
		keyboard.f().onPressDo({ mozo.interactuarConCliente() })
	}
}