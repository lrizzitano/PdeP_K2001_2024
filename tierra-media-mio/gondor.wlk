import habitantes.*
import zonas.*

const lamedom = new Zona (requerimiento = sinRequerimiento, efecto = incrementarVida30Porciento)

const belfalas = new Zona (requerimiento = sinRequerimiento, efecto = ganarPanDeLembas)

const lebennin = new Zona (requerimiento = algunGuerreroCon1500DePoder, efecto = sinEfecto)

const minasTirith = new Zona (requerimiento = grupoTiene10Lembas, efecto = decrementarVida15Unidades)

const grupoTiene10Lembas = new RequerimientoDeItem (
  itemRequerido = "lemba",
  cantidadRequerida = 10
)

const algunGuerreroCon1500DePoder = new RequerimientoDeGuerrero (
  bloqueDeAtributoRequerido = {guerrero => guerrero.tieneSuficientePoder(1500)}
)

const incrementarVida30Porciento = new EfectoDeVidaPorcentual (porcentajeDeVida = 30)

const ganarPanDeLembas = new EfectoDeItem (item = "pan de lembas", cantidad = 1)

const decrementarVida15Unidades = new EfectoDeVida (cantidadDeVida = 15)