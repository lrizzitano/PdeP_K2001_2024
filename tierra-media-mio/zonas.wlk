import noPuedenAtravesarLaZonaException.*

class Zona {
  const requerimiento
  const efecto

  method puedeSerRecorridoPor(grupoDeGuerreros) {
    if (requerimiento.evaluar(grupoDeGuerreros.filter({guerrero => not guerrero.fueraDeCombate()}))) 
      return true
    else 
      throw new NoPuedePagarLaSalaException()
  }

  method recorrer(grupoDeGuerreros) {
    efecto.aplicar(grupoDeGuerreros.filter({guerrero => not guerrero.fueraDeCombate()}))
  }
}

class Camino {
  const zonasDelRecorrido

  method puedeSerRecorridoPor(grupoDeGuerreros) = zonasDelRecorrido.all({zona => zona.puedeSerRecorridoPor(grupoDeGuerreros)})

  method recorrer(grupoDeGuerreros) {
    zonasDelRecorrido.all({zona => zona.recorrer(grupoDeGuerreros)})
  }
}

class RequerimientoDeItem {
  const itemRequerido
  const cantidadRequerida

  method evaluar(grupoDeGuerreros) = 
    grupoDeGuerreros.sum({guerrero => guerrero.cantidadDe(itemRequerido)}) >= cantidadRequerida
}

class RequerimientoDeGuerrero {
  const bloqueDeAtributoRequerido

  method evaluar(grupoDeGuerreros) = 
    grupoDeGuerreros.any({guerrero => bloqueDeAtributoRequerido.apply(guerrero)})
}

object sinRequerimiento {
  method evaluar(grupoDeGuerreros) = true
}

class EfectoDeVida {
  const cantidadDeVida

  method aplicar(grupoDeGuerreros) {
    grupoDeGuerreros.forEach({guerrero => guerrero.modificarVida(cantidadDeVida)})
  }
}

class EfectoDeVidaPorcentual {
  const porcentajeDeVida

  method aplicar(grupoDeGuerreros) {
    grupoDeGuerreros.forEach({guerrero => guerrero.modificarVidaPorcentual(porcentajeDeVida)})
  }
}

class EfectoDeItem {
  const item
  const cantidad

  method aplicar(grupoDeGuerreros) {
    grupoDeGuerreros.forEach({guerrero => guerrero.modificarItems(item, cantidad)})
  }
}

object sinEfecto {
  method aplicar(grupoDeGuerreros) { }
}