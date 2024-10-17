import platos.*

object mozo{

    var property bandeja = vacio

    var property position = game.origin()

    method image() = "imagenMozo.png" 

    method mostrarBandeja() = game.say(self, bandeja.image())

}