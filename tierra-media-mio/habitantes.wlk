import armas.*

class Guerrero {
  var property vida
  var property armas = []
  var property items = []

  method poderDeArmas() = armas.sum({unArma => unArma.poder()})

  method poder()

  method cantidadDe(itemRequerido) = items.count({item => item == itemRequerido})

  method tieneSuficienteVida(cantidadDeVida) = vida >= cantidadDeVida

  method tieneSuficientePoder(cantidadDePoder) = self.poder() >= cantidadDePoder

  method tieneSuficienteArmas(cantidadDeArmas) = armas.size() >= cantidadDeArmas

  method tieneSuficienteItems(cantidadDeItems) = items.size() >= cantidadDeItems
}

class Hobbit inherits Guerrero {
  override method poder() = vida + self.poderDeArmas() + items.size()
}

class Enano inherits Guerrero {
  const factorDePoder

  override method poder() = vida + factorDePoder * self.poderDeArmas() 
}

class Elfo inherits Guerrero {
  var property destrezaBase = 2
  const destrezaPropia

  override method poder() = vida + self.poderDeArmas() * (destrezaBase + destrezaPropia)
}

class Humano inherits Guerrero {
  const limitadorDePoder

  override method poder() = vida * self.poderDeArmas() / limitadorDePoder 
}

class Maiar inherits Guerrero {

  override method poder() =
    if (vida >= 10){
      self.calcularPoder(factorDePoderMaiarBasico)
    } else {
      self.calcularPoder(factorDePoderMaiarBajoAmenaza)
    }

  method calcularPoder(factorDePoder) = vida * factorDePoder.factor() + self.poderDeArmas() * 2
}

object factorDePoderMaiarBasico {
  var property factor = 15
}

object factorDePoderMaiarBajoAmenaza {
  var property factor = 300
}

object tomBombadil inherits Guerrero (vida = 100, items = ["chaqueta azul brillante", "botas amarillas", "pluma de ala de cisne"]){
  override method poder() = 10000000
}

object gollum inherits Hobbit (vida = 100){
  override method poder() = super() / 2 
}

const frodo = new Hobbit (vida = 50, armas = [espadaDeFrodo])
const gimli = new Enano (vida = 75, armas = [hachaDeGimli, hachaDeGimli], factorDePoder = 3)
const legolas = new Elfo (vida = 80, destrezaPropia = 1, armas = [arcoDeLegolas, espadaDeLegolas])
const aragorn = new Humano (vida = 85, armas = [anduril, dagaDeAragorn], limitadorDePoder = 20)
const gandalf = new Maiar (vida = 100, armas = [glamdring, baculoDeGandalf])