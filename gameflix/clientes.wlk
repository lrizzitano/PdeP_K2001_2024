import noTengoMasPlataException.*
import suscripciones.*
class Cliente {
    var saldo
    var humor
    var suscripcion

    method puedePagar(unPrecio) = saldo <= unPrecio

    method jugar(juego, horas) {
        juego.afectarA(self, horas)
    }
   
    method pagar(unPrecio) {
        if (self.puedePagar(unPrecio))
            saldo -= unPrecio
        else
            throw new NoTengoMasPlataException()
    }

    method aumentarHumor(unHumor) {
      humor += unHumor
    }

    method reducirHumor(unHumor) {
      humor -= unHumor
    }

    method pasarASuscripcionInfantil() {
      suscripcion = suscripcionInfantil
    }

    method actualizarSuscripcion() {
        if (self.puedePagar(suscripcion.precio())) 
            self.pagar(suscripcion.precio())
        else
            self.pasarASuscripcionInfantil()
    }
}