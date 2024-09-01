// Well Known Object (WKO)
class Personaje {
  var globos = 0

  // Getter
  method globos() = globos

  method comprarGlobos(unaCantidad) {
  globos += unaCantidad
  }

  method tieneSuficientesGlobos() = globos > 50
}

class Niandu inherits Personaje {
  // Estado
  var estrellas = 0

  // Getter
  method estrellas() = estrellas
  // Setter
  method estrellas(unaCantidad) {
    estrellas = unaCantidad
  }

  // Comportamiento
  method encontrarEstrellas() {
    estrellas += 8
  }

  method regalarEstrellas() {
    estrellas = 0.max(estrellas - 1)
  } 

  method tieneTodoListo() = estrellas >= 4
}

class Pinguino inherits Personaje {

  method tieneTodoListo() = true
}

class Carpincho inherits Personaje {

  var latas = 0

  // Getter
  method latas() = latas

  method recolectarLatas() {
    latas += 1    
  } 

  method reciclarLatas() {
    latas -= 5
  }

  method tieneTodoListo() = latas%2 == 0 
}

const manic = new Niandu ()
const chuy = new Pinguino()
const capy = new Carpincho()

object fiesta {
  var property quienOrganiza = manic

  method estaPreparada() =
    quienOrganiza.tieneTodoListo() && quienOrganiza.tieneSuficientesGlobos()
}