class Zona {
  const requerimiento

  method puedeSerRecorridoPor(grupoDeGuerreros) = requerimiento.apply(grupoDeGuerreros)
}

class Camino {
  const zonasDelRecorrido

  method puedeSerRecorridoPor(grupoDeGuerreros) = zonasDelRecorrido.all({zona => zona.puedeSerRecorridoPor(grupoDeGuerreros)})
}

class RequerimientoDeItem {
  const itemRequerido
  const cantidadRequerida

  method evaluarRequerimiento(grupoDeGuerreros) = 
    grupoDeGuerreros.sum({guerrero => guerrero.cantidadDe(itemRequerido)}) >= cantidadRequerida
}

class RequerimientoDeGuerrero {
  const bloqueDeAtributoRequerido

  method evaluarRequerimiento(grupoDeGuerreros) = 
    grupoDeGuerreros.any({guerrero => bloqueDeAtributoRequerido.apply(guerrero)})
}

object sinRequerimiento {
  method evaluarRequerimiento(grupoDeGuerreros) = true
}