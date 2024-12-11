object gameflix {
    const juegos = #{}
    const clientes = #{}

    method filtrarJuegosPorCategoria(unaCategoria) = juegos.filter({juego => juego.esDeCategoria(unaCategoria)})
    method buscarJuegoPorNombre(unNombre) = juegos.find({juego => juego.seLlama(unNombre)})  //Exception si no encuentra
    method recomendarJuego() = juegos.anyone()

    method actualizarSuscripciones() = clientes.forEach({cliente => cliente.actualizarSuscripcion()})
}