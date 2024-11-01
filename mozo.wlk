import platos.*
import clientes.*
import mueblesMapa.*

const hamburguesa = new Hamburguesa(puntaje = 10, position = game.at(5, 0)) //pedido de una hamburguesa
const sandwich = new Sandwich(puntaje = 8, position = game.at(2, 5))
const ensalada = new Ensalada(puntaje = 12, position = game.at(7, 5))
const waffle = new Ensalada(puntaje = 11, position = game.at(7, 10))

class Dialogo {
  const position
  const duration
  const text = ""
  const image
  
  method position() = position
  
  method text() = text
  
  method image() = image
  
  method mostrar() {
    game.addVisual(self)
    game.schedule(duration, { game.removeVisual(self) })
  }
}

object mozo {
  var property bandeja = hamburguesa
  var property position = game.origin()
  var property puntaje = 0
  
  method image() = "imagenMozo.png"
  
  method posicionDialogoX() = self.position().x() + 1
  
  method posicionDialogoY() = self.position().y() + 2
  
  method mostrarBandeja() {
    const dialogo = new Dialogo(
      position = game.at(self.posicionDialogoX(), self.posicionDialogoY()),
      duration = 1000,
      image = bandeja.imagenDialogo()
    ) // Dura 2 segundos
    dialogo.mostrar()
  }
  
  //de esta forma, puede que distintos nombres de metodos a llamar
  method sumarPuntos(cliente, plato) {
    puntaje = plato.puntaje() * cliente.paciencia()
  }
  
  //seria otro sistema para los puntos, falta implementar
  method restarPuntos() {
    puntaje -= 500
  }
  
  method agarrar(plato) {
    const posicion = self.position()
    //checkea que el mozo este dentro de la zona de la barra
    if ((posicion.y() >= 0) && (posicion.y() <= 2)) {
      bandeja = plato
      console.println(plato)
    } else {
      console.println("fuera de la zona de la barra")
    }
  }
  
  method distance(
    objeto1,
    objeto2
  ) = (((objeto1.position().x() ** 2) - (objeto2.position().x() ** 2)) + ((objeto1.position().y() ** 2) - (objeto2.position().y() ** 2))).squareRoot()
  
  method mesaCercana() = mesas.findOrElse(
    { mesa => mesa.estaOcupada() && (self.distance(self, mesa) <= 4) },
    { null }
  ) // Hacer mas declarativa esta funcion
  
  method entregar() {
    // Chequea que tengamos un cliente cerca
    if ((self.mesaCercana() !== null) && (self.bandeja() !== null)) {
      // Chequea si el plato que quiere el cliente es el mismo que el que tenemos en la bandeja
      if (self.mesaCercana().clienteSentado().plato() == self.bandeja()) {
        game.removeTickEvent(
          "pacienciaCliente/" + self.mesaCercana().clienteSentado().id()
        )
        console.println(self.mesaCercana())
        game.schedule(
          1500,
          { 
            game.removeVisual(self.mesaCercana().clienteSentado())
            return self.mesaCercana().desocuparMesa()
          }
        )
      }
    }
    return
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