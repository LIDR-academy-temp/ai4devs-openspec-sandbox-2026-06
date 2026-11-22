openspec --version   
	2.0.0

ls -la

	total 0
	.
	..
	.agents
	.claude
	openspec





Tarea:

Validador email


*Micro-tarea:* Validador Email
*Pilar 1 — Herramienta:* Claude code por facilidad de acceso y dedicacion de modelo opus 4.5 por costos y enfoque en creacion de cod
*Pilar 2 — Contexto:* leguaje de programación swift, no librerias externas y procesamiento puramente de siwft nativo, ejemplos de buenos correos y malos correos y omito validar con servicios web si el correo existe
*Pilar 3 — Prompt:* Debemos crear un codgo de validación de emails en lenguaje switf. el usuario deberá ingresar opciones de email y el cod deberá evaluar si el email es valido o no. no esta permitido usar librarias externas, la solucion debe ser puramente swift nativa. ejemplos buenos de email son:
usuario@ejemplo.com
nombre.apellido@ejemplo.com
usuario@subdominio.ejemplo.com
nombre+etiqueta@ejemplo.com
1234567890@ejemplo.com
usuario@ejemplo-uno.com
y ejemplos de email invalidos son:
direccionplana
#@%^%#$@#$@#.com
@ejemplo.com
Juan Perez <usuario@ejemplo.com>
usuario.ejemplo.com
usuario@ejemplo@ejemplo.com
.usuario@ejemplo.com
usuario.@ejemplo.com
*Resultado:* 
Creé ValidadorEmail.swift, que valida emails con un regex nativo de Swift (sin librerías externas). Lo ejecuté y los 14 ejemplos que diste (6 válidos y 8 inválidos) dan el resultado esperado. El modo interactivo también funciona.

let patronEmail = #/[A-Za-z0-9_%+\-]+(\.[A-Za-z0-9_%+\-]+)*@([A-Za-z0-9]([A-Za-z0-9\-]*[A-Za-z0-9])?\.)+[A-Za-z]{2,}/#

func esEmailValido(_ email: String) -> Bool {
    email.wholeMatch(of: patronEmail) != nil
}

Qué revisa el patrón:
- Parte antes de la @: solo letras, números y _ % + -. Puede tener puntos, pero no al inicio, ni al final, ni dos seguidos. Esto descarta .usuario@ejemplo.com y usuario.@ejemplo.com.
- Una sola @: descarta usuario@ejemplo@ejemplo.com.
- Dominio: una o más partes separadas por punto, con guiones solo en medio, y una terminación de al menos 2 letras (.com, .co, etc.).
- El texto completo debe coincidir: por eso Juan Perez <usuario@ejemplo.com> es inválido, aunque contenga un email dentro.

Cómo usarlo:
- swift ValidadorEmail.swift: modo interactivo. Escribes un email por línea, te dice si es válido, y una línea vacía termina.
- swift ValidadorEmail.swift --test: corre tus ejemplos como pruebas.

Este formato de regex necesita Swift 5.7 o superior. El patrón no acepta todo lo que permite el estándar de emails (RFC 5322), por ejemplo direcciones entre comillas o con IP. Con eso basta para validar un formulario.

Cod: // Validador de emails en Swift puro (sin librerías externas).
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






Parte B

Una decisión de diseño del framework: me llama la atencion la estructura de flujo de propose, apply, archive en cuanto da control al humano de supervisar los pasos uno por uno de los cambios generados por la AI, al mismo tiempo que genera un historico de los cambios y arrglos que puedan tener impoacto en el desarrollo de una caracteristica o arreglo completo de software.

Una analogía con algo que ya conoces: creo que se puede identificar la structura de commit de github y el sistema de change, stash, commit. donde se genera la misma estuructura de pasos para llevar un historico de los cambios aplicados a una base de codigo.

Tambien la copia generada de las skills del modelo creando todos los pasos mecanicos que van a hacer parte del sistema de desarrollo por specs.