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
		return locomotoras.all({ locomotora => locomotora.arrastreUtil() >= locomotora.peso() * 5 })
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
		return locomotoras.sum{ locomotora => locomotora.pesoMaximo() }
	}

	method pesoTotalDeFormacionConVagonesYLocomotoras() {
		return self.pesoMaximoDeVagones() + self.pesoMaximoLocomotora()
	}

	// TODO: metodos que agrego nico por que lo uso en la clase padre.
	method velocidadMaxima() {
		return self.velocidadMaximaDeLocomotoras().min(self.velocidadMaximaLegal())
	}

	method velocidadMaximaLegal()

}

class FormacionesCortaDistancia inherits Formacion {

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

	const origen = null
	const destino = null

	method estaBienArmada() {
		return self.puedeMoverse() and not self.tieneSuficienteBanios()
	}

	method tieneSuficienteBanios() {
		return self.cantidadDeBanios() >= vagones.cantidadDePasajeros() / 50
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



