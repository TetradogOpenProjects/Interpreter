# Main.gd
extends Node

var context
var commands = null
var actualIndex = -1

func _ready():
    commands = load_commands("res://commands/")

    # Prueba básica de ejecución del script CSV
    run("res://scripts/sample_script.csv")

# Método para cargar comandos dinámicamente
func load_commands(path: String) -> Dictionary:
    var dir = Directory.new()
    var commands = {}

    if dir.open(path) == OK:
        dir.list_dir_begin()

        var file_name = dir.get_next()

        while file_name != "":
            if file_name.ends_with(".gd"):
                var script_path = path + file_name
                var script = load(script_path)

                if script is GDScript:
                    var command_instance = script.new()

                    if command_instance is BaseCommand:
                        commands[command_instance.getName()] = command_instance

            file_name = dir.get_next()

        dir.list_dir_end()

    return commands

# Método para leer líneas de un archivo CSV
func readLines(scriptCSVPath: String) -> Array:
    var file = File.new()
    var lines = []

    if file.open(scriptCSVPath, File.READ) == OK:
        while !file.eof_reached():
            var line = file.get_line().strip_edges().split(",")
            lines.append(line)
        file.close()

    return lines

# Método para ejecutar el script CSV
func run(scriptCSVPath: String) -> void:
    var lines = readLines(scriptCSVPath)
    actualIndex = 0

    while actualIndex < lines.size():
        var line = lines[actualIndex]
        var command_name = line[0]
        
        if commands.has(command_name):
            var actualCommand = commands[command_name]
            
            if actualCommand.check(line):
                var newIndex = actualCommand.doAction(context, line)
                
                if newIndex != null:
                    actualIndex = newIndex
                else:
                    actualIndex += 1
            else:
                print("Invalid parameters for command:", command_name,"Line:",actualIndex)
                actualIndex += 1
        else:
            print("Unknown command:", command_name,"Line:",actualIndex)
            actualIndex += 1
