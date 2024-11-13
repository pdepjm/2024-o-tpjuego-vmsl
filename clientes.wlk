import mozo.*
import wollok.game.*
import platos.*
import mueblesMapa.*

// Añadir diferentes clientes ej especial, etc
const clientes = [
  "cliente1uno.png",
  "cliente2dos.png",
  "cliente3tres.png",
  "cliente4cuatro.png"
]

class Cliente {
  var property id = 0.randomUpTo(200000000).truncate(0)
  var property position = game.at(0, 0)
  var property paciencia = 20000.randomUpTo(30000).truncate(0)
  //agrego esto para probar metodos de agarrar y entregar
  var property plato = pasta
  // Estados:
  // 0 -> Esperando a ser atendido
  // 1 -> Esperando plato de comida
  // 2 -> Comiendo
  var property estado = 0
  const property image = clientes.anyOne()
  
  method sentarseEnMesa(mesa) {
    position = game.at(mesa.position().x(), mesa.position().y() + 1)
    mesa.ocuparMesa(self)
  }
  
  method comer() {
    
  }

  method agradecer(){

  }
}

class ClienteEspecial inherits Cliente (
  id = 0.randomUpTo(200000000).truncate(0),
  image = "clienteSpe.png",
  paciencia = 15000,
  plato = pasta,
  estado = 0
) {
  override method sentarseEnMesa(_) {
    position = game.at(mesa3.position().x(), mesa3.position().y() + 1)
    mesa3.ocuparMesa(self)
  }
  
  override method comer() {
    if (mozo.vidas().size() < 3) {
      const posicionVidaTop = mozo.vidas().get(0).position()
      const nuevaVida = new Estrella(
        position = game.at(posicionVidaTop.x() + 1, 14)
      )
      mozo.vidas().add(nuevaVida)
      mozo.vidas(mozo.vidas().reverse())
      game.addVisual(nuevaVida)
    }
    spawnerClientes.comenzar()
    return
  }

  override method agradecer(){

  }
}

class ClienteEstricto inherits Cliente(
  id = 0.randomUpTo(200000000).truncate(0),
  image = "clienteSpe.png",
  paciencia = 15000,
  plato = pasta,
  estado = 0){
  
  override method sentarseEnMesa(_) {
    position = game.at(mesa1.position().x(), mesa1.position().y() + 1)
    mesa1.ocuparMesa(self)
  }

  override method agradecer(){
    c
  }

  }


object spawnerClientes {
  method pacienciaHandler(cliente, mesa, estado) {
    const dialogo = new Dialogo(
      position = game.at(
        cliente.position().x() + 0.5,
        cliente.position().y() + 2.5
      ),
      duration = (cliente.paciencia() / 3).truncate(0),
      image = if (estado == 0) {
        "feliz1.png"
      } else {
        if (estado == 1) "esperando1.png" else "enojado1.png"
      }
    )
    dialogo.mostrar()
    game.schedule(
      (cliente.paciencia() / 3).truncate(0),
      { 
        if (estado == 4) {
          mesa.desocuparMesa()
          mozo.perderVida()
          dialogo.eliminar()
          return game.removeVisual(cliente)
        }
        return self.pacienciaHandler(cliente, mesa, estado + 1)
      }
    )
  }
  
  method comenzar() {
    /* Spawn de clientes en la posicion de la mesa si es que hay disponibles */
    game.onTick(
      5000,
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