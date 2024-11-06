object vacio {
  method imagenDialogo() = "vacioDialogo.png"

}
class Comida{
  const property puntaje
  const property position 

  method imagenDialogo()
}

class Pasta inherits Comida{

  override method imagenDialogo() = "dialogoPasta.png"
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
  //override method imagenDialogo() = "dialogoSandwich.png" //Agregar imagen
  override method imagenDialogo() = "dialogoSandwich1.png"
}


class Ensalada inherits Comida{
  override method imagenDialogo() = "dialogoEnsalada.png" //Agregar imagen
}


class Waffle inherits Comida{
  override method imagenDialogo() = "dialogoWaffle.png" //Agregar imagen
}


const pasta = new Pasta(puntaje = 10, position = game.at(5, 0)) 
const sandwich = new Sandwich(puntaje = 8, position = game.at(2, 5))
const ensalada = new Ensalada(puntaje = 12, position = game.at(7, 5))
const waffle = new Waffle(puntaje = 11, position = game.at(7, 10))

const comidas = [pasta]


class Plato {
  var property image
  var property position

}

const plato1 = new Plato(position = game.at(9,1), image = "pasta.png")
const plato2 = new Plato(position = game.at(12,1), image = "sandwich4.png")
const plato3 = new Plato(position = game.at(15.2,1), image = "ensalada1.png")
const plato4 = new Plato(position = game.at(17.5,1), image = "waffles1.png")

const platos = [plato1,plato2,plato3,plato4]


class Relleno {
  var property image
  var property position

}

const bandeja1 = new Relleno(position = game.at(1,0.5), image = "bandeja1.png")
const bandeja2 = new Relleno(position = game.at(2,0.5), image = "bandeja2.png")
const menu2 = new Relleno(position = game.at(3,1), image = "menu3.png")
const cafes = new Relleno(position = game.at(5,1), image = "aaa1.png")

const platillos = new Relleno(position = game.at(21,1), image = "platillo1.png")
const menu = new Relleno(position = game.at(27,0.5), image = "menu1.png")
const maquinaCafe = new Relleno(position = game.at(28,0.5), image = "maqcafe.png")
const platosVacios = new Relleno(position = game.at(26,0.5), image = "platos.png")

const rellenos = [menu,maquinaCafe,platosVacios,bandeja1,bandeja2,menu2,platillos,cafes]