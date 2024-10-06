class Espada {
    const multiplicadorDePoder
    const origen

    method poder() = multiplicadorDePoder * origen.valorDeOrigen()
}

class Baculo {
    const poder

    method poder() = poder
}

class Daga inherits Espada {
    override method poder() = super() / 2
}

class Arco {
    const longitud

    method poder() = tensionDeArcos.tension() * longitud / 10
}

class Hacha {
    const largoDelMango
    const pesoDeLaHoja

    method poder() = largoDelMango * pesoDeLaHoja
}

class Origen{
    const property valorDeOrigen
}

object tensionDeArcos {
    var property tension = 40
}

const origenElfico = new Origen (valorDeOrigen = 30)

const origenEnano = new Origen (valorDeOrigen = 20)

const origenHumano = new Origen (valorDeOrigen = 15)

const glamdring = new Espada (origen = origenElfico, multiplicadorDePoder = 10)
const baculoDeGandalf = new Baculo (poder = 400)
const espadaDeFrodo = new Espada (multiplicadorDePoder = 8, origen = origenElfico)
const hachaDeGimli = new Hacha (largoDelMango = 70, pesoDeLaHoja = 5)
const arcoDeLegolas = new Arco (longitud = 110)
const espadaDeLegolas = new Espada (multiplicadorDePoder = 12, origen = origenElfico)
const anduril = new Espada (multiplicadorDePoder = 18, origen = origenElfico)
const dagaDeAragorn = new Daga (multiplicadorDePoder = 10, origen = origenEnano)