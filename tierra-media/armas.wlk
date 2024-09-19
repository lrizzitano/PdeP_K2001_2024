object baculo {
    method poder() = 400 
}

class Espada {
    const origen

    method poder() = 10 * origen.multiplicadorDeOrigen()
}

const glamdring = new Espada (origen = origenElfico)

class Origen{
    const property multiplicadorDeOrigen
}

const origenElfico = new Origen (multiplicadorDeOrigen = 25)

const origenEnano = new Origen (multiplicadorDeOrigen = 20)

const origenHumano = new Origen (multiplicadorDeOrigen = 15)