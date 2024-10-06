import habitantes.*
import zonas.*

const bosqueDeFangorn = new Zona (requerimiento = algunGuerreroTieneArmas)

const edoras = new Zona (requerimiento = sinRequerimiento)

const estemnet = new Zona (requerimiento = grupoTiene3CapasElficas)

const grupoTiene3CapasElficas = new RequerimientoDeItem (
  itemRequerido = "capa elfica",
  cantidadRequerida = 3
)

const algunGuerreroTieneArmas = new RequerimientoDeGuerrero (
  bloqueDeAtributoRequerido = {guerrero => guerrero.tieneSuficientesArmas(1)}
)