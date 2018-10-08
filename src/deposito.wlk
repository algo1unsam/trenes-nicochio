import formaciones.*
import vagones.*
import locomotoras.*

class Deposito {

	var property formaciones = []
	var property locomotorasSueltas = []

	method agregarVagones(unVagon) {
		formaciones.add(unVagon)
	}

	method vagonMasPesado() {
		return formaciones.map{ formacion => formacion.pesoMaximo() }
	}

	method necesitaConductorExperimentado() {
		return formaciones.any{ formacion => formacion.esCompleta() }
	}

	method agregarLocomotoraAFormacionDeterminada(formacion) {
		if (!formacion.puedeMoverse()) {
			formacion.add(self.buscarLocomotoraSueltaApta(formacion))
		}
	}

	method buscarLocomotoraSueltaApta(formacion) {
		return locomotorasSueltas.find{ locomotora => locomotora.arrastreUtil() >= formacion.empuje() }
	}

}

