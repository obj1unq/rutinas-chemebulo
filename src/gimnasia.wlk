// ################################## ACTIVIDAD ##################################

class Rutina {
    method intensidad()
    
    method descanso(tiempo) {
        return if (tiempo > 20) {5} else {2}
    }
    
    method cuantasCaloriasQuemaEn(tiempo) {
        return (100 * (tiempo - self.descanso(tiempo)) * self.intensidad())
    }
}

// ################################# ACTIVIDADES #################################

class Running inherits Rutina {
    const property intensidad
}

class Maraton inherits Running {
    override method cuantasCaloriasQuemaEn(tiempo) {
        return super(tiempo) * 2
    }
}

class Remo inherits Rutina {
    override method intensidad() = 1.3

    override method descanso(tiempo) {
        return tiempo / 5
    }
}

class RemoCompetitivo inherits Remo {
    // Aunque una solución es plantear desde Remo(intensidad = 1.7), aunque depende de que haya un atributo ahí.
    override method intensidad() = 1.7

    override method descanso(tiempo) {
        return 2.max(super(tiempo) - 3)
    }
}