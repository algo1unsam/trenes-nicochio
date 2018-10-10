import formaciones.*
import vagones.*
import locomotoras.*

class Deposito {

	var property formaciones = []
	var property locomotorasSueltas = []

	method agregarFormacion(unVagon) {
		formaciones.add(unVagon)
	}

	method vagonMasPesado() {
		return formaciones.map{ unVagon => unVagon.vagonMasPesadosDeUnaFormacion() }
	}

	method necesitaConductorExperimentado() {
		return formaciones.any{ formacion => formacion.esCompleja() }
	}
	method agregarLocomotoraSuelta(locomotora){
		locomotorasSueltas.add(locomotora)
	}

	method agregarLocomotoraAFormacionDeterminada(formacion) {
		if (!formacion.puedeMoverse()) {
			formacion.locomotoras().add(self.buscarLocomotoraSueltaApta(formacion))
		}
	}

	method buscarLocomotoraSueltaApta(formacion) {
		return locomotorasSueltas.find{ locomotora => locomotora.arrastreUtil() >= formacion.kilosDeEmpujeQueFaltanParaMoverse() }
	}

}

