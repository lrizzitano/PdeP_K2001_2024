
import noPuedeRecategorizarException.*
class Artista {
    var experiencia
    var property cantidadDePeliculasEnLasQueActuo
    var ahorros

    method sueldo() = experiencia.calcularSueldo(self)
    method fama() = cantidadDePeliculasEnLasQueActuo / 2

    method incrementarExperiencia() {
      experiencia = experiencia.siguienteCategoria()
    }

    method sumarPeliculasActuadas(numero) {
      cantidadDePeliculasEnLasQueActuo += numero 
    }

    method cobrarsueldo() {
      ahorros += self.sueldo()
    }

    method recategorizar() {
      if (experiencia.puedeRecategorizar(self)) self.incrementarExperiencia()
    }
    
    method actuar() {
      self.sumarPeliculasActuadas(1)
      self.cobrarsueldo()
    }
} 

object amateur {
  const property siguienteCategoria = establecido

  method calcularSueldo(artista) = 10000
  method puedeRecategorizar(artista) = artista.cantidadDePeliculasEnLasQueActuo() > 10
}

object establecido {
  const property siguienteCategoria = estrella

  method calcularSueldo(artista) = if (artista.fama() < 15) 150000 else 5000 * artista.fama()
  method puedeRecategorizar(artista) = artista.fama() > 10
}

object estrella {
  method calcularSueldo(artista) = 30000 * artista.cantidadDePeliculasEnLasQueActuo()
  method puedeRecategorizar(artista) = throw new NoPuedeRecategorizarException()
}