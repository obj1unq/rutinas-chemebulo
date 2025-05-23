// ############################################### RUTINA ##############################################

class Rutina {
    method intensidad()
    
    method descanso(tiempo)
    
    method cuantasCaloriasQuemaEn(tiempo) {
        return (100 * (tiempo - self.descanso(tiempo)) * self.intensidad())
    }
}

// ############################################## RUTINAS ##############################################

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

// ############################################## PERSONA ##############################################

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

// ################################################ CLUB ###############################################

class Club {
    const property predios

    method mejorPredioPara(persona) {
        return predios.max({predio => predio.caloriasQueQuemaCon(persona)})
    }

    method prediosTranquisPara(persona) {
        return predios.filter({predio => predio.tieneRutinaTranquiPara(persona)})
    }

    method rutinasMasExigentesPara(persona) {
        return predios.map({predio => predio.rutinaMasExigentePara(persona)}).asSet()
    }
}

// ############################################### PREDIO ##############################################

class Predio {
    const property rutinas
    const maximoDeCaloriasDeRutinaTranqui = 500

    method caloriasQueQuemaCon(persona) {
        return rutinas.sum({rutina => rutina.cuantasCaloriasQuemaEn(persona.tiempoDeEjercitacion())})
    }

    method tieneRutinaTranquiPara(persona) {
        return rutinas.any({rutina => rutina.cuantasCaloriasQuemaEn(persona.tiempoDeEjercitacion())
                                      < maximoDeCaloriasDeRutinaTranqui})
    }


    method rutinaMasExigentePara(persona) {
        return rutinas.max({rutina => rutina.cuantasCaloriasQuemaEn(persona.tiempoDeEjercitacion())})
    }
}