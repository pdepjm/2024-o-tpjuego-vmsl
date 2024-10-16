import wollok.game.*

object mesas {
  var property mesasDisponibles = [[5, 5], [2, 4], [7, 6]]
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
  var property position = game.at(0, 0)
  var property paciencia = 2000.randomUpTo(15000).truncate(0)
  
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
}