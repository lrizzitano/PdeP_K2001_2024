import recuerdos.*

class EmocionNoCentral {
    method niega(unRecuerdo) = false
    method asentar(unRecuerdo) { }
}

object alegria {
    method niega(unRecuerdo) = not unRecuerdo.esRecuerdoAlegre()

    method asentar(unRecuerdo, riley) {
        if (riley.felicidadMayorA(500)) riley.asentar(unRecuerdo)
    }
}

object tristeza {
    method niega(unRecuerdo) = unRecuerdo.esRecuerdoAlegre()
    
    method asentar(unRecuerdo, riley) {
        riley.asentar(unRecuerdo)
        riley.disminuirFelicidadPorcentual(10)
    }
}

const desagrado = new EmocionNoCentral()
const furia = new EmocionNoCentral()
const temor = new EmocionNoCentral()