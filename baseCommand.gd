# BaseCommand.gd
extends Reference

class_name BaseCommand

# Método abstracto para obtener el nombre del comando
func getName() -> String:
    assert(false, "getName must be overridden")

# Método abstracto para verificar los parámetros
func check(params: Array) -> bool:
    assert(false, "check must be overridden")

# Método abstracto para realizar la acción
func doAction(context, params: Array) -> Variant:
    assert(false, "doAction must be overridden")
    return null

# Método abstracto para deshacer la acción
func undoAction(context, params: Array) -> Variant:
    assert(false, "undoAction must be overridden")
    return null
