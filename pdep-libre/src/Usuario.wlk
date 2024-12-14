import niveles.*
import noQuedaEspacioEnCarritoException.*

class Usuario {
    const nombre
    var dinero
    var puntos
    var nivel = bronce
    var cupones = []
    const carrito = []

    method precioDeCarrito() = carrito.sum({producto => producto.precio()})
    method precioDeCarritoConDescuento(unCupon) =
        (1 - unCupon.porcentajeDeDescuento() / 100) * self.precioDeCarrito()
    method cuponesDisponiles() = cupones.filter({cupon => not cupon.fueUsado()})
    method esUsuarioMoroso() = dinero < 0 
    method nivelCorrespondiente() = 
        if (puntos < 5000) return bronce
        else if (puntos < 15000) return plata
        else return oro

    method pagar(unPrecio) {
        dinero -= unPrecio
    }

     method sumarPuntos(unosPuntos) {
        puntos += unosPuntos
    }

    method reducirPuntos(unosPuntos) {
        puntos -= unosPuntos
    }

    method eliminarCuponesUsados() {
        cupones = self.cuponesDisponiles()
    }

    method agregarACarrito(unProducto) {
        if (nivel.tieneCarritoLimitado() && carrito.length() >= nivel.productosMaxEnCarrito())
            throw new NoQuedaEspacioEnCarritoException()
        carrito.add(unProducto)
    }

    method comprarCarrito() {
        const cuponAUsar = self.cuponesDisponiles().any()
        cuponAUsar.usarCupon()
        const precioAPagar = self.precioDeCarritoConDescuento(cuponAUsar)
        self.pagar(precioAPagar)
        self.sumarPuntos(0.1 * precioAPagar)
    }

    method actualizarNivel() {
        nivel = self.nivelCorrespondiente()
    }
}