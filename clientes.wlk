import wollok.game.*
import platos.*
import mueblesMapa.*

class Cliente {
  var property id = 0.randomUpTo(200000000).truncate(0)
  var property position = game.at(0, 0)
  var property paciencia = 4000.randomUpTo(15000).truncate(0)
  //agrego esto para probar metodos de agarrar y entregar
  var property plato = hamburguesa
  
  method sentarseEnMesa(mesa) {
    position = game.at(mesa.position().x(), mesa.position().y())
    mesa.ocuparMesa(self)
  }
  
  method text() = paciencia.toString()
  
  method image() = "cliente-1.png"
  
  //metodo provisorio
  method recibirPlato() {
    console.println("cliente recibio el plato")
  }
}

object spawnerClientes {
  method pacienciaHandler(cliente, mesa) {
    game.onTick(
      cliente.paciencia(),
      "pacienciaCliente/" + cliente.id(),
      { 
        mesa.desocuparMesa()
        return game.removeVisual(cliente)
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
          
          self.pacienciaHandler(cliente, mesa)
        }
      }
    ) // Eventos de Teclado: Interaccion con cliente 
  }
}