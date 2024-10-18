import platos.*
import clientes.*
object mozo{

    var property bandeja = vacio

    var property position = game.origin()

    var property puntaje = 0


    method image() = "imagenMozo.png" 

    method mostrarBandeja() = game.say(self, bandeja.image())

    //de esta forma, puede que distintos nombres de metodos a llamar
    method sumarPuntos(cliente,plato) {
        puntaje = plato.puntaje() * cliente.paciencia()
    }

    //seria otro sistema para los puntos, falta implementar
    method restarPuntos() {
        puntaje = puntaje - 500
    }

    method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}

    method agarrar (plato){
        const posicion = self.position()
        //checkea que el mozo este dentro de la zona de la barra
        if (posicion.y() >= 0 && posicion.y() <= 2) {
            bandeja = plato
            console.println( plato)
        }
        else {
            console.println("fuera de la zona de la barra")
        }
    }

//PROBLEMA, luego de la primer entrega, sigue entregando al hacer el collide pero sin presionar ninguna tecla (sin que la bandeja este vacia)
    method entregar (){
        game.whenCollideDo(
        self,
            { cliente =>  
                if(cliente.plato()== self.bandeja()){
                    self.sumarPuntos(cliente, bandeja)
                    //agregar metodo
                    cliente.recibirPlato()
                    bandeja = vacio
                }
                else {
                    self.restarPuntos()
                    console.println("plato incorrecto o bandeja vacia")
                }
            }
        )
    }
}


object puntaje {
	var property puntaje = 0
	var property image = 0
    const position = game.center()

	method cambiarPuntaje(nuevoPuntaje) {
		image = puntaje + nuevoPuntaje
	}
     method text() = image.toString()
}