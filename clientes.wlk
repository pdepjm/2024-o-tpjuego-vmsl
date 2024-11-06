import mozo.*
import wollok.game.*
import platos.*
import mueblesMapa.*
import configuracion.vida

class Cliente {
  var property id = 0.randomUpTo(200000000).truncate(0)
  var property position = game.at(0, 0)
  var property paciencia = 10000.randomUpTo(15000).truncate(0)
  //agrego esto para probar metodos de agarrar y entregar
  var property plato = pasta
  // Estados:
  // 0 -> Esperando a ser atendido
  // 1 -> Esperando plato de comida
  // 2 -> Comiendo
  var property estado = 0
  
  method sentarseEnMesa(mesa) {
    position = game.at(mesa.position().x(), mesa.position().y())
    mesa.ocuparMesa(self)
  }
  
  method text() = paciencia.toString()
  
  method image() = "cliente-1.png"
}

object spawnerClientes {
  method pacienciaHandler(cliente, mesa, estado) {
    const dialogo = new Dialogo(
      position = game.at(
        cliente.position().x() + 0.5,
        cliente.position().y() + 1.5
      ),
      duration = (cliente.paciencia() / 3).truncate(0),
      image = if (estado == 0) {
        "feliz.png"
      } else {
        if (estado == 1) "esperando.png" else "enojado.png"
      }
    )
    dialogo.mostrar()
    game.schedule(
      (cliente.paciencia() / 3).truncate(0),
      { 
        if (estado == 4) {
          mesa.desocuparMesa()
          vida.perderVida()
          return game.removeVisual(cliente)
        }
        return self.pacienciaHandler(cliente, mesa, estado + 1)
      }
    )
  }
  
  method comenzar() {
    /* Spawn de clientes en la posicion de la mesa si es que hay disponibles */
    game.onTick(
      2000,
      "spawnClientes",
      { 
        const mesasDisponibles = mesas.filter(
          { mesa => not mesa.estaOcupada() }
        )
        if (mesasDisponibles.size() !== 0) {
          const mesa = mesasDisponibles.head()
          const cliente = new Cliente()
          cliente.sentarseEnMesa(mesa)
          // Crea un objeto nuevo de cliente y le asigna una mesa de las disponibles 
          
          
          
          
          
          game.addVisual(cliente)
          // Este onTick se encarga de eliminar al cliente y desocupar la mesa cuando se le acaba la paciencia    
          
          
          
          
          
          self.pacienciaHandler(cliente, mesa, 0)
        }
      }
    )
  }
}