package project

fun obtemMenu(): String = """*** JOGO DA FORCA ***
1 - Escolher categoria
2 - Iniciar jogo
0 - Sair
"""

fun getOptionsList(): String = """>>> Escolha a categoria
A - Frutas
B - Cidades
C - Nomes proprios
0 - Sair sem escolher categoria
"""

fun geraPalavra(categoria: String): String {
    val index = (0..2).random()
    var guess = ""
    when (categoria[0]) {
        'A' -> {
            when (index) {
                0 -> guess = "morango"
                1 -> guess = "amora"
                2 -> guess = "mirtilo"

            }
        }
        'B' -> {
            when (index) {
                0 -> guess = "lisboa"
                1 -> guess = "luanda"
                2 -> guess = "londres"
            }
        }
        'C' -> {
            when (index) {
                0 -> guess = "vera"
                1 -> guess = "sara"
                2 -> guess = "miguel"
            }
        }

    }
    return guess
}

fun oneWrod(word: String): Boolean {
    var oneWord = true
    var quanto = 0
    while (quanto < word.length && oneWord) {
        if (word[quanto] == ' ') {
            oneWord = false
        }
        quanto += 1
    }
    return oneWord
}

fun validCharacters(nome: String): Boolean {
    var quanto = 0
    var valid = true
    while (quanto < nome.length) {
        if (nome[quanto] !in 'A'..'z' && nome[quanto] != ' ') {
            valid = false
        }
        quanto += 1
    }
    return valid
}

fun dividWord(nome: String, start: Int, end: Int): String {
    var count: Int = start
    var divide = ""
    while (count <= end) {
        divide += nome[count]
        count += 1
    }
    return divide
}

fun validaNome(nome: String): Boolean {
    if (!validCharacters(nome)) {
        return false
    }
    var twoWords = false
    var quanto = 0
    while (quanto < nome.length && !twoWords) {
        if (nome[quanto] == ' ') {
            twoWords = true
        }
        quanto += 1
    }
    if (!twoWords) {
        return false
    }

    val firstWord = dividWord(nome, 0, quanto - 2)
    val secondWord = dividWord(nome, quanto, nome.length - 1)

    if (oneWrod(firstWord) && oneWrod(secondWord)) {
        if (firstWord.length >= 2 && secondWord.length >= 2) {
            return true
        } else {
            return false
        }
    } else {
        return false
    }
}

fun getName(): String {
    println("Introduza o nome do jogador(a):")
    do {
        val name = readLine()?.toString()

        if (name != null && validaNome(name)) {
            return name
        } else {
            println("Nome invalido, tente novamente")
        }
    } while (true)
}

fun estruturaPalavra(palavra: String, letra: Char?): String {
    if (letra == null) {
        var estrPal = ""
        var quanto = 0
        while (quanto < palavra.length) {
            estrPal = estrPal + "_" + " "
            quanto += 1
        }
        return estrPal
    } else {
        var estrPal = ""
        var quanto = 0
        while (quanto < palavra.length) {
            if (palavra[quanto] == letra.toLowerCase()) {
                estrPal = estrPal + letra.toLowerCase() + " "
            } else {
                estrPal = estrPal + "_" + " "
            }
            quanto += 1
        }
        return estrPal
    }
}

fun numOcorrencias(palavra: String, letra: Char): Int? {
    var count = 0
    var numOcr = 0
    while (count < palavra.length) {
        if (palavra[count] == letra.toLowerCase()) {
            numOcr += 1
        }
        count += 1
    }
    if (numOcr == 0) {
        return null
    } else {
        return numOcr
    }
}

fun play(option: String) {
    val tentativas = 6
    val nome = getName()
    val palavra = geraPalavra(option)
    var erros = 0

    println(nome)

    var nomeCategoria = ""

    when (option[0]) {
        'A' -> nomeCategoria = "Frutas"
        'B' -> nomeCategoria = "Cidades"
        'C' -> nomeCategoria = "Nomes"
    }

    println("Categoria: $nomeCategoria | Erros: $erros")
    print("Palavra: ")
    println(estruturaPalavra(palavra, null))

    do {
        var letra: String?
        do {
            println("Introduza uma letra: ")
            letra = readLine()
            var correta = false
            if (letra == null || letra == "" || letra.length > 1 || !(letra[0].toUpperCase() >= 'A' && letra[0].toUpperCase() <= 'Z')) {
                println("Letra invalida, tente novamente")

            } else {
                correta = true
            }
        } while (!correta)
        var numOcr: Int?
        if (letra != null) {
            numOcr = numOcorrencias(palavra, letra[0])
            if (numOcr == null) {
                erros += 1
                println(">>> Errado. A letra \'$letra\' nao aparece.")
            } else {
                println(">>> Certo. A letra \'$letra\' aparece ${numOcr}X.")
            }
        }
        println("Categoria: $nomeCategoria | Erros: $erros")
        print("Palavra: ")
        if (letra != null) {
            println(estruturaPalavra(palavra, letra[0]))
        }
    } while (erros < tentativas)

    println(
        """*** PERDEU! A palavra era $palavra ***
prima enter para voltar ao menu
"""
    )
    var entrada: String?
    do {
        entrada = readLine()
        var correta = false
        if (entrada == null || entrada == "") {
            correta = true
        }
    } while (!correta)


}

fun main() {
    var mainMenuLoop = true
    var option: String? = ""

    do {
        println(obtemMenu())

        val categoria = getOptionsList()
        val menu = readLine()?.toIntOrNull()


        if (menu == 1) {
            var categLoop = true
            do {
                println(categoria)
                option = readLine()
                if (option == null || option == "") {
                    categLoop = false
                } else if (option != null || (option[0] == 'A' || option[0] == 'B' || option[0] == 'C') && option.length == 1) {
                    categLoop = false
                } else if (option != null || option[0] == '0') {
                    println("Sair sem escolher categoria")
                    categLoop = false
                } else {
                    println("Opcao invalida, tente novamente")
                }
            } while (categLoop)

        } else if (menu == 2) {
            if (option != null && (option == "" || option[0] == '0')) {
                println(
                    "Tem que escolher primeiro a categoria, tente\n" +
                            "novamente"
                )
            } else {
                if (option != null && option[0] == 'A') {
                    play(option)
                } else if (option != null && option[0] == 'B') {
                    play(option)
                } else if (option != null && option[0] == 'C') {
                    play(option)
                }
            }
        } else if (menu == 0) {
            mainMenuLoop = false
        } else {
            println("Opcao invalida , tente novamente")
        }
    } while (mainMenuLoop)
}
