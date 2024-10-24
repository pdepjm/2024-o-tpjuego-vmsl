
class Mesa {
  var property image
  var property position
  var property estaOcupada = false
  
  method ocuparMesa() {
    estaOcupada = true
  }
  method desocuparMesa() {
    estaOcupada = false
  }
}


const mesa1 = new Mesa(position = game.at(1,11), image = "muebles.png")
const mesa2 = new Mesa(position = game.at(9,11), image = "muebles.png")
const mesa3 = new Mesa(position = game.at(5,7.6), image = "muebles.png")
const mesa4 = new Mesa(position = game.at(1,4.5), image = "muebles.png")
const mesa5 = new Mesa(position = game.at(9,5), image = "muebles.png")

const mesas = [mesa1, mesa2, mesa3, mesa4, mesa5]
