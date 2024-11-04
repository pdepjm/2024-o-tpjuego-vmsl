object vacio {
  method imagenDialogo() = "vacioDialogo.png"

}
class Comida{
  const property puntaje
  const property position 

  method imagenDialogo()
}

class Hamburguesa inherits Comida{

  override method imagenDialogo() = "hamburguesaDialogo.png"
}

/*
object hamburguesa{

    const puntaje = 10
    method puntaje() = puntaje 
    const property position = game.at(5, 0)

    method imagenDialogo() = "hamburguesaDialogo.png"
}
*/

class Sandwich inherits Comida{
  override method imagenDialogo() = "dialogoSandwich.png" //Agregar imagen
}


class Ensalada inherits Comida{
  override method imagenDialogo() = "dialogoEnsalada.png" //Agregar imagen
}


class Waffle inherits Comida{
  override method imagenDialogo() = "dialogoWaffle.png" //Agregar imagen
}


const hamburguesa = new Hamburguesa(puntaje = 10, position = game.at(5, 0)) //pedido de una hamburguesa
const sandwich = new Sandwich(puntaje = 8, position = game.at(2, 5))
const ensalada = new Ensalada(puntaje = 12, position = game.at(7, 5))
const waffle = new Waffle(puntaje = 11, position = game.at(7, 10))

const comidas = [hamburguesa]


class Plato {
  var property image
  var property position

}

const plato1 = new Plato(position = game.at(2,1), image = "hamburguesa1.png")
const plato2 = new Plato(position = game.at(4,1), image = "sandwich1.png")
const plato3 = new Plato(position = game.at(6.2,1), image = "ensalada1.png")
const plato4 = new Plato(position = game.at(7.5,1), image = "waffles1.png")

const platos = [plato1,plato2,plato3,plato4]