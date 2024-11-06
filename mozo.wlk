import platos.*
import clientes.*
import mueblesMapa.*

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
  var property bandeja = null
  var property position = game.at(1, 3)
  var property puntaje = 0
  
  method image() = "imagenMozo.png"
  
  method posicionDialogoX() = self.position().x() + 1
  
  method posicionDialogoY() = self.position().y() + 2
  
  method mostrarBandeja() {
    if (self.bandeja() !== null) {
      const dialogo = new Dialogo(
        position = game.at(self.posicionDialogoX(), self.posicionDialogoY()),
        duration = 1000,
        image = bandeja.imagenDialogo()
      ) // Dura 2 segundos
      dialogo.mostrar()
    }
  }
  
  //de esta forma, puede que distintos nombres de metodos a llamar
  method sumarPuntos(cliente, plato) {
    puntaje = plato.puntaje() * cliente.paciencia()
  }
  
  //seria otro sistema para los puntos, falta implementar
  method restarPuntos() {
    puntaje -= 500
  }
  
  method platoCercano() = platos.findOrElse(
    { plato => self.position().distance(plato.position()) <= 1 },
    { null }
  )
  
  method agarrar(plato) {
    const posicion = self.position()
    if (self.platoCercano() !== null) {
      bandeja = plato
    } else {
      const dialogo = new Dialogo(
        position = game.at(self.position().x() + 1, self.position().y() + 2),
        duration = 1500,
        image = "dialogoLejosBarra.png"
      )
      dialogo.mostrar()
    }
  }
  
  method mesaCercana() = mesas.findOrElse(
    { mesa => mesa.estaOcupada() && (self.position().distance(
        mesa.position()
      ) <= 2) },
    { null }
  ) // Hacer mas declarativa esta funcion
  
  method entregarPlato(cliente) {
    // Chequea si el plato que quiere el cliente es el mismo que el que tenemos en la bandeja
    if (cliente.plato() == self.bandeja()) {
      game.removeTickEvent(
        "pacienciaCliente/" + self.mesaCercana().clienteSentado().id()
      )
      cliente.estado(2)
      console.println("Plato entregado")
      game.schedule(
        0,
        { 
          game.removeVisual(self.mesaCercana().clienteSentado())
          return self.mesaCercana().desocuparMesa()
        }
      )
    }
    self.bandeja(null)
  }
  
  method tomarPedido(cliente) {
    const platoElegido = comidas.anyOne()
    cliente.estado(1)
    cliente.plato(platoElegido)
    const dialogo = new Dialogo(
      position = game.at(
        cliente.position().x() + 1,
        cliente.position().y() + 2
      ),
      duration = 1500,
      image = platoElegido.imagenDialogo()
    )
    dialogo.mostrar()
  }
  
  method interactuarConCliente() {
    // Chequea que tengamos un cliente cerca
    if (self.mesaCercana() !== null) {
      const clienteCercano = self.mesaCercana().clienteSentado()
      // El cliente esta esperando que le tomen el pedido
      if (clienteCercano.estado() == 0) {
        self.tomarPedido(clienteCercano)
      } else {
        if ((clienteCercano.estado() == 1) && (self.bandeja() !== null))
          // El cliente esta esperando que le tomen el pedido
          self.entregarPlato(clienteCercano)
      }
    } else {
      const dialogo = new Dialogo(
        position = game.at(
          self.position().x() + 1,
          self.position().y() + 2
        ),
        duration = 1500,
        image = "dialogoClienteLejos.png"
      )
      dialogo.mostrar()
    }
  }
}

object puntaje {
  var property puntaje = 0
  //var property image = 0
  const property position = game.at(0, 14)
  
  method cambiarPuntaje(nuevoPuntaje) {
    puntaje += nuevoPuntaje
  }
  
  method text() = puntaje.toString()
  
  method textColor() = "FFFFFFFF"
}