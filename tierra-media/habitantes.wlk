import armas.*

object gandalf{
  var property vida = 100
  var property armas = #{baculo, glamdring}

  method poder() =
    if (vida >= 10){
      self.calcularPoder(15)
    } else {
      self.calcularPoder(300)
    }

  method calcularPoder(multiplicador) = vida * multiplicador + armas.sum({unArma => unArma.poder()}) * 2

  method tieneArmas() = not armas.isEmpty()

  method recorrer(modificadorVida) {
    vida += modificadorVida    
  }
}

object tomBombadil {
  // Pasar por cualquier zona no le causa ningún efecto a Tom Bombadil.
  method recorrer(modificadorVida) {}
}