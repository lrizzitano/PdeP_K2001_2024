import habitantes.*
import zonas.*

const bosqueDeFangorn = new Zona (requerimiento = algunGuerreroTieneArmas, efecto = perderCapaElfica)

const edoras = new Zona (requerimiento = sinRequerimiento, efecto = ganarBotellaDeVino)

const estemnet = new Zona (requerimiento = grupoTiene3CapasElficas, efecto = duplicarVida)

const grupoTiene3CapasElficas = new RequerimientoDeItem (
  itemRequerido = "capa elfica",
  cantidadRequerida = 3
)

const algunGuerreroTieneArmas = new RequerimientoDeGuerrero (
  bloqueDeAtributoRequerido = {guerrero => guerrero.tieneSuficientesArmas(1)}
)

const perderCapaElfica = new EfectoDeItem (item = "capa elfica", cantidad = -1)

const ganarBotellaDeVino = new EfectoDeItem (item = "vino caliente", cantidad = 1)

const duplicarVida = new EfectoDeVidaPorcentual (porcentajeDeVida = 100)