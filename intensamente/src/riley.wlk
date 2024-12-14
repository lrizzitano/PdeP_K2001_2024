import emociones.*
import recuerdos.*
import src.noSePuedeDisminuirLaFelicidadException.NoSePuedeDisminuirLaFelicidad



object riley {
    var nivelDeFelicidad = 1000
    var property emocionDominante = alegria
    const recuerdosDelDia = []
    const property pensamientosCentrales = []
    const memoriaLargoPlazo = #{}

    method felicidadMayorA(unNumero) = nivelDeFelicidad > unNumero

    method felicidadResultante(unPorcentaje) = (1 - unPorcentaje / 100) * nivelDeFelicidad

    method recuerdosRecientes() = recuerdosDelDia.take(5) 

    method pensamientosCentralesDificilesDeExplicar() =
        pensamientosCentrales.filter({recuerdo => recuerdo.tieneDescripcionLarga()})

    method recuerdosConPalabraClave(palabraClave) =
        recuerdosDelDia.filter({recuerdo => recuerdo.descripcion().contiene(palabraClave)}) // no existe contiene()

    method recuerdosNoCentralesNiNegados() =
        recuerdosDelDia.filter({recuerdo => not (pensamientosCentrales.contains(recuerdo) || emocionDominante.niega(recuerdo))})

    method pensamientosCentralesEnLargoPlazo() =
        pensamientosCentrales.intersection(memoriaLargoPlazo) != #{} // probar

    method TodosLosRecuerdosConMismaEmocion () =
        self.TodosLosRecuerdosConEmocion(recuerdosDelDia.head().emocion())

    method TodosLosRecuerdosConEmocion(unaEmocion) =
        recuerdosDelDia.all({recuerdo => recuerdo.emocion() == unaEmocion}) 

    method aumentarFelicidad(unNumero) {
        if (nivelDeFelicidad <= 1000 - unNumero)
            nivelDeFelicidad += unNumero
    }

    method disminuirFelicidadPorcentual(unPorcentaje) {
        if (self.felicidadResultante(unPorcentaje) >= 1)
            nivelDeFelicidad = self.felicidadResultante(unPorcentaje)
        else
            throw new NoSePuedeDisminuirLaFelicidad()
    }

    method vivirEvento(unaDescripcion) {
        const recuerdo = new Recuerdo (fecha = calendar.today(), descripcion = unaDescripcion, emocion = emocionDominante)
        recuerdosDelDia.add(recuerdo)
    }

    method asentar(unRecuerdo) {
        unRecuerdo.emocion().asentar(unRecuerdo, self)
    }

    method agregarPensamientoCentral(unRecuerdo) {
        pensamientosCentrales.add(unRecuerdo)
    }

    method dormir() {
        self.asentarRecuerdos(recuerdosDelDia)
        self.asentarRecuerdosSelectivo("cucho")
        self.profundizar()
        self.realizarControlHormonal()
        self.realizarRestauracionCognitiva(100)
        self.liberarRecuerdos()
    }

    method asentarRecuerdos(unosRecuerdos) {
        unosRecuerdos.forEach({recuerdo => self.asentar(recuerdo)})
    }

    method asentarRecuerdosSelectivo(palabraClave) {
        self.asentarRecuerdos(self.recuerdosConPalabraClave(palabraClave))
    }

    method profundizar() {
        memoriaLargoPlazo.addAll(self.recuerdosNoCentralesNiNegados())
    }

    method realizarControlHormonal() {
        if (self.pensamientosCentralesEnLargoPlazo() || self.TodosLosRecuerdosConMismaEmocion())
            self.tenerDesequilibrioHormonal()
    }

    method tenerDesequilibrioHormonal() {
        self.disminuirFelicidadPorcentual(15)
        pensamientosCentrales.drop(3) // no es lo que pide
    }

    method realizarRestauracionCognitiva(unNumero) {
        if (unNumero <= 100)
            self.aumentarFelicidad(unNumero)
    }

    method liberarRecuerdos() {
        recuerdosDelDia.clear()
    }


}