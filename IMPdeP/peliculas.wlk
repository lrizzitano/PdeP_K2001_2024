class Pelicula {
    const property nombre
    const elenco = #{}
    const recaudacionBase = 1000000

    method sueldoDeElenco() = elenco.sum({artista => artista.sueldo()})
    method presupuesto() = self.sueldoDeElenco() * 1.7
    method recaudacion() = recaudacionBase
    method ganancias() = self.recaudacion() - self.ganancias()
    
    method rodar() {
      elenco.forEach({artista => artista.actuar()})
    } 
}

class PeliculaDeDrama inherits Pelicula {
    override method recaudacion() = super() + 100000 * nombre.size()
}

class PeliculaDeAccion inherits Pelicula {
    const vidriosRotos

    override method presupuesto() = super() + 1000 * vidriosRotos
    override method recaudacion() = super() + 50000 * elenco.size()
}

class PeliculaDeTerror inherits Pelicula {
    const cuchos

    override method recaudacion() = super() + 20000 * cuchos
}

class PeliculaDeComedia inherits Pelicula { }

