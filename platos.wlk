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
  override method imagenDialogo() = "sandwichDialogo.png" //Agregar imagen
}


class Ensalada inherits Comida{
  override method imagenDialogo() = "ensaladaDialogo.png" //Agregar imagen
}



class Waffle inherits Comida{
  override method imagenDialogo() = "waffleDialogo.png" //Agregar imagen
}


