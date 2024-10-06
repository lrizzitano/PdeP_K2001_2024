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
    grupoDeGuerreros.flatmap({guerrero => guerrero.items()}).count({item => item == itemRequerido }) >= cantidadRequerida
}

class RequerimientoDeGuerrero {
  const bloqueDeAtributoRequerido
  const cantidadRequerida

  method evaluarRequerimiento(grupoDeGuerreros) = 
    grupoDeGuerreros.any({guerrero => bloqueDeAtributoRequerido.apply(guerrero) >= cantidadRequerida})
}

object sinRequerimiento {
  method evaluarRequerimiento(grupoDeGuerreros) = true
}


//import habitantes.*
//
//object lebennin {
//
//  // Solo permite pasar por ella a quienes tengan más de 1500 de poder.
//  // (Tom Bombadil puede atravesar cualquier Zona de la Tierra Media.)
//  method puedeRecorrer(habitante) = 
//    if (habitante == tomBombadil) true else habitante.poder() > 1500
//
//  // A quién va a Lebennin no le pasa nada.
//  method recorrer(habitante) {}
//
//}
//
//object minasTirith {
//
//  // Por Minas Tirith, en cambio, no hay chances de pasar sin tener armas.
//  // (Tom Bombadil puede atravesar cualquier Zona de la Tierra Media.)
//  method puedeRecorrer(habitante) = 
//    if (habitante == tomBombadil) true else habitante.tieneArmas()
//
//  // Recorrer Minas Tirith implica perder 10 unidades de vida a quien lo hace.
//  method recorrer(habitante) {
//    if (self.puedeRecorrer(habitante)) habitante.recorrer(-10)
//  }
//}
//
//object lossarnach {
//
//  // Lossarnach es otro lugar cercano, para el cual no hay requisitos.
//  method puedeRecorrer(habitante) = true 
//
//  // Lossarnach hace que quien lo atraviesa aumente su vida en 1 unidad.
//  method recorrer(habitante) {
//    if (self.puedeRecorrer(habitante)) habitante.recorrer(1)
//  }
//}
//
//object caminoDeGondor {
//  var property origen = lebennin
//  var property destino = minasTirith
//
//  // Para poder recorrer el camino de Gondor debe poder recorrer ambas zonas
//  method puedeRecorrer(habitante) =  
//    origen.puedeRecorrer(habitante) && destino.puedeRecorrer(habitante)
//
//  // Cuando lo hace sufre también las consecuencias correspondientes.
//  method recorrer(habitante) {
//    origen.recorrer(habitante)
//    destino.recorrer(habitante)
//  }
//
//
//}