import formaciones.*
import vagones.*
import locomotoras.*

class Deposito {

	var formaciones = []

	method agregarFormacion(unaFormacion) {
		formaciones.add(unaFormacion)
	}

	method conjuntoDeVagonesPesados() {
		return formaciones.map{ unVagon => unVagon.vagonMasPesadoDeUnaFormacion() }
	}

	method necesitoConductorExperimentado() {
		return formaciones.any{ unaFormacion => unaFormacion.esCompleja() }
	}

	method agregarLocomotoraSiNoPuedeMoverse(unaFormacion, unaLocomotora) {
		if (unaFormacion.puedeMoverse()) {
		} else if (self.locomotoraAptaParaSerAgregada(unaLocomotora, unaFormacion)) {
			unaFormacion.agregarLocomotora(unaLocomotora)
		}
	}

	method locomotoraAptaParaSerAgregada(unaLocomotora, unaFormacion) {
		return unaLocomotora.arrastreUtil() >= unaFormacion.cuantosKilosDeArrastreLeFalta()
	}
	

}