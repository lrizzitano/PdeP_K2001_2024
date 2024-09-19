object baculo {
    method poder() = 400 
}

class Espada {
    const origen

    method poder() = 10 * origen.multiplicadorDeOrigen()
}

const glamdring = new Espada (origen = origenElfico)

object origenElfico {
    method multiplicadorDeOrigen() = 25
}

object origenEnano {
  method multiplicadorDeOrigen() = 20 
}

object origenHumano {
  method multiplicadorDeOrigen() = 15
}