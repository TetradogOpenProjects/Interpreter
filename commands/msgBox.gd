# MsgBox.gd
extends BaseCommand

class_name MsgBox

func getName() -> String:
    return "MsgBox"

func check(params: Array) -> bool:
    var isOk = params.size() >= 2
    
    if params.size() > 2:
        isOk = typeof(params[2]) == TYPE_STRING and params[2].is_valid_int()
            
    return isOk

func doAction(context, params: Array) -> Variant:
    var text = params[1]
    var type = 0
    
    if params.size() > 2:
        type = int(params[2])
    
    # Aquí deberías implementar la lógica para mostrar el mensaje según el tipo y contexto
    print("Showing message:", text)
    
    return null

func undoAction(context, params: Array) -> Variant:
    # Implementa la lógica para deshacer la acción, si es necesario
    print("Undoing message display")
    return null
