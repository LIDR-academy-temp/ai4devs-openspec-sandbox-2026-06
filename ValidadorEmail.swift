// Validador de emails en Swift puro (sin librerías externas).
// Uso:  swift ValidadorEmail.swift          -> modo interactivo
//       swift ValidadorEmail.swift --test   -> corre los ejemplos

// local: bloques de [A-Za-z0-9_%+-] separados por un solo punto (sin punto al inicio/fin)
// dominio: etiquetas alfanuméricas (guion solo en medio) + TLD de 2+ letras
let patronEmail = #/[A-Za-z0-9_%+\-]+(\.[A-Za-z0-9_%+\-]+)*@([A-Za-z0-9]([A-Za-z0-9\-]*[A-Za-z0-9])?\.)+[A-Za-z]{2,}/#

func esEmailValido(_ email: String) -> Bool {
    email.wholeMatch(of: patronEmail) != nil
}

func pruebas() {
    let validos = [
        "usuario@ejemplo.com", "nombre.apellido@ejemplo.com", "usuario@subdominio.ejemplo.com",
        "nombre+etiqueta@ejemplo.com", "1234567890@ejemplo.com", "usuario@ejemplo-uno.com",
    ]
    let invalidos = [
        "direccionplana", "#@%^%#$@#$@#.com", "@ejemplo.com", "Juan Perez <usuario@ejemplo.com>",
        "usuario.ejemplo.com", "usuario@ejemplo@ejemplo.com", ".usuario@ejemplo.com", "usuario.@ejemplo.com",
    ]
    for e in validos { assert(esEmailValido(e), "debería ser válido: \(e)") }
    for e in invalidos { assert(!esEmailValido(e), "debería ser inválido: \(e)") }
    print("✅ Todas las pruebas pasaron (\(validos.count + invalidos.count) casos)")
}

if CommandLine.arguments.contains("--test") {
    pruebas()
} else {
    print("Ingresa un email (línea vacía para salir):")
    while let linea = readLine(), !linea.isEmpty {
        print(esEmailValido(linea) ? "✅ '\(linea)' es válido" : "❌ '\(linea)' NO es válido")
    }
}
