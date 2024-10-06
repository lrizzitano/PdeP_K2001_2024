import habitantes.*
import zonas.*

const belfalas = new Zona (requerimiento = sinRequerimiento)

const lebennin = new Zona (requerimiento = algunGuerreroCon1500DePoder)

const minasTirith = new Zona (requerimiento = grupoTiene10Lembas)

const grupoTiene10Lembas = new RequerimientoDeItem (
  itemRequerido = "lemba",
  cantidadRequerida = 10
)

const algunGuerreroCon1500DePoder = new RequerimientoDeGuerrero (
  bloqueDeAtributoRequerido = {guerrero => guerrero.tieneSuficientePoder(1500)}
)