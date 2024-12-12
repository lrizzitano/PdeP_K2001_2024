import Usuario.*
object pdeplibre {
    const usuarios = #{}
    const productos = #{}

    method usuariosMorosos() = usuarios.forEach({usuario => usuario.esUsuarioMoroso()})
    method obtenerNombresDeOferta() = productos.map({producto => producto.nombreDeOferta()})

    method reducirPuntosAUsuariosMorosos() {
        self.usuariosMorosos().forEach({usuario => usuario.reducirPuntos(1000)})
    }

    method eliminarCuponesUsados() {
        usuarios.forEach({usuario => usuario.eliminarCuponesUsados()})
    }

    method actualizarNivelesDeUsuarios() {
        usuarios.forEach({Usuario.actualizarNivel()})
    }
    
}