class Cupon {
    const property porcentajeDeDescuento
    var fueUsado = false

    method fueUsado() = fueUsado

    method usarCupon() {
      fueUsado = true
    } 
}