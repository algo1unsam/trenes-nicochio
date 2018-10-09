import formaciones.*
import deposito.*
import locomotoras.*
import vagones.*
class VagonDePasajero {

	var property largoUtil = 5
	var property anchoUtil = 0

	method cantidadDePasajeros() {
		if (anchoUtil <= 2.5) {
			return largoUtil * 8
		} else {
			return largoUtil * 10
		}
	}

	method pesoMaximo() {
		return self.cantidadDePasajeros() * 80
	}

	method cantidadDeBanios() {
		if (self.cantidadDePasajeros() < 50) return 1 else return self.cantidadDePasajeros() / 50
	}

}

class VagonDeCarga {

	var property cargaMaxima = 100

	method cantidadDePAsajeros() {
		return 0
	}

	method pesoMaximo() {
		return self.cargaMaxima() + 160
	}

	method cantidadDeBanios() = return 0

}

