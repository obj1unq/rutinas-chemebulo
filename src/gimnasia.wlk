// ############################################## ACTIVIDAD ##############################################

class Rutina {
    method intensidad()
    
    method descanso(tiempo)
    
    method cuantasCaloriasQuemaEn(tiempo) {
        return (100 * (tiempo - self.descanso(tiempo)) * self.intensidad())
    }
}

// ############################################# ACTIVIDADES #############################################

class Running inherits Rutina {
    const property intensidad

    override method descanso(tiempo) {
        return if (tiempo > 20) {5} else {2}
    }
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
    // Una solución posible es plantear desde la declaración de la clase: "inherits Remo(intensidad = 1.7)"
    // pero depende de que exista un atributo en Remo.
    override method intensidad() = 1.7

    override method descanso(tiempo) {
        return 2.max(super(tiempo) - 3)
    }
}

// ############################################### PERSONA ###############################################

class Persona {
    var property peso 
    const property tiempoDeEjercitacion

    method kilosPorCaloria()

    method practicar(rutina) {
        peso -= self.calcularGasto(rutina)
    }

    method calcularGasto(rutina) {
        return rutina.cuantasCaloriasQuemaEn(self.tiempoDeEjercitacion()) / self.kilosPorCaloria()
    }
}

class PersonaSedentaria inherits Persona(tiempoDeEjercitacion = 5) {
    override method kilosPorCaloria() = 7000 
 
    override method practicar(rutina) {
        self.validarSiPuedeAplicarRutina()
        super(rutina)
    }

    method validarSiPuedeAplicarRutina() {
        if(peso <= 50) {
            self.error("No puede aplicar la rutina")
        }
    }
}

class PersonaAtleta inherits Persona(tiempoDeEjercitacion = 90) {
    override method kilosPorCaloria() = 8000 

    override method practicar(rutina) {
        self.validarSiPuedeAplicarRutina(rutina)
        super(rutina)
    }

    method validarSiPuedeAplicarRutina(rutina) {
        if(self.caloriasQueConsumiria(rutina) <= 10000) {
            self.error("No puede aplicar la rutina")
        }
    }

    method caloriasQueConsumiria(rutina) {
        return rutina.cuantasCaloriasQuemaEn(self.tiempoDeEjercitacion())
    }

    override method calcularGasto(rutina) {
        return super(rutina) - 1
    }
}