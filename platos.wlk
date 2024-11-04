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
const waffle = new Ensalada(puntaje = 11, position = game.at(7, 10))

const platos = [hamburguesa]