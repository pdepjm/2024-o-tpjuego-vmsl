import configuracion.*
import platos.*
import clientes.*
import mueblesMapa.*

const dialogos = []

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
    dialogos.add(self)
    console.println(dialogos)
    game.schedule(duration, { game.removeVisual(self) dialogos.remove(self) })
  }
  
  method eliminar() {
    game.removeVisual(self)
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
  //method fontSize() = 24
  method textColor() = "FFFFFFFF"
  
  //de esta forma, puede que distintos nombres de metodos a llamar
  method sumarPuntos(cliente) {
    self.cambiarPuntaje(cliente.plato().puntaje() * cliente.paciencia())
  }
  
  method restarPuntos(cliente) {
    self.cambiarPuntaje(-1000)
  }
}

class Estrella {
  var property image = "estrella.png"
  var property position
}

object mozo {
  var property bandeja = null
  var property position = game.at(1, 3)
  var property vidas = [
    new Estrella(position = game.at(29, 14)),
    new Estrella(position = game.at(28, 14)),
    new Estrella(position = game.at(27, 14))
  ]
  var property clientesAtendidos = 0
  //var property posicionesOcupadas = [] //intento de que el mozo no pase por encima de las mesas
  method image() = "imagenMozo.png"
  
  method posicionDialogoX() = self.position().x() + 1
  
  method posicionDialogoY() = self.position().y() + 2
  
  /*
  var property position = game.at(1, 3)
  const minX = 0
  const minY = 0
  const maxX = game.width() - 1
  const maxY = game.height() - 1

  method move(dx, dy) {
    const newX = position.x() + dx
    const newY = position.y() + dy

    if (newX >= minX && newX <= maxX) {
      position = position.x(newX)
    }
    if (newY >= minY && newY <= maxY) {
      position = position.y(newY)
    }
  }
*/

  method liberarMesas(mesa) {
    if(mesa.clienteSentado() !== null){
      mesa.clienteSentado().emocion().eliminar() 
      game.removeVisual(mesa.clienteSentado()) 
      mesa.desocuparMesa()
      }
  }

  method clienteEspecial() {
    if(clientesAtendidos % 2 == 0) {
      game.removeTickEvent("spawnClientes")
      mesas.forEach({mesa => self.liberarMesas(mesa)})
      const clienteEspecial = new ClienteEspecial()
      game.addVisual(clienteEspecial)
      clienteEspecial.sentarseEnMesa(mesa3)
      spawnerClientes.pacienciaHandler(clienteEspecial, mesa3, 0)
    }
  }

  method mostrarBandeja() {
    if (self.bandeja() !== null) {
      const dialogo = new Dialogo(
        position = game.at(self.posicionDialogoX(), self.posicionDialogoY()),
        duration = 1000,
        image = bandeja.imagenDialogo()
      ) // Dura 2 segundos
      dialogo.mostrar()
    } else {
      const dialogo = new Dialogo(
        position = game.at(self.posicionDialogoX(), self.posicionDialogoY()),
        duration = 1000,
        image = "vacioDialogo.png"
      ) // Dura 2 segundos
      dialogo.mostrar()
    }
  }
  
  method platoCercano() = comidas.findOrElse(
    { plato => self.position().distance(plato.position()) <= 1 },
    { null }
  )
  
  method agarrar() {
    const plato = self.platoCercano()
    if (self.platoCercano() !== null) {
      bandeja = plato
      self.mostrarBandeja()
    } else {
      const dialogo = new Dialogo(
        position = game.at(self.position().x() + 1, self.position().y() + 2),
        duration = 1500,
        image = "dialogoBarraLejos.png"
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
  
  method entregarPlato(cliente, mesa) {
    // Chequea si el plato que quiere el cliente es el mismo que el que tenemos en la bandeja
    game.removeTickEvent("pacienciaCliente/" + cliente.estado() + "/" + cliente.id())
    cliente.emocion().eliminar()
    if (cliente.plato() == self.bandeja()) {
      puntaje.sumarPuntos(cliente)
      cliente.estado(2)
      cliente.agradecer()
      console.println("Plato entregado")
      cliente.comer()
      game.schedule(
        1000,
        { 
          game.removeVisual(cliente)
          return mesa.desocuparMesa()
        }
      )
      clientesAtendidos += 1
      self.clienteEspecial()
    } else {
      puntaje.restarPuntos(cliente)
      console.println("Plato equivocado")
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
          self.entregarPlato(clienteCercano, self.mesaCercana())
      }
    } else {
      const dialogo = new Dialogo(
        position = game.at(self.position().x() + 1, self.position().y() + 2),
        duration = 1500,
        image = "dialogoClientesLejo.png"
      )
      dialogo.mostrar()
    }
  }
  
  method perderVida() {
    if (vidas.size() == 1) {
    configuracion.terminarJuego()
    } else {
      const vidaParaEliminar = vidas.findOrDefault({vida1 => vidas.all({vida2 => vida1.position().x() >= vida2.position().x() }) }, null) // Flashbacks de haskell
      game.removeVisual(vidaParaEliminar)
      vidas.remove(vidaParaEliminar)
    }
  }
}