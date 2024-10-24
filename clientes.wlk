import wollok.game.*
import platos.*

object mesas {
  var property mesasDisponibles = [[8, 8], [2, 2], [2, 8]]
  var property mesasOcupadas = []
  
  method ocuparMesa(mesa) {
    mesasOcupadas.add(mesa)
    mesasDisponibles.remove(mesa)
  }
  
  method desocuparMesa(mesa) {
    mesasOcupadas.remove(mesa)
    mesasDisponibles.add(mesa)
  }
}

class Cliente {
  var property id = 0.randomUpTo(200000000).truncate(0)
  var property position = game.at(0, 0)
  var property paciencia = 4000.randomUpTo(15000).truncate(0)
  //agrego esto para probar metodos de agarrar y entregar
  var property plato = hamburguesa
  
  method sentarseEnMesa() {
    position = game.at(
      mesas.mesasDisponibles().get(0).get(0),
      mesas.mesasDisponibles().get(0).get(1)
    )
    const mesa = mesas.mesasDisponibles().head()
    mesas.ocuparMesa(mesa)
  }
  
  method text() = paciencia.toString()
  
  method image() = "cliente-1.png"
  
  //metodo provisorio
  method recibirPlato() {
    console.println("cliente recibio el plato")
  }
}

object spawnerClientes {
  method comenzar() {
    /* Spawn de clientes en la posicion de la mesa si es que hay disponibles */
    game.onTick(
      2000,
      "spawnClientes",
      { if (mesas.mesasDisponibles().size() !== 0) {
          const cliente = new Cliente()
          cliente.sentarseEnMesa()
          // Crea un objeto nuevo de cliente y le asigna una mesa de las disponibles 
          game.addVisual(cliente)
          game.say(cliente, "!")
          // Este onTick se encarga de eliminar al cliente y desocupar la mesa cuando se le acaba la paciencia 
          game.onTick(
            cliente.paciencia(),
            "pacienciaCliente/" + cliente.id(),
            { 
              mesas.desocuparMesa(
                [cliente.position().x(), cliente.position().y()]
              )
              return game.removeVisual(cliente)
            }
          )
        } }
    ) // Eventos de Teclado: Interaccion con cliente 
  }
}