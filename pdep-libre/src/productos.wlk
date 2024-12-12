class Producto {
    const property nombre
    const precioBase

    method precio() = 1.21 * precioBase 
    method nombreDeOferta() = "SUPER OFERTA " + nombre
}

class Mueble inherits Producto {
    override method precio() = super() + 1000
}

class Indumentaria inherits Producto {
    const esDeTemporada

    override method precio() = 
        if (esDeTemporada) 
            1.1 * super()
        else 
            super()
}

class Ganga inherits Producto {
    override method precio() = 0
    override method nombreDeOferta() = super() + " COMPRAME POR FAVOR"
}