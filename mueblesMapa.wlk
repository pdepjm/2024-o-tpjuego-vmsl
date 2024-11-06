
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


const mesa1 = new Mesa(position = game.at(3,11), image = "muebles.png")
const mesa2 = new Mesa(position = game.at(21,11), image = "muebles.png")
const mesa3 = new Mesa(position = game.at(12,7.6), image = "muebles.png")
const mesa4 = new Mesa(position = game.at(3,4.5), image = "muebles.png")
const mesa5 = new Mesa(position = game.at(21,5), image = "muebles.png")

const mesas = [mesa1, mesa2, mesa3, mesa4, mesa5]
