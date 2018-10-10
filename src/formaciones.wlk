class Formacion {

	var property vagones = []
	var property locomotoras = []

	method agregarVagones(unVagon) {
		vagones.add(unVagon)
	}

	method agregarLocomotoras(locomotora) {
		locomotoras.add(locomotora)
	}

	method cantidadDeVagonesLivianos() {
		return vagones.count({ unVagon => unVagon.pesoMaximo() < 2500 })
	}

	method velocidadMaximaDeFormacion() {
		return locomotoras.min({ locomotora => locomotora.velocidadMaxima() }).velocidadMaxima()
	}

	// lo que hizo nico para el punto 10
	method velocidadMaximaDeLocomotoras() {
		return locomotoras.min({ locomotora => locomotora.velocidadMaxima() }).velocidadMaxima()
	}

	/* 	method velocidadMaxima() {
	 * 		return locomotoras.min({ locomotora => locomotora.velocidadMaxima() }).velocidadMaxima()
	 }*/
	method esEficiente() {
		return locomotoras.all({ locomotora => locomotora.arrastreUtil() >= locomotora.pesoDeLocomotora() * 5 })
	// duda si va any o all , any me trae ALGUNA que cumpla la condision y all me trae TODAS las que la cumplan
	//
	}

	method puedeMoverse() {
		return self.arrastreUtilTotalDeLocomotoras() >= self.pesoMaximoDeVagones()
	}

	method arrastreUtilTotalDeLocomotoras() {
		return locomotoras.sum{ locomotora => locomotora.arrastreUtil() }
	}

	method pesoMaximoDeVagones() {
		return vagones.sum{ unVagon => unVagon.pesoMaximo() }
	}

	method kilosDeEmpujeQueFaltanParaMoverse() {
		if (self.puedeMoverse()) {
			return 0
		} else {
			return self.pesoMaximoDeVagones() - self.arrastreUtilTotalDeLocomotoras()
		}
	}

	method esCompleja() {
		return self.cantidadDeUnidades() > 20 or self.pesoTotalDeFormacionConVagonesYLocomotoras() > 10000
	}

	method cantidadDeUnidades() {
		return locomotoras.size() + vagones.size()
	}

	method pesoMaximoLocomotora() {
		return locomotoras.sum{ locomotora => locomotora.pesoDeLocomotora() }
	}

	method vagonMasPesadosDeUnaFormacion() {
		return vagones.max{ unVagon => unVagon.pesoMaximo() }
	}

	method pesoTotalDeFormacionConVagonesYLocomotoras() {
		return self.pesoMaximoDeVagones() + self.pesoMaximoLocomotora()
	}

	// TODO: metodos que agrego nico por que lo uso en la clase padre.
	method velocidadMaxima() {
		return self.velocidadMaximaDeLocomotoras().min(self.velocidadMaximaLegal())
	}

	method velocidadMaximaLegal()

	method cantidadDePasajeros() {
		return vagones.sum{ unVagon => unVagon.cantidadDePasajeros() }
	}

}

class FormacionCortaDistancia inherits Formacion {

	method estaBienArmada() {
		return self.puedeMoverse() and not self.esCompleja()
	}

	method velocidadMAxima() = self.velocidadMaximaDeLocomotoras().min(60)

//	override method velocidadMaxima() {
//		return self.velocidadMaximaDeLocomotoras().min(self.velocidadMaximaLegal())
//	}
	override method velocidadMaximaLegal() = 60

}

class FormacionLargaDistancia inherits Formacion {

	var property origen = null
	var property destino = null

	method estaBienArmada() {
		return self.puedeMoverse() and self.tieneSuficienteBanios()
	}

	method tieneSuficienteBanios() {
		return self.cantidadDeBanios() >= self.cantidadDePasajeros() / 50
	}

	method cantidadDeBanios() {
		return vagones.sum{ vagones => vagones.cantidadDeBanios() }
	}

	// override	method velocidadMaxima() {
//		return self.velocidadMaximaDeLocomotoras().min(self.velocidadMaximaLegal())
//	}
	override method velocidadMaximaLegal() {
		return if (origen.esGrande() and destino.esGrande()) 200 else 150
	}
	
	

}

class Ciudad {

	const property esGrande = false

}

class FormacionesDeAltaVelocidad inherits Formacion {

	var property velocidadMaximaDelTren = 400

	method estaBienArmada() {
		return self.velocidadMaxima() > 250 and vagones.all{ vagones => vagones.pesoMaximo() < 2500 }
	}

	method velocidadMaximaDelTren() {
		return 400
	}

// hice el metodo y la property por que me genera un poco de duda
}

