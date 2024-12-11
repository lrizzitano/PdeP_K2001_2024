class Juego {
    const nombre
    const  precio
    const  categoria

    method esDeCategoria(unaCategoria) = categoria == unaCategoria
    method seLlama(unNombre) = nombre == unNombre
    method precioMenorA(unPrecio) = precio < unPrecio

    method afectarA(cliente, horasJugadas)

}

class JuegoViolento inherits Juego {
    override method afectarA(cliente, horasJugadas) {
      cliente.reducirHumor(10 * horasJugadas)
    }
}

class MOBA inherits Juego {
    override method afectarA(cliente, horasJugadas) {
      cliente.pagar(30)
    }
}

class JuegoDeTerror inherits Juego {
    override method afectarA(cliente, horasJugadas) {
      cliente.pasarASuscripcionInfantil()
    }
}

class JuegoEstrategico inherits Juego {
    override method afectarA(cliente, horasJugadas) {
      cliente.aumentarHumor(5 * horasJugadas)
    }
}