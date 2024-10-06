import armas.*

class Guerrero {
  var property vida
  var property armas
  var property items

  method poderDeArmas() = armas.sum({unArma => unArma.poder()})
  method poder()
}

class Hobbit inherits Guerrero {
  method cantidadDeItems() = items.size()
  override method poder() = vida + self.poderDeArmas() + self.cantidadDeItems()
}

class Enano inherits Guerrero {
  const factorDePoder

  override method poder() = vida + factorDePoder * self.poderDeArmas() 
}

class Elfo inherits Guerrero {
  var property destrezaPropia

  override method poder() = vida + self.poderDeArmas() * (destrezaBaseDeElfos.destreza() + destrezaPropia)
}

class Humano inherits Guerrero {
  const limitadorDePoder

  override method poder() = vida * self.poderDeArmas() / limitadorDePoder 
}

class Maiar inherits Guerrero {
  var property factorDePoder = factorDePoderBasico

  override method poder() = vida * factorDePoder.factor() + self.poderDeArmas() * 2
}

object factorDePoderBasico {
  var property factor = 15
}

object factorDePoderBajoAmenaza {
  var property factor = 300
}

object destrezaBaseDeElfos {
  var property destreza = 2
}

object tomBombadil inherits Guerrero (vida = 100, armas = [], items = []){
  override method poder() = 10000000
}

object gollum inherits Hobbit (vida = 100, armas = [], items = []){
  override method poder() = super() / 2 
}

const frodo = new Hobbit (vida = 50, armas = [espadaDeFrodo], items = [])
const gimli = new Enano (vida = 75, armas = [hachaDeGimli, hachaDeGimli], items = [], factorDePoder = 3)
const legolas = new Elfo (vida = 80, destrezaPropia = 1, armas = [arcoDeLegolas, espadaDeLegolas], items = [])
const aragorn = new Humano (vida = 85, armas = [anduril, dagaDeAragorn], items = [], limitadorDePoder = 20)
const gandalf = new Maiar (vida = 100, armas = [glamdring, baculoDeGandalf], items = [])