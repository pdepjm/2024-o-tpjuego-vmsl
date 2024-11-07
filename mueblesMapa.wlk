
class Mesa {
  var property image
  var property position
  var property estaOcupada = false
  var property clienteSentado = null 
  method ocuparMesa(cliente) {
    estaOcupada = true
    clienteSentado = cliente
  }
  method desocuparMesa() {
    estaOcupada = false
    clienteSentado = null
  }
}

// CAmbiar image de la instancia a la clase
const mesa1 = new Mesa(position = game.at(3,9), image = "mesita.png")
const mesa2 = new Mesa(position = game.at(21,9), image = "mesita.png")
const mesa3 = new Mesa(position = game.at(12,6.6), image = "mesita.png")
const mesa4 = new Mesa(position = game.at(3,3.5), image = "mesita.png")
const mesa5 = new Mesa(position = game.at(21,4), image = "mesita.png")

const mesas = [mesa1, mesa2, mesa3, mesa4, mesa5]
