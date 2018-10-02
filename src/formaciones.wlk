import vagones.*
import locomotoras.*
import deposito.*

class Formacion {

	var property locomotoras = []
	var property vagones = []

	method agregarVagon(unVagon) {
		vagones.add(unVagon)
	}

	method agregarLocomotora(unaLocomotora) {
		locomotoras.add(unaLocomotora)
	}

	method velocidadMaxima() {
		return locomotoras.min{ unaLocomotora => unaLocomotora.velocidadMaxima() }.velocidadMaxima()
	}

	method cantidadVagonesLivianos() {
		return vagones.count({ unVagon => unVagon.pesoMaximo() < 2500 })
	}

	method sumatoriaDePesoMaximoDeVagones() {
		return vagones.sum{ unVagon => unVagon.pesoMaximo() }
	}

	method vagonMasPesadoDeUnaFormacion() {
		return vagones.max{ unVagon => unVagon.pesoMaximo() }
	}

	method sumatoriaDeArrastre() {
		return locomotoras.sum{ unaLocomotora => unaLocomotora.arrastreUtil() }
	}

	method puedeMoverse() {
		return self.sumatoriaDeArrastre() > self.sumatoriaDePesoMaximoDeVagones()
	}

	method sumatoriaDePesoMaximoDeLocomotoras() {
		return locomotoras.sum{ unaLocomotora => unaLocomotora.peso() }
	}

	method esEficiente() {
		return locomotoras.all{ unaLocomotora => unaLocomotora.arrastreUtil() >= unaLocomotora.peso() * 5 }
	}

	method cuantosKilosDeArrastreLeFalta() {
		return self.sumatoriaDePesoMaximoDeVagones() - self.sumatoriaDeArrastre()
	}

	method esCompleja() {
		return (locomotoras.size() + vagones.size()) > 20 or (self.sumatoriaDePesoMaximoDeLocomotoras() + self.sumatoriaDePesoMaximoDeVagones()) > 10000
	}

}

