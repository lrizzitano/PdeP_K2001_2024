import emociones.*

class Recuerdo {
    const property fecha
    const property descripcion
    const property emocion

    method tieneDescripcionLarga() = descripcion.words() > 10

    method esRecuerdoAlegre() = emocion == alegria 
}