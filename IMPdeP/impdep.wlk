object impdep {
    const artistas = #{}
    const peliculas = #{}

    method artistaMejorPago() = artistas.sortedBy({unArtista, otroArtista => unArtista.sueldo() > otroArtista.sueldo()}).head()
    method peliculasEconomicas() = peliculas.filter({pelicula => pelicula.presupuesto() < 500000})
    method nombresDePeliculasEconomicas() = self.peliculasEconomicas().map({pelicula => pelicula.nombre()})
    method gananciaDePeliculasEconomicas() = self.peliculasEconomicas().sum({pelicula => pelicula.ganancias()})
}