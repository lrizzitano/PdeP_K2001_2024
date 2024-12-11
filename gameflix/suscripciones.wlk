object suscripcionPremium {
    const property precio = 50

    method puedeJugar(juego) = true
}

object suscripcionBase {
    const property precio = 25

    method puedeJugar(juego) = juego.precioMenorA(30)
}

object suscripcionInfantil {
    const property precio = 10

    method puedeJugar(juego) = juego.esDeCategoria("infantil")
}

object suscripcionPrueba {
    const property precio = 0

    method puedeJugar(juego) = juego.esDeCategoria("demo")
}