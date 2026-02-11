import '../models/vocab.dart';

// Minimal starter content for 5 levels
final List<Level> levels = [
  Level(
    title: 'LEVEL 1 — Basic Verbs',
    description: 'Tap to study this level',
    number: 1,
    accentColor: 0xFFE53935,
    imageUrl: 'asset:assets/images/levels/level1.png',
    version: 10,
    theory: '''
# Nivel 1: El Motor del Idioma

Los verbos son palabras de acción y estado. Sin ellos, no puedes construir ninguna idea en inglés; son el motor que hace que tus oraciones cobren vida.

En este nivel aprenderás los pilares fundamentales para comunicarte. Los hemos dividido en grupos para que tu cerebro los asimile mejor:

* **Los 3 Pilares (Auxiliares):** Be, Have y Do. Son los más usados en todo el idioma para describir quién eres, qué tienes y qué haces.
* **Movimiento y Cuerpo:** Palabras como Go, Run, Walk, Sit y Stand. Ideales para describir tu día a día.
* **Tus Sentidos:** Aprenderás a expresar lo que percibes con See, Look, Watch y Hear.
* **Deseos y Pensamientos:** Empieza a decir lo que sientes con Want, Need, Like y Know.
* **Interacción Diaria:** Acciones básicas como Eat, Drink, Give, Take y Open.

### Tu Meta
Al terminar este nivel, habrás dominado las 30 acciones más frecuentes del inglés. ¡Con esto ya puedes describir casi cualquier actividad básica!
''',
    items: const [
      // Level 1 verbs with sentence examples (Sentence Fill will use these)
      VocabItem(word: 'be',    translation: 'ser/estar', sentenceWithBlank: 'I ___ ready for class.',              sentenceAnswer: 'am',    emoji: '🙂', sentenceTranslationWithBlank: 'Yo ___ listo para la clase.'),
      VocabItem(word: 'have',  translation: 'tener',      sentenceWithBlank: 'They ___ a meeting at noon.',         sentenceAnswer: 'have',  emoji: '📦', sentenceTranslationWithBlank: 'Ellos ___ una reunión al mediodía.'),
      VocabItem(word: 'do',    translation: 'hacer',      sentenceWithBlank: 'She ___ her homework after dinner.',   sentenceAnswer: 'does',  emoji: '✅', sentenceTranslationWithBlank: 'Ella ___ su tarea después de la cena.'),
      VocabItem(word: 'go',    translation: 'ir',         sentenceWithBlank: 'We ___ to the gym on Mondays.',        sentenceAnswer: 'go',    emoji: '➡️', sentenceTranslationWithBlank: 'Nosotros ___ al gimnasio los lunes.'),
      VocabItem(word: 'come',  translation: 'venir',      sentenceWithBlank: 'He ___ home early on Fridays.',        sentenceAnswer: 'comes', emoji: '⬅️', sentenceTranslationWithBlank: 'Él ___ a casa temprano los viernes.'),
      VocabItem(word: 'get',   translation: 'obtener',    sentenceWithBlank: 'I ___ up at six every day.',          sentenceAnswer: 'get',   emoji: '🫴🏻', sentenceTranslationWithBlank: 'Yo ___ a las seis todos los días.'),
      VocabItem(word: 'make',  translation: 'hacer',      sentenceWithBlank: 'She ___ breakfast for her family.',    sentenceAnswer: 'makes', emoji: '🛠️', sentenceTranslationWithBlank: 'Ella ___ el desayuno para su familia.'),
      VocabItem(word: 'take',  translation: 'tomar',      sentenceWithBlank: 'They ___ the bus to work.',            sentenceAnswer: 'take',  emoji: '🚌', sentenceTranslationWithBlank: 'Ellos ___ el autobús al trabajo.'),
      VocabItem(word: 'give',  translation: 'dar',        sentenceWithBlank: 'He ___ gifts to his friends.',         sentenceAnswer: 'gives', emoji: '🎁', sentenceTranslationWithBlank: 'Él ___ regalos a sus amigos.'),
      VocabItem(word: 'use',   translation: 'usar',       sentenceWithBlank: 'We ___ this app to study vocab.',      sentenceAnswer: 'use',   emoji: '🧰', sentenceTranslationWithBlank: 'Nosotros ___ esta aplicación para estudiar vocabulario.'),
      VocabItem(word: 'walk',  translation: 'caminar',    sentenceWithBlank: 'They ___ to school every day.',              sentenceAnswer: 'walk',  emoji: '🚶', sentenceTranslationWithBlank: 'Ellos ___ a la escuela todos los días.'),
VocabItem(word: 'run',   translation: 'correr',     sentenceWithBlank: 'I ___ fast in the park.',                    sentenceAnswer: 'run',   emoji: '🏃', sentenceTranslationWithBlank: 'Yo ___ rápido en el parque.'),
VocabItem(word: 'sit',   translation: 'sentarse',   sentenceWithBlank: 'Please ___ on the chair.',                  sentenceAnswer: 'sit',   emoji: '🪑', sentenceTranslationWithBlank: 'Por favor ___ en la silla.'),
VocabItem(word: 'stand', translation: 'pararse',    sentenceWithBlank: 'We ___ in line quietly.',                   sentenceAnswer: 'stand', emoji: '🧍', sentenceTranslationWithBlank: 'Nosotros ___ en la fila en silencio.'),
VocabItem(word: 'open',  translation: 'abrir',      sentenceWithBlank: 'Can you ___ the window?',                  sentenceAnswer: 'open',  emoji: '🔓', sentenceTranslationWithBlank: '¿Puedes ___ la ventana?'),
VocabItem(word: 'close', translation: 'cerrar',     sentenceWithBlank: 'Please ___ the door.',                     sentenceAnswer: 'close', emoji: '🚪', sentenceTranslationWithBlank: 'Por favor ___ la puerta.'),
VocabItem(word: 'put',   translation: 'poner',      sentenceWithBlank: 'I ___ the keys on the table.',             sentenceAnswer: 'put',   emoji: '🧤', sentenceTranslationWithBlank: 'Yo ___ las llaves sobre la mesa.'),
VocabItem(word: 'bring', translation: 'traer',      sentenceWithBlank: 'Can you ___ your book tomorrow?',          sentenceAnswer: 'bring', emoji: '📚', sentenceTranslationWithBlank: '¿Puedes ___ tu libro mañana?'),
VocabItem(word: 'see',   translation: 'ver',        sentenceWithBlank: 'I can ___ the mountains from here.',        sentenceAnswer: 'see',   emoji: '👀', sentenceTranslationWithBlank: 'Puedo ___ las montañas desde aquí.'),
VocabItem(word: 'look',  translation: 'mirar',      sentenceWithBlank: '___ at this picture.',                      sentenceAnswer: 'look',  emoji: '🔍', sentenceTranslationWithBlank: '___ esta imagen.'),

VocabItem(word: 'watch', translation: 'ver/observar', sentenceWithBlank: 'We ___ TV at night.',                    sentenceAnswer: 'watch', emoji: '📺', sentenceTranslationWithBlank: 'Nosotros ___ televisión por la noche.'),
VocabItem(word: 'hear',  translation: 'oír',        sentenceWithBlank: 'I can ___ music from the room.',            sentenceAnswer: 'hear',  emoji: '👂', sentenceTranslationWithBlank: 'Puedo ___ música desde la habitación.'),
VocabItem(word: 'say',   translation: 'decir',      sentenceWithBlank: 'What did he ___ to you?',                   sentenceAnswer: 'say',   emoji: '🗣️', sentenceTranslationWithBlank: '¿Qué te ___ él?'),
VocabItem(word: 'ask',   translation: 'preguntar',  sentenceWithBlank: 'You can ___ me anything.',                  sentenceAnswer: 'ask',   emoji: '❓', sentenceTranslationWithBlank: 'Puedes ___me cualquier cosa.'),
VocabItem(word: 'want',  translation: 'querer',     sentenceWithBlank: 'I ___ a new phone.',                        sentenceAnswer: 'want',  emoji: '💭', sentenceTranslationWithBlank: 'Yo ___ un teléfono nuevo.'),
VocabItem(word: 'like',  translation: 'gustar',     sentenceWithBlank: 'I ___ this song a lot.',                    sentenceAnswer: 'like',  emoji: '👍', sentenceTranslationWithBlank: 'Me ___ mucho esta canción.'),
VocabItem(word: 'need',  translation: 'necesitar',  sentenceWithBlank: 'We ___ more time.',                         sentenceAnswer: 'need',  emoji: '⏳', sentenceTranslationWithBlank: 'Nosotros ___ más tiempo.'),
VocabItem(word: 'know',  translation: 'saber',      sentenceWithBlank: 'Do you ___ the answer?',                    sentenceAnswer: 'know',  emoji: '🧠', sentenceTranslationWithBlank: '¿Tú ___ la respuesta?'),
VocabItem(word: 'eat',   translation: 'comer',      sentenceWithBlank: 'We ___ dinner at 7 p.m.',                   sentenceAnswer: 'eat',   emoji: '🍽️', sentenceTranslationWithBlank: 'Nosotros ___ la cena a las 7 p.m.'),
VocabItem(word: 'drink', translation: 'beber',      sentenceWithBlank: 'I ___ water every morning.',                sentenceAnswer: 'drink', emoji: '🥤', sentenceTranslationWithBlank: 'Yo ___ agua cada mañana.'),

    ],
  ),
  Level(
    title: 'LEVEL 2 — Common Nouns',
    description: 'Tap to study this level',
    number: 2,
    accentColor: 0xFFF4511E,
    imageUrl: 'asset:assets/images/levels/level2.png',
    version: 9,
    theory: '''
# Sustantivos Comunes

Los sustantivos (nouns) son las palabras que usamos para nombrar todo lo que existe: personas, lugares, objetos e ideas. Si los verbos son el motor, los sustantivos son los "bloques" con los que construyes tus frases.

En este nivel aprenderás sustantivos esenciales que aparecen en el 80% de las conversaciones cotidianas, organizados por categorías:

### Grupos de Palabras:
* **Humanidad:** People (Gente), Man/Woman (Hombre/Mujer), Friend (Amigo).
* **Conceptos de Tiempo:** Time (Tiempo), Day (Día), Year (Año).
* **El Mundo y Lugares:** World (Mundo), Life (Vida), Place (Lugar).
* **Cosas e Ideas:** Thing (Cosa), Way (Manera/Camino), Part (Parte).

### 💡 Tip de "Level Up":
En inglés, la mayoría de los sustantivos se vuelven plurales añadiendo una **"-s"** al final (ej. *Day* → *Days*). Sin embargo, ¡ten cuidado con **People**! Es una palabra especial que ya significa "personas" en plural.

**Misión:** Domina estos nombres y estarás listo para combinar acciones con objetos reales. ¡A por ello!
''',
    items: const [
    VocabItem(word: 'phone', translation: 'teléfono', sentenceWithBlank: 'My ___ is on the table.', sentenceAnswer: 'phone', emoji: '📱', sentenceTranslationWithBlank: 'Mi ___ está en la mesa.'),
VocabItem(word: 'house', translation: 'casa', sentenceWithBlank: 'This ___ is very big.', sentenceAnswer: 'house', emoji: '🏠', sentenceTranslationWithBlank: 'Esta ___ es muy grande.'),
VocabItem(word: 'car', translation: 'carro', sentenceWithBlank: 'I drive my ___ to work.', sentenceAnswer: 'car', emoji: '🚗', sentenceTranslationWithBlank: 'Conduzco mi ___ al trabajo.'),
VocabItem(word: 'bag', translation: 'bolsa', sentenceWithBlank: 'Her ___ is on the chair.', sentenceAnswer: 'bag', emoji: '👜', sentenceTranslationWithBlank: 'Su ___ está en la silla.'),
VocabItem(word: 'cup', translation: 'taza', sentenceWithBlank: 'I drink tea from a ___.', sentenceAnswer: 'cup', emoji: '☕', sentenceTranslationWithBlank: 'Tomo té de una ___.'),
VocabItem(word: 'key', translation: 'llave', sentenceWithBlank: 'Where is my ___?', sentenceAnswer: 'key', emoji: '🔑', sentenceTranslationWithBlank: '¿Dónde está mi ___?'),
VocabItem(word: 'door', translation: 'puerta', sentenceWithBlank: 'Please close the ___.', sentenceAnswer: 'door', emoji: '🚪', sentenceTranslationWithBlank: 'Por favor cierra la ___.'),
VocabItem(word: 'chair', translation: 'silla', sentenceWithBlank: 'Sit on that ___.', sentenceAnswer: 'chair', emoji: '🪑', sentenceTranslationWithBlank: 'Siéntate en esa ___.'),
VocabItem(word: 'table', translation: 'mesa', sentenceWithBlank: 'The food is on the ___.', sentenceAnswer: 'table', emoji: '🍽️', sentenceTranslationWithBlank: 'La comida está en la ___.'),
VocabItem(word: 'window', translation: 'ventana', sentenceWithBlank: 'Open the ___ for fresh air.', sentenceAnswer: 'window', emoji: '🪟', sentenceTranslationWithBlank: 'Abre la ___ para aire fresco.'),
VocabItem(word: 'book', translation: 'libro', sentenceWithBlank: 'I read a ___ every night.', sentenceAnswer: 'book', emoji: '📖', sentenceTranslationWithBlank: 'Leo un ___ todas las noches.'),
VocabItem(word: 'pen', translation: 'bolígrafo', sentenceWithBlank: 'I write with a ___.', sentenceAnswer: 'pen', emoji: '🖊️', sentenceTranslationWithBlank: 'Escribo con un ___.'),
VocabItem(word: 'notebook', translation: 'cuaderno', sentenceWithBlank: 'The ___ is in my bag.', sentenceAnswer: 'notebook', emoji: '📓', sentenceTranslationWithBlank: 'El ___ está en mi bolsa.'),
VocabItem(word: 'computer', translation: 'computadora', sentenceWithBlank: 'My ___ is very fast.', sentenceAnswer: 'computer', emoji: '💻', sentenceTranslationWithBlank: 'Mi ___ es muy rápida.'),
VocabItem(word: 'bed', translation: 'cama', sentenceWithBlank: 'I sleep on a ___.', sentenceAnswer: 'bed', emoji: '🛏️', sentenceTranslationWithBlank: 'Duermo en una ___.'),
VocabItem(word: 'lamp', translation: 'lámpara', sentenceWithBlank: 'Turn on the ___.', sentenceAnswer: 'lamp', emoji: '💡', sentenceTranslationWithBlank: 'Enciende la ___.'),
VocabItem(word: 'clock', translation: 'reloj', sentenceWithBlank: 'The ___ shows 7:00.', sentenceAnswer: 'clock', emoji: '⏰', sentenceTranslationWithBlank: 'El ___ marca las 7:00.'),
VocabItem(word: 'shirt', translation: 'camisa', sentenceWithBlank: 'I like your ___.', sentenceAnswer: 'shirt', emoji: '👕', sentenceTranslationWithBlank: 'Me gusta tu ___.'),
VocabItem(word: 'shoes', translation: 'zapatos', sentenceWithBlank: 'My ___ are dirty.', sentenceAnswer: 'shoes', emoji: '👟', sentenceTranslationWithBlank: 'Mis ___ están sucios.'),
VocabItem(word: 'water', translation: 'agua', sentenceWithBlank: 'I drink ___ every day.', sentenceAnswer: 'water', emoji: '💧', sentenceTranslationWithBlank: 'Bebo ___ todos los días.'),
VocabItem(word: 'money', translation: 'dinero', sentenceWithBlank: 'I need more ___.', sentenceAnswer: 'money', emoji: '💵', sentenceTranslationWithBlank: 'Necesito más ___.'),
VocabItem(word: 'food', translation: 'comida', sentenceWithBlank: 'The ___ is on the plate.', sentenceAnswer: 'food', emoji: '🍲', sentenceTranslationWithBlank: 'La ___ está en el plato.'),
VocabItem(word: 'bottle', translation: 'botella', sentenceWithBlank: 'The ___ is full of water.', sentenceAnswer: 'bottle', emoji: '🥤', sentenceTranslationWithBlank: 'La ___ está llena de agua.'),
VocabItem(word: 'wallet', translation: 'cartera', sentenceWithBlank: 'His ___ has no money.', sentenceAnswer: 'wallet', emoji: '👛', sentenceTranslationWithBlank: 'Su ___ no tiene dinero.'),
VocabItem(word: 'paper', translation: 'papel', sentenceWithBlank: 'I need a piece of ___.', sentenceAnswer: 'paper', emoji: '📄', sentenceTranslationWithBlank: 'Necesito un pedazo de ___.'),
VocabItem(word: 'phone charger', translation: 'cargador', sentenceWithBlank: 'I forgot my ___.', sentenceAnswer: 'phone charger', emoji: '🔌', sentenceTranslationWithBlank: 'Olvidé mi ___.'),

    ],
  ),
  Level(
    title: 'LEVEL 3 — Adjectives',
    description: 'Tap to study this level',
    number: 3,
    accentColor: 0xFF43A047,
    imageUrl: 'asset:assets/images/levels/level3.png',
    version: 10,
    theory: '''
# Adjetivos


Los adjetivos son palabras que describen o califican a los sustantivos (personas, lugares o cosas). Sin ellos, el lenguaje sería aburrido; ellos le dan "color" y detalle a tus ideas.

En este nivel dominarás **30 adjetivos fundamentales** organizados en parejas de opuestos para que sea más fácil recordarlos:

### Categorías Clave:
**Tamaños y Dimensiones:** Big (Grande) vs Small (Pequeño), Long vs Short.
**Velocidad y Estado:** Fast (Rápido) vs Slow (Lento), Clean vs Dirty.
**Sentimientos y Apariencia:** Happy (Feliz) vs Sad (Triste), Beautiful vs Ugly.
**Calidad y Opinión:** Good (Bueno) vs Bad (Malo), Easy vs Hard.
**Valor y Verdad:** Cheap (Barato) vs Expensive (Caro), Right vs Wrong.

### 💡 Regla de Oro:
A diferencia del español, en inglés el adjetivo normalmente va **antes** del sustantivo.
**Español:** Una casa **grande**.
**Inglés:** A **big** house.

¡Completa este nivel y empieza a describir el mundo que te rodea con precisión!
''',
    items: const [
      VocabItem(word: 'big',      translation: 'grande',        sentenceWithBlank: 'The house is very ___.',            sentenceAnswer: 'big',      emoji: '⬆️'),
VocabItem(word: 'small',    translation: 'pequeño',       sentenceWithBlank: 'This box is too ___.',             sentenceAnswer: 'small',    emoji: '⬇️'),
VocabItem(word: 'easy',     translation: 'fácil',         sentenceWithBlank: 'This exercise is ___.',           sentenceAnswer: 'easy',     emoji: '👌'),
VocabItem(word: 'hard',     translation: 'difícil',       sentenceWithBlank: 'The test was very ___.',          sentenceAnswer: 'hard',     emoji: '💪'),
VocabItem(word: 'good',     translation: 'bueno',         sentenceWithBlank: 'He is a ___ student.',            sentenceAnswer: 'good',     emoji: '👍'),
VocabItem(word: 'bad',      translation: 'malo',          sentenceWithBlank: 'That was a ___ idea.',            sentenceAnswer: 'bad',      emoji: '👎'),
VocabItem(word: 'new',      translation: 'nuevo',         sentenceWithBlank: 'I bought a ___ phone.',           sentenceAnswer: 'new',      emoji: '🆕'),
VocabItem(word: 'old',      translation: 'viejo',         sentenceWithBlank: 'This shirt is very ___.',         sentenceAnswer: 'old',      emoji: '📦'),
VocabItem(word: 'happy',    translation: 'feliz',         sentenceWithBlank: 'She feels very ___.',             sentenceAnswer: 'happy',    emoji: '😊'),
VocabItem(word: 'sad',      translation: 'triste',        sentenceWithBlank: 'He looks ___.',                   sentenceAnswer: 'sad',      emoji: '😢'),

VocabItem(word: 'hot',      translation: 'caliente',      sentenceWithBlank: 'The soup is very ___.',           sentenceAnswer: 'hot',      emoji: '🔥'),
VocabItem(word: 'cold',     translation: 'frío',          sentenceWithBlank: 'The water is ___.',               sentenceAnswer: 'cold',     emoji: '❄️'),
VocabItem(word: 'long',     translation: 'largo',         sentenceWithBlank: 'It is a ___ road.',               sentenceAnswer: 'long',     emoji: '📏'),
VocabItem(word: 'short',    translation: 'corto',         sentenceWithBlank: 'The movie is very ___.',          sentenceAnswer: 'short',    emoji: '✂️'),
VocabItem(word: 'fast',     translation: 'rápido',        sentenceWithBlank: 'The car is very ___.',            sentenceAnswer: 'fast',     emoji: '⚡'),
VocabItem(word: 'slow',     translation: 'lento',         sentenceWithBlank: 'The internet is ___.',            sentenceAnswer: 'slow',     emoji: '🐌'),
VocabItem(word: 'clean',    translation: 'limpio',        sentenceWithBlank: 'The room is very ___.',           sentenceAnswer: 'clean',    emoji: '🧼'),
VocabItem(word: 'dirty',    translation: 'sucio',         sentenceWithBlank: 'My shoes are ___.',               sentenceAnswer: 'dirty',    emoji: '🧹'),
VocabItem(word: 'young',    translation: 'joven',         sentenceWithBlank: 'She is very ___.',                sentenceAnswer: 'young',    emoji: '👧'),
VocabItem(word: 'old',      translation: 'viejo',         sentenceWithBlank: 'My car is very ___.',             sentenceAnswer: 'old',      emoji: '🧓'),

VocabItem(word: 'strong',   translation: 'fuerte',        sentenceWithBlank: 'He is very ___.',                 sentenceAnswer: 'strong',   emoji: '🏋️'),
VocabItem(word: 'weak',     translation: 'débil',         sentenceWithBlank: 'I feel ___.',                     sentenceAnswer: 'weak',     emoji: '🥀'),
VocabItem(word: 'beautiful',translation: 'hermoso',       sentenceWithBlank: 'The view is ___.',                sentenceAnswer: 'beautiful', emoji: '🌅'),
VocabItem(word: 'ugly',     translation: 'feo',           sentenceWithBlank: 'The monster looks ___.',          sentenceAnswer: 'ugly',     emoji: '👹'),
VocabItem(word: 'important',translation: 'importante',    sentenceWithBlank: 'This is an ___ meeting.',         sentenceAnswer: 'important', emoji: '⭐'),
VocabItem(word: 'cheap',    translation: 'barato',        sentenceWithBlank: 'This shirt is very ___.',         sentenceAnswer: 'cheap',    emoji: '💲'),
VocabItem(word: 'expensive',translation: 'caro',          sentenceWithBlank: 'The laptop is ___.',             sentenceAnswer: 'expensive', emoji: '💸'),
VocabItem(word: 'right',    translation: 'correcto',      sentenceWithBlank: 'Your answer is ___.',             sentenceAnswer: 'right',    emoji: '✔️'),
VocabItem(word: 'wrong',    translation: 'incorrecto',    sentenceWithBlank: 'That is ___.',                    sentenceAnswer: 'wrong',    emoji: '❌'),
VocabItem(word: 'different',translation: 'diferente',     sentenceWithBlank: 'These two phones are ___.',       sentenceAnswer: 'different', emoji: '🔀'),

    ],
  ),
  Level(
    title: 'LEVEL 4 — Pronouns & Determiners',
    description: 'Tap to study this level',
    number: 4,
    accentColor: 0xFFFF8F00,
    imageUrl: 'asset:assets/images/levels/level4.png',
    version: 9,
    theory: '''
# Nivel 4: Los Pronombres & Determinantes

Los pronombres y determinantes son las palabras que usamos para referirnos a personas o cosas sin tener que repetir sus nombres todo el tiempo. Son las herramientas que le dan agilidad a tu inglés.

En este nivel aprenderás a identificar quién hace la acción, quién la recibe y a quién le pertenecen las cosas:

### Grupos de Control:
Sujetos (Los Protagonistas): I, You, He, She, It, We, They. Son los que realizan la acción en la frase.
Objetos (Los Receptores): Me, Him, Her, Us, Them. Son los que reciben la acción (ej. "Help me").
Posesivos (¿De quién es?): My, Your, His, Her, Our, Their. Indican pertenencia.
Demostrativos (Señalar): This, That, These, Those. Para indicar si algo está cerca o lejos, en singular o plural.
Cuantificadores: Some, Any, All. Para hablar de cantidades de forma general.

### 💡 Tip de "Level Up":
No confundas He (Él - Sujeto) con His (Su - Posesivo de él). 
Correcto: He is my friend.
Correcto: That is his car.

Misión: Al dominar estas palabras, podrás sustituir cualquier nombre en una oración y señalar objetos como un experto. ¡A darle!
''',
    items: const [
      VocabItem(
        word: 'I',
        translation: 'yo',
        sentenceWithBlank: '___ am very happy today.',
        sentenceAnswer: 'I',
        emoji: '😊',
        sentenceTranslationWithBlank: '___ estoy muy feliz hoy.',
      ),
      VocabItem(
        word: 'you',
        translation: 'tú/usted',
        sentenceWithBlank: '___ are my friend.',
        sentenceAnswer: 'you',
        emoji: '👉',
        sentenceTranslationWithBlank: '___ eres mi amigo.',
      ),
      VocabItem(
        word: 'he',
        translation: 'él',
        sentenceWithBlank: '___ is my brother.',
        sentenceAnswer: 'he',
        emoji: '👦',
        sentenceTranslationWithBlank: '___ es mi hermano.',
      ),
      VocabItem(
        word: 'she',
        translation: 'ella',
        sentenceWithBlank: '___ is very kind.',
        sentenceAnswer: 'she',
        emoji: '👧',
        sentenceTranslationWithBlank: '___ es muy amable.',
      ),
      VocabItem(
        word: 'it',
        translation: 'eso/ello',
        sentenceWithBlank: '___ is a beautiful day.',
        sentenceAnswer: 'it',
        emoji: '☀️',
        sentenceTranslationWithBlank: '___ es un día hermoso.',
      ),
      VocabItem(
        word: 'we',
        translation: 'nosotros',
        sentenceWithBlank: '___ live in the same city.',
        sentenceAnswer: 'we',
        emoji: '👨‍👩‍👧‍👦',
        sentenceTranslationWithBlank: '___ vivimos en la misma ciudad.',
      ),
      VocabItem(
        word: 'they',
        translation: 'ellos/ellas',
        sentenceWithBlank: '___ are at school.',
        sentenceAnswer: 'they',
        emoji: '👥',
        sentenceTranslationWithBlank: '___ están en la escuela.',
      ),

      VocabItem(
        word: 'me',
        translation: 'me/a mí',
        sentenceWithBlank: 'Can you help ___?',
        sentenceAnswer: 'me',
        emoji: '🙋',
        sentenceTranslationWithBlank: '¿Puedes ayudar ___?',
      ),
      VocabItem(
        word: 'him',
        translation: 'a él',
        sentenceWithBlank: 'I called ___.',
        sentenceAnswer: 'him',
        emoji: '👱‍♂️',
        sentenceTranslationWithBlank: 'Llamé ___.',
      ),
      VocabItem(
        word: 'her',
        translation: 'a ella',
        sentenceWithBlank: 'I saw ___ at the store.',
        sentenceAnswer: 'her',
        emoji: '👱‍♀️',
        sentenceTranslationWithBlank: 'Vi ___ en la tienda.',
      ),
      VocabItem(
        word: 'us',
        translation: 'nosotros',
        sentenceWithBlank: 'They invited ___.',
        sentenceAnswer: 'us',
        emoji: '👫',
        sentenceTranslationWithBlank: 'Ellos invitaron ___.',
      ),
      VocabItem(
        word: 'them',
        translation: 'ellos/ellas',
        sentenceWithBlank: 'I know ___.',
        sentenceAnswer: 'them',
        emoji: '🧍‍♂️🧍‍♀️',
        sentenceTranslationWithBlank: 'Conozco ___.',
      ),

      VocabItem(
        word: 'my',
        translation: 'mi',
        sentenceWithBlank: 'This is ___ bag.',
        sentenceAnswer: 'my',
        emoji: '👜',
        sentenceTranslationWithBlank: 'Este es ___ bolso.',
      ),
      VocabItem(
        word: 'your',
        translation: 'tu/su',
        sentenceWithBlank: 'Is this ___ phone?',
        sentenceAnswer: 'your',
        emoji: '📱',
        sentenceTranslationWithBlank: '¿Es este ___ teléfono?',
      ),
      VocabItem(
        word: 'his',
        translation: 'su (de él)',
        sentenceWithBlank: 'That is ___ car.',
        sentenceAnswer: 'his',
        emoji: '🚗',
        sentenceTranslationWithBlank: 'Ese es ___ coche.',
      ),
      VocabItem(
        word: 'her',
        translation: 'su (de ella)',
        sentenceWithBlank: 'I like ___ idea.',
        sentenceAnswer: 'her',
        emoji: '💡',
        sentenceTranslationWithBlank: 'Me gusta ___ idea.',
      ),
      VocabItem(
        word: 'our',
        translation: 'nuestro',
        sentenceWithBlank: 'This is ___ home.',
        sentenceAnswer: 'our',
        emoji: '🏡',
        sentenceTranslationWithBlank: 'Esta es ___ casa.',
      ),
      VocabItem(
        word: 'their',
        translation: 'su (de ellos)',
        sentenceWithBlank: 'That is ___ dog.',
        sentenceAnswer: 'their',
        emoji: '🐶',
        sentenceTranslationWithBlank: 'Ese es ___ perro.',
      ),

      VocabItem(
        word: 'this',
        translation: 'este/esta',
        sentenceWithBlank: '___ is my friend.',
        sentenceAnswer: 'this',
        emoji: '👉',
        sentenceTranslationWithBlank: '___ es mi amigo.',
      ),
      VocabItem(
        word: 'that',
        translation: 'ese/esa',
        sentenceWithBlank: '___ is my house.',
        sentenceAnswer: 'that',
        emoji: '☝️',
        sentenceTranslationWithBlank: '___ es mi casa.',
      ),
      VocabItem(
        word: 'these',
        translation: 'estos/estas',
        sentenceWithBlank: '___ are my shoes.',
        sentenceAnswer: 'these',
        emoji: '👟',
        sentenceTranslationWithBlank: '___ son mis zapatos.',
      ),
      VocabItem(
        word: 'those',
        translation: 'esos/esas',
        sentenceWithBlank: '___ are my books.',
        sentenceAnswer: 'those',
        emoji: '📚',
        sentenceTranslationWithBlank: '___ son mis libros.',
      ),

      VocabItem(
        word: 'some',
        translation: 'algunos',
        sentenceWithBlank: 'I need ___ help.',
        sentenceAnswer: 'some',
        emoji: '🆗',
        sentenceTranslationWithBlank: 'Necesito ___ ayuda.',
      ),
      VocabItem(
        word: 'any',
        translation: 'alguno/ninguno',
        sentenceWithBlank: 'Do you have ___ questions?',
        sentenceAnswer: 'any',
        emoji: '❔',
        sentenceTranslationWithBlank: '¿Tienes ___ preguntas?',
      ),
      VocabItem(
        word: 'all',
        translation: 'todos',
        sentenceWithBlank: '___ of them are here.',
        sentenceAnswer: 'all',
        emoji: '🌍',
        sentenceTranslationWithBlank: '___ de ellos están aquí.',
      ),
    ],
  ),

  Level(
    title: 'LEVEL 5 — Prepositions',
    description: 'Tap to study this level',
    number: 5,
    accentColor: 0xFF9C27B0,
    imageUrl: 'asset:assets/images/levels/level5.png',
    version: 10,
    theory: '''
# Nivel 5: Preposiciones

Las preposiciones son palabras que conectan los elementos de una oración. Su función principal es indicarte dónde está algo, hacia dónde se dirige o cuándo sucede una acción.

En este nivel aprenderás a situar objetos y moverte por el mapa del inglés:

### ¿Dónde están las cosas? (Lugar):
Básicos: In (dentro), On (sobre), Under (debajo).
Posición: Next to (al lado), Between (entre), Behind (detrás), In front of (en frente).

### ¿Hacia dónde vamos? (Movimiento):
Dirección: To (hacia), Into (entrar en), Out of (fuera de), Through (a través de).
Sentido: Up (arriba), Down (abajo), Around (alrededor).

### Conexión y Tiempo:
Relación: With (con), Without (sin), For (para), About (sobre/acerca de).
Secuencia: Before (antes) y After (después).

### 💡 Tip de "Level Up":
La preposición "At" se usa para lugares específicos (ej. at home, at school), mientras que "In" se usa para espacios cerrados o áreas grandes (ej. in the box, in London).

Misión: Usa estas palabras para darle dirección y orden a tus frases. ¡Estás a un paso de dominar la estructura básica!
''',
    items: const [
 VocabItem(word: 'in',        translation: 'en/dentro de',     sentenceWithBlank: 'The keys are ___ the box.',                sentenceAnswer: 'in',        emoji: '📦'),
VocabItem(word: 'on',        translation: 'sobre/encima de',  sentenceWithBlank: 'The book is ___ the table.',              sentenceAnswer: 'on',        emoji: '📚'),
VocabItem(word: 'under',     translation: 'debajo de',        sentenceWithBlank: 'The cat is ___ the bed.',                 sentenceAnswer: 'under',     emoji: '🐱'),
VocabItem(word: 'next to',   translation: 'al lado de',       sentenceWithBlank: 'The lamp is ___ the sofa.',               sentenceAnswer: 'next to',   emoji: '🛋️'),
VocabItem(word: 'between',   translation: 'entre',            sentenceWithBlank: 'The store is ___ the bank and the park.', sentenceAnswer: 'between',   emoji: '↔️'),

VocabItem(word: 'with',      translation: 'con',              sentenceWithBlank: 'I go to school ___ my brother.',          sentenceAnswer: 'with',      emoji: '👫'),
VocabItem(word: 'without',   translation: 'sin',              sentenceWithBlank: 'I can’t live ___ my phone.',              sentenceAnswer: 'without',   emoji: '🚫'),
VocabItem(word: 'to',        translation: 'a/hacia',          sentenceWithBlank: 'We walk ___ the bus stop.',              sentenceAnswer: 'to',        emoji: '➡️'),
VocabItem(word: 'from',      translation: 'de/desde',         sentenceWithBlank: 'She is ___ Spain.',                       sentenceAnswer: 'from',      emoji: '🌍'),
VocabItem(word: 'for',       translation: 'para/por',         sentenceWithBlank: 'This gift is ___ you.',                   sentenceAnswer: 'for',       emoji: '🎁'),

VocabItem(word: 'into',      translation: 'dentro de',        sentenceWithBlank: 'She walks ___ the room.',                 sentenceAnswer: 'into',      emoji: '🚪'),
VocabItem(word: 'out of',    translation: 'fuera de',         sentenceWithBlank: 'He is ___ the office.',                   sentenceAnswer: 'out of',    emoji: '🏢'),
VocabItem(word: 'over',      translation: 'sobre',            sentenceWithBlank: 'The plane flies ___ the city.',           sentenceAnswer: 'over',      emoji: '✈️'),
VocabItem(word: 'behind',    translation: 'detrás de',        sentenceWithBlank: 'The dog is ___ the door.',               sentenceAnswer: 'behind',    emoji: '🚪🦮'),
VocabItem(word: 'in front of', translation: 'en frente de',   sentenceWithBlank: 'The car is ___ the house.',              sentenceAnswer: 'in front of', emoji: '🏠🚗'),

VocabItem(word: 'up',        translation: 'arriba',           sentenceWithBlank: 'Look ___ at the sky.',                    sentenceAnswer: 'up',        emoji: '⬆️'),
VocabItem(word: 'down',      translation: 'abajo',            sentenceWithBlank: 'He looks ___ at his phone.',             sentenceAnswer: 'down',      emoji: '⬇️'),
VocabItem(word: 'around',    translation: 'alrededor de',     sentenceWithBlank: 'We walk ___ the park.',                  sentenceAnswer: 'around',    emoji: '🔄'),
VocabItem(word: 'through',   translation: 'a través de',      sentenceWithBlank: 'The river runs ___ the town.',           sentenceAnswer: 'through',   emoji: '🌊'),

VocabItem(word: 'about',     translation: 'sobre/acerca de',  sentenceWithBlank: 'We talk ___ the project.',               sentenceAnswer: 'about',     emoji: '💬'),
VocabItem(word: 'at',        translation: 'en/a',             sentenceWithBlank: 'I am ___ home now.',                     sentenceAnswer: 'at',        emoji: '📍'),
VocabItem(word: 'by',        translation: 'por/cerca de',     sentenceWithBlank: 'The school is ___ the park.',           sentenceAnswer: 'by',        emoji: '📏'),
VocabItem(word: 'off',       translation: 'fuera/apagado',    sentenceWithBlank: 'Turn ___ the lights.',                   sentenceAnswer: 'off',       emoji: '💡❌'),
VocabItem(word: 'before',    translation: 'antes de',         sentenceWithBlank: 'Do your homework ___ dinner.',          sentenceAnswer: 'before',    emoji: '⏳'),
VocabItem(word: 'after',     translation: 'después de',       sentenceWithBlank: 'We eat ___ the game.',                  sentenceAnswer: 'after',     emoji: '🍽️'),
    ],
  ),

  // Placeholder levels 6–15 (titles and items are placeholders; feel free to edit)
  Level(
    title: 'LEVEL 6 — Food & Drinks',
    description: 'Tap to study this level',
    number: 6,
    accentColor: 0xFF9E9D24,
    imageUrl: 'asset:assets/images/levels/level6.png',
    version: 9,
    theory: '''
# Nivel 6: Comida y Bebida

¡Es hora de alimentar tu vocabulario! Saber hablar de comida no solo es útil para sobrevivir, sino que es la clave para socializar y disfrutar en cualquier país de habla inglesa.

En este nivel aprenderás los ingredientes básicos y todo lo necesario para desenvolverte en un restaurante:

### Categorías de Alimentos:
Lo Básico: Bread (pan), Rice (arroz), Eggs (huevos), Pasta.
Proteínas: Chicken (pollo), Meat (carne), Fish (pescado).
Frutas y Verduras: Apple, Banana, Vegetables, Salad.
Bebidas: Water, Coffee, Milk, Juice, Wine.

### En el Restaurante (Experiencia):
El Servicio: Menu, Waiter (mesero), Table (mesa).
Utensilios: Fork (tenedor), Spoon (cuchara), Knife (cuchillo), Plate (plato).
El Final: Bill (la cuenta).

### 💡 Tip de "Level Up":
Cuando estés en un restaurante y quieras pedir algo educadamente, usa la frase: "I would like..." (Me gustaría...).
Ejemplo: "I would like a cup of coffee, please".

Misión: Domina estas palabras y estarás listo para ordenar tu comida favorita sin miedo. ¡Buen provecho!
''',
    items: const [
      VocabItem(word: 'bread', translation: 'pan', sentenceWithBlank: 'I eat ___ every morning.', sentenceAnswer: 'bread', emoji: '🍞'),
      VocabItem(word: 'water', translation: 'agua', sentenceWithBlank: 'She drinks ___ all day.', sentenceAnswer: 'water', emoji: '💧'),
      VocabItem(word: 'milk', translation: 'leche', sentenceWithBlank: 'The baby drinks ___.', sentenceAnswer: 'milk', emoji: '🥛'),
      VocabItem(word: 'fruit', translation: 'fruta', sentenceWithBlank: 'He eats fresh ___ every day.', sentenceAnswer: 'fruit', emoji: '🍎'),
      VocabItem(word: 'chicken', translation: 'pollo', sentenceWithBlank: 'We cook ___ for dinner.', sentenceAnswer: 'chicken', emoji: '🍗'),
      VocabItem(word: 'rice', translation: 'arroz', sentenceWithBlank: 'They eat ___ with vegetables.', sentenceAnswer: 'rice', emoji: '🍚'),
      VocabItem(word: 'meat', translation: 'carne', sentenceWithBlank: 'Do you like ___?', sentenceAnswer: 'meat', emoji: '🥩'),
      VocabItem(word: 'fish', translation: 'pescado', sentenceWithBlank: 'I ordered ___ at the restaurant.', sentenceAnswer: 'fish', emoji: '🐟'),
      VocabItem(word: 'egg', translation: 'huevo', sentenceWithBlank: 'She cooks an ___ every morning.', sentenceAnswer: 'egg', emoji: '🥚'),
      VocabItem(word: 'vegetables', translation: 'verduras', sentenceWithBlank: 'Eat your ___.', sentenceAnswer: 'vegetables', emoji: '🥦'),
      VocabItem(word: 'salad', translation: 'ensalada', sentenceWithBlank: 'He makes a fresh ___.', sentenceAnswer: 'salad', emoji: '🥗'),
      VocabItem(word: 'soup', translation: 'sopa', sentenceWithBlank: 'The ___ is very hot.', sentenceAnswer: 'soup', emoji: '🍲'),
      VocabItem(word: 'cheese', translation: 'queso', sentenceWithBlank: 'I want ___ on my sandwich.', sentenceAnswer: 'cheese', emoji: '🧀'),
      VocabItem(word: 'butter', translation: 'mantequilla', sentenceWithBlank: 'She spreads ___ on her toast.', sentenceAnswer: 'butter', emoji: '🧈'),
      VocabItem(word: 'salt', translation: 'sal', sentenceWithBlank: 'Add some ___ to the food.', sentenceAnswer: 'salt', emoji: '🧂'),
      VocabItem(word: 'sugar', translation: 'azúcar', sentenceWithBlank: 'I don’t put ___ in my tea.', sentenceAnswer: 'sugar', emoji: '🍬'),
      VocabItem(word: 'coffee', translation: 'café', sentenceWithBlank: 'He drinks ___ in the morning.', sentenceAnswer: 'coffee', emoji: '☕'),
      VocabItem(word: 'tea', translation: 'té', sentenceWithBlank: 'Would you like some ___?', sentenceAnswer: 'tea', emoji: '🫖'),
      VocabItem(word: 'juice', translation: 'jugo', sentenceWithBlank: 'She drinks orange ___.', sentenceAnswer: 'juice', emoji: '🧃'),
      VocabItem(word: 'wine', translation: 'vino', sentenceWithBlank: 'They order red ___ for dinner.', sentenceAnswer: 'wine', emoji: '🍷'),
      VocabItem(word: 'beer', translation: 'cerveza', sentenceWithBlank: 'He wants a cold ___.', sentenceAnswer: 'beer', emoji: '🍺'),
      VocabItem(word: 'menu', translation: 'menú', sentenceWithBlank: 'Can I see the ___?', sentenceAnswer: 'menu', emoji: '📋'),
      VocabItem(word: 'restaurant', translation: 'restaurante', sentenceWithBlank: 'We meet at the ___.', sentenceAnswer: 'restaurant', emoji: '🍽️', sentenceTranslationWithBlank: 'Nos encontramos en el ___.'),
      VocabItem(word: 'table', translation: 'mesa', sentenceWithBlank: 'Your ___ is ready.', sentenceAnswer: 'table', emoji: '🪑'),
      VocabItem(word: 'waiter', translation: 'mesero', sentenceWithBlank: 'The ___ brings our food.', sentenceAnswer: 'waiter', emoji: '🧑‍🍳'),
      VocabItem(word: 'bill', translation: 'cuenta', sentenceWithBlank: 'Can we have the ___?', sentenceAnswer: 'bill', emoji: '🧾'),
      VocabItem(word: 'fork', translation: 'tenedor', sentenceWithBlank: 'I need a ___.', sentenceAnswer: 'fork', emoji: '🍴'),
      VocabItem(word: 'spoon', translation: 'cuchara', sentenceWithBlank: 'She uses a ___ for soup.', sentenceAnswer: 'spoon', emoji: '🥄'),
      VocabItem(word: 'knife', translation: 'cuchillo', sentenceWithBlank: 'Be careful with the ___.', sentenceAnswer: 'knife', emoji: '🔪'),
      VocabItem(word: 'plate', translation: 'plato', sentenceWithBlank: 'Put the food on the ___.', sentenceAnswer: 'plate', emoji: '🍽️'),
      VocabItem(word: 'cup', translation: 'taza', sentenceWithBlank: 'He holds a ___ of coffee.', sentenceAnswer: 'cup', emoji: '☕'),
      VocabItem(word: 'bottle', translation: 'botella', sentenceWithBlank: 'There is a ___ of water.', sentenceAnswer: 'bottle', emoji: '🍼'),
      VocabItem(word: 'apple', translation: 'manzana', sentenceWithBlank: 'She eats an ___.', sentenceAnswer: 'apple', emoji: '🍎'),
      VocabItem(word: 'banana', translation: 'banana', sentenceWithBlank: 'Monkeys love ___.', sentenceAnswer: 'banana', emoji: '🍌'),
      VocabItem(word: 'orange', translation: 'naranja', sentenceWithBlank: 'I peel an ___ for lunch.', sentenceAnswer: 'orange', emoji: '🍊'),
      VocabItem(word: 'bread roll', translation: 'bollo/panecillo', sentenceWithBlank: 'He buys a ___ at the bakery.', sentenceAnswer: 'bread roll', emoji: '🥐'),
      VocabItem(word: 'pasta', translation: 'pasta', sentenceWithBlank: 'We cook ___ tonight.', sentenceAnswer: 'pasta', emoji: '🍝'),
      VocabItem(word: 'hamburger', translation: 'hamburguesa', sentenceWithBlank: 'I want a ___.', sentenceAnswer: 'hamburger', emoji: '🍔'),
      VocabItem(word: 'ice cream', translation: 'helado', sentenceWithBlank: 'Kids love ___.', sentenceAnswer: 'ice cream', emoji: '🍨'),
      VocabItem(word: 'snack', translation: 'bocadillo/merienda', sentenceWithBlank: 'She eats a ___ in the afternoon.', sentenceAnswer: 'snack', emoji: '🍪'),
    ],
  ),

  Level(
    title: 'LEVEL 7 — Family & People',
    description: 'Tap to study this level',
    number: 7,
    accentColor: 0xFF00897B,
    imageUrl: 'asset:assets/images/levels/level7.png',
    version: 10,
    theory: '''
# Nivel 7: Familia y Personas

Para hablar de tu vida, necesitas saber cómo llamar a las personas que te rodean. En este nivel, aprenderás a identificar a tu círculo cercano, desde tu familia hasta tus compañeros de trabajo y las profesiones más comunes.

Dominarás los nombres de quienes forman parte de tu día a día:

### El Círculo Familiar:
Núcleo: Mother (madre), Father (padre), Brother/Sister (hermano/a), Son/Daughter (hijo/a).
Familia Extendida: Grandparents (abuelos), Aunt/Uncle (tío/a), Cousin (primo/a).

### Personas y Etapas:
Por edad: Baby (bebé), Child (niño/a), Boy/Girl (chico/a).
Vínculos: Friend (amigo/a), Neighbor (vecino/a), Guest (invitado/a).

### Roles y Profesiones:
Entorno Laboral: Boss (jefe), Coworker (compañero/a), Worker (trabajador).
Servicios Esenciales: Teacher (profesor/a), Doctor, Nurse (enfermero/a), Police officer, Chef.

### 💡 Tip de "Level Up":
¡Cuidado con los plurales irregulares! En inglés, algunas palabras cambian por completo cuando hablas de más de una persona:
Uno solo: Child (niño) / Person (persona).
Varios: Children (niños) / People (gente/personas).

Misión: Aprende estos nombres y estarás listo para presentar a tu familia y describir a cualquier persona en una conversación. ¡A por ello!
''',
    items: const [
      VocabItem(word: 'mother', translation: 'madre', sentenceWithBlank: 'My ___ is very kind.', sentenceAnswer: 'mother', emoji: '👩‍🦳'),
      VocabItem(word: 'father', translation: 'padre', sentenceWithBlank: 'His ___ works at a school.', sentenceAnswer: 'father', emoji: '👨‍🦳'),
      VocabItem(word: 'parents', translation: 'padres', sentenceWithBlank: 'My ___ are at home.', sentenceAnswer: 'parents', emoji: '👨‍👩‍👧'),
      VocabItem(word: 'family', translation: 'familia', sentenceWithBlank: 'I love my ___.', sentenceAnswer: 'family', emoji: '👨‍👩‍👧‍👦'),
      VocabItem(word: 'child', translation: 'niño/niña', sentenceWithBlank: 'The ___ is playing outside.', sentenceAnswer: 'child', emoji: '🧒'),
      VocabItem(word: 'children', translation: 'niños', sentenceWithBlank: 'The ___ are at school.', sentenceAnswer: 'children', emoji: '👧🧒'),
      VocabItem(word: 'man', translation: 'hombre', sentenceWithBlank: 'The ___ is reading a book.', sentenceAnswer: 'man', emoji: '👨'),
      VocabItem(word: 'woman', translation: 'mujer', sentenceWithBlank: 'The ___ is cooking.', sentenceAnswer: 'woman', emoji: '👩'),
      VocabItem(word: 'boy', translation: 'niño', sentenceWithBlank: 'The ___ runs fast.', sentenceAnswer: 'boy', emoji: '👦'),
      VocabItem(word: 'girl', translation: 'niña', sentenceWithBlank: 'The ___ is drawing.', sentenceAnswer: 'girl', emoji: '👧'),
      VocabItem(word: 'baby', translation: 'bebé', sentenceWithBlank: 'The ___ is sleeping.', sentenceAnswer: 'baby', emoji: '👶'),
      VocabItem(word: 'friend', translation: 'amigo/amiga', sentenceWithBlank: 'My ___ is very funny.', sentenceAnswer: 'friend', emoji: '🧑‍🤝‍🧑'),
      VocabItem(word: 'brother', translation: 'hermano', sentenceWithBlank: 'My ___ is older than me.', sentenceAnswer: 'brother', emoji: '👨‍🦱'),
      VocabItem(word: 'sister', translation: 'hermana', sentenceWithBlank: 'Her ___ is very smart.', sentenceAnswer: 'sister', emoji: '👩‍🦰'),
      VocabItem(word: 'son', translation: 'hijo', sentenceWithBlank: 'Their ___ is five years old.', sentenceAnswer: 'son', emoji: '🧒'),
      VocabItem(word: 'daughter', translation: 'hija', sentenceWithBlank: 'Her ___ loves to dance.', sentenceAnswer: 'daughter', emoji: '👧'),
      VocabItem(word: 'grandmother', translation: 'abuela', sentenceWithBlank: 'My ___ makes great cookies.', sentenceAnswer: 'grandmother', emoji: '👵'),
      VocabItem(word: 'grandfather', translation: 'abuelo', sentenceWithBlank: 'His ___ tells stories.', sentenceAnswer: 'grandfather', emoji: '👴'),
      VocabItem(word: 'aunt', translation: 'tía', sentenceWithBlank: 'My ___ lives in Spain.', sentenceAnswer: 'aunt', emoji: '👩‍🦳'),
      VocabItem(word: 'uncle', translation: 'tío', sentenceWithBlank: 'My ___ visits every week.', sentenceAnswer: 'uncle', emoji: '👨‍🦳'),
      VocabItem(word: 'cousin', translation: 'primo/prima', sentenceWithBlank: 'My ___ is very friendly.', sentenceAnswer: 'cousin', emoji: '🧑'),
      VocabItem(word: 'neighbor', translation: 'vecino/vecina', sentenceWithBlank: 'Our ___ is very helpful.', sentenceAnswer: 'neighbor', emoji: '🏡'),
      VocabItem(word: 'teacher', translation: 'profesor/a', sentenceWithBlank: 'The ___ explains the lesson.', sentenceAnswer: 'teacher', emoji: '🧑‍🏫'),
      VocabItem(word: 'student', translation: 'estudiante', sentenceWithBlank: 'The ___ studies hard.', sentenceAnswer: 'student', emoji: '🧑‍🎓'),
      VocabItem(word: 'person', translation: 'persona', sentenceWithBlank: 'That ___ is my friend.', sentenceAnswer: 'person', emoji: '🧍'),
      VocabItem(word: 'people', translation: 'gente', sentenceWithBlank: 'Many ___ are waiting outside.', sentenceAnswer: 'people', emoji: '🧑‍🤝‍🧑'),
      VocabItem(word: 'boss', translation: 'jefe', sentenceWithBlank: 'My ___ is very strict.', sentenceAnswer: 'boss', emoji: '👔'),
      VocabItem(word: 'coworker', translation: 'compañero de trabajo', sentenceWithBlank: 'My ___ helps me a lot.', sentenceAnswer: 'coworker', emoji: '💼'),
      VocabItem(word: 'doctor', translation: 'doctor/a', sentenceWithBlank: 'The ___ is with a patient.', sentenceAnswer: 'doctor', emoji: '🩺'),
      VocabItem(word: 'nurse', translation: 'enfermero/a', sentenceWithBlank: 'The ___ takes care of people.', sentenceAnswer: 'nurse', emoji: '👩‍⚕️'),
      VocabItem(word: 'police officer', translation: 'policía', sentenceWithBlank: 'The ___ helps the community.', sentenceAnswer: 'police officer', emoji: '👮'),
      VocabItem(word: 'worker', translation: 'trabajador', sentenceWithBlank: 'The ___ is very busy.', sentenceAnswer: 'worker', emoji: '🧑‍🔧'),
      VocabItem(word: 'chef', translation: 'chef/cocinero', sentenceWithBlank: 'The ___ cooks delicious food.', sentenceAnswer: 'chef', emoji: '👨‍🍳'),
      VocabItem(word: 'driver', translation: 'conductor', sentenceWithBlank: 'The ___ drives the bus.', sentenceAnswer: 'driver', emoji: '🚌'),
      VocabItem(word: 'guest', translation: 'invitado', sentenceWithBlank: 'The ___ arrived early.', sentenceAnswer: 'guest', emoji: '🎉'),
    ],
  ),

  Level(
    title: 'LEVEL 8 — Daily Routines',
    description: 'Tap to study this level',
    number: 8,
    accentColor: 0xFFD81B60,
    imageUrl: 'asset:assets/images/levels/level8.png',
    version: 9,
    theory: '''
# Nivel 8: Rutinas Diarias

¡Es hora de ponerle ritmo a tu inglés! En este nivel aprenderás a describir todo lo que haces desde que suena la alarma hasta que cierras los ojos por la noche. 

Dominar las rutinas es la clave para tener conversaciones fluidas sobre tu vida diaria:

### La Mañana (Empezando el día):
El inicio: Wake up (despertarse), Get up (levantarse), Get dressed (vestirse).
Higiene y Energía: Brush teeth (cepillarse), Take a shower (ducharse), Have breakfast (desayunar).

### El Bloque Central (Trabajo y Estudio):
Desplazamiento: Go to work/school, Take the bus, Drive to work.
Productividad: Start work, Take a break (descanso), Finish work.

### La Tarde y el Hogar (Tareas y Relax):
Labores: Cook dinner, Do homework, Clean the house, Wash dishes.
Tiempo libre: Watch TV, Listen to music, Exercise o Work out.

### El Final del Día:
Cierre: Go to bed (ir a la cama), Fall asleep (quedarse dormido).

### 💡 Tip de "Level Up":
Muchas de estas expresiones son Phrasal Verbs (verbos con una partícula extra). 
No digas solo "wake", di "wake up".
No digas solo "get", di "get up".
Esa pequeña palabra extra cambia o completa el significado. ¡Préstales mucha atención en los ejercicios!

Misión: Al terminar este nivel, podrás contarle a cualquier persona cómo es un día normal en tu vida. ¡A darle con todo!
''',
    items: const [
     VocabItem(word: 'wake up', translation: 'despertarse', sentenceWithBlank: 'I ___ at 6 AM every day.', sentenceAnswer: 'wake up', emoji: '⏰'),
     VocabItem(word: 'get up', translation: 'levantarse', sentenceWithBlank: 'She ___ quickly after her alarm rings.', sentenceAnswer: 'get up', emoji: '🛏️'),
VocabItem(word: 'brush teeth', translation: 'cepillarse los dientes', sentenceWithBlank: 'He always ___ after breakfast.', sentenceAnswer: 'brush teeth', emoji: '🪥'),
VocabItem(word: 'take a shower', translation: 'ducharse', sentenceWithBlank: 'I ___ before going to work.', sentenceAnswer: 'take a shower', emoji: '🚿'),
VocabItem(word: 'get dressed', translation: 'vestirse', sentenceWithBlank: 'They ___ quickly in the morning.', sentenceAnswer: 'get dressed', emoji: '👕'),
VocabItem(word: 'have breakfast', translation: 'desayunar', sentenceWithBlank: 'We ___ together every morning.', sentenceAnswer: 'have breakfast', emoji: '🥣'),
VocabItem(word: 'go to work', translation: 'ir al trabajo', sentenceWithBlank: 'My father ___ at 7 AM.', sentenceAnswer: 'go to work', emoji: '🏢'),
VocabItem(word: 'go to school', translation: 'ir a la escuela', sentenceWithBlank: 'The children ___ early.', sentenceAnswer: 'go to school', emoji: '🎒'),
VocabItem(word: 'start work', translation: 'empezar a trabajar', sentenceWithBlank: 'I ___ at 8 AM.', sentenceAnswer: 'start work', emoji: '💼'),
VocabItem(word: 'finish work', translation: 'terminar de trabajar', sentenceWithBlank: 'She ___ at 5 PM.', sentenceAnswer: 'finish work', emoji: '🕔'),
VocabItem(word: 'have lunch', translation: 'almorzar', sentenceWithBlank: 'We usually ___ at noon.', sentenceAnswer: 'have lunch', emoji: '🍽️'),
VocabItem(word: 'take a break', translation: 'tomar un descanso', sentenceWithBlank: 'I ___ at 10 AM.', sentenceAnswer: 'take a break', emoji: '☕'),
VocabItem(word: 'go home', translation: 'ir a casa', sentenceWithBlank: 'They ___ after work.', sentenceAnswer: 'go home', emoji: '🏠'),
VocabItem(word: 'cook dinner', translation: 'cocinar la cena', sentenceWithBlank: 'My mom ___ every night.', sentenceAnswer: 'cook dinner', emoji: '🍲'),
VocabItem(word: 'have dinner', translation: 'cenar', sentenceWithBlank: 'We ___ together at 7 PM.', sentenceAnswer: 'have dinner', emoji: '🍛'),
VocabItem(word: 'do homework', translation: 'hacer la tarea', sentenceWithBlank: 'The kids ___ after school.', sentenceAnswer: 'do homework', emoji: '📚'),
VocabItem(word: 'clean the house', translation: 'limpiar la casa', sentenceWithBlank: 'She ___ on weekends.', sentenceAnswer: 'clean the house', emoji: '🧹'),
VocabItem(word: 'wash dishes', translation: 'lavar los platos', sentenceWithBlank: 'I ___ after dinner.', sentenceAnswer: 'wash dishes', emoji: '🍽️'),
VocabItem(word: 'do laundry', translation: 'lavar la ropa', sentenceWithBlank: 'They ___ every Saturday.', sentenceAnswer: 'do laundry', emoji: '🧺'),
VocabItem(word: 'hang clothes', translation: 'tender la ropa', sentenceWithBlank: 'She ___ outside to dry.', sentenceAnswer: 'hang clothes', emoji: '👕'),
VocabItem(word: 'fold clothes', translation: 'doblar la ropa', sentenceWithBlank: 'I ___ after washing.', sentenceAnswer: 'fold clothes', emoji: '🧼'),
VocabItem(word: 'go shopping', translation: 'ir de compras', sentenceWithBlank: 'We ___ every weekend.', sentenceAnswer: 'go shopping', emoji: '🛒'),
VocabItem(word: 'exercise', translation: 'hacer ejercicio', sentenceWithBlank: 'He ___ in the mornings.', sentenceAnswer: 'exercise', emoji: '🏃‍♂️'),
VocabItem(word: 'take a nap', translation: 'tomar una siesta', sentenceWithBlank: 'I sometimes ___ in the afternoon.', sentenceAnswer: 'take a nap', emoji: '😴'),
VocabItem(word: 'relax', translation: 'relajarse', sentenceWithBlank: 'She likes to ___ after work.', sentenceAnswer: 'relax', emoji: '🛋️'),
VocabItem(word: 'watch TV', translation: 'ver televisión', sentenceWithBlank: 'They ___ every night.', sentenceAnswer: 'watch TV', emoji: '📺'),
VocabItem(word: 'listen to music', translation: 'escuchar música', sentenceWithBlank: 'I ___ in the evening.', sentenceAnswer: 'listen to music', emoji: '🎧'),
VocabItem(word: 'read a book', translation: 'leer un libro', sentenceWithBlank: 'He ___ before bed.', sentenceAnswer: 'read a book', emoji: '📖'),
VocabItem(word: 'check phone', translation: 'revisar el teléfono', sentenceWithBlank: 'She always ___ in the morning.', sentenceAnswer: 'check phone', emoji: '📱'),
VocabItem(word: 'study', translation: 'estudiar', sentenceWithBlank: 'I ___ English at night.', sentenceAnswer: 'study', emoji: '📘'),
VocabItem(word: 'work out', translation: 'entrenar', sentenceWithBlank: 'He ___ at the gym.', sentenceAnswer: 'work out', emoji: '🏋️'),
VocabItem(word: 'go for a walk', translation: 'salir a caminar', sentenceWithBlank: 'We ___ in the park.', sentenceAnswer: 'go for a walk', emoji: '🚶'),
VocabItem(word: 'feed pets', translation: 'alimentar a las mascotas', sentenceWithBlank: 'She ___ every morning.', sentenceAnswer: 'feed pets', emoji: '🐶'),
VocabItem(word: 'water plants', translation: 'regar las plantas', sentenceWithBlank: 'He ___ once a week.', sentenceAnswer: 'water plants', emoji: '🪴'),
VocabItem(word: 'go to bed', translation: 'irse a la cama', sentenceWithBlank: 'I ___ at 10 PM.', sentenceAnswer: 'go to bed', emoji: '🛌'),
VocabItem(word: 'fall asleep', translation: 'quedarse dormido', sentenceWithBlank: 'She ___ quickly every night.', sentenceAnswer: 'fall asleep', emoji: '💤'),
VocabItem(word: 'wake up late', translation: 'despertarse tarde', sentenceWithBlank: 'I sometimes ___ on Sundays.', sentenceAnswer: 'wake up late', emoji: '😪'),
VocabItem(word: 'take the bus', translation: 'tomar el autobús', sentenceWithBlank: 'He ___ to work every day.', sentenceAnswer: 'take the bus', emoji: '🚌'),
VocabItem(word: 'drive to work', translation: 'manejar al trabajo', sentenceWithBlank: 'She ___ every morning.', sentenceAnswer: 'drive to work', emoji: '🚗'),
VocabItem(word: 'walk to school', translation: 'caminar a la escuela', sentenceWithBlank: 'The kids ___ every day.', sentenceAnswer: 'walk to school', emoji: '🚶‍♀️'),

    ],
  ),

  Level(
    title: 'LEVEL 9 — Time & Calendar Words',
    description: 'Tap to study this level',
    number: 9,
    accentColor: 0xFF3949AB,
    imageUrl: 'asset:assets/images/levels/level9.png',
    version: 9,
    theory: '''
# Nivel 9: Tiempo y Calendario

El tiempo es la base de toda comunicación. En este nivel, aprenderás a organizar tu vida en inglés, desde los minutos que pasan hasta los años que vendrán. Estas palabras son los "marcadores" que le dicen a los demás cuándo sucede algo.

Domina el reloj y el calendario con estas categorías:

### Referencias Relativas (¿Cuándo?):
Los básicos: Today (hoy), Tomorrow (mañana), Yesterday (ayer).
Momento exacto: Now (ahora), Soon (pronto), Later (más tarde).
Puntualidad: Early (temprano) y Late (tarde).

### Unidades de Medida:
Corto plazo: Minute, Hour.
Largo plazo: Week (semana), Month (mes), Year (año).
Tipos de día: Weekday (día laboral) y Weekend (fin de semana).

### Partes del Día:
Morning (mañana), Noon (mediodía), Afternoon (tarde), Evening (tarde/noche), Night (noche) y Midnight (medianoche).

### Organización:
Calendar, Date (fecha), Schedule (horario) y las frecuencias: Daily, Monthly, Yearly.

### 💡 Tip de "Level Up":
En inglés, para decir la hora usamos "At" (ej. At noon, At 5 PM). Pero para las partes del día usamos "In the" (ej. In the morning). 
¡Excepción importante! Nunca digas "in the night", lo correcto es decir "At night".

Misión: Al dominar este nivel, dejarás de hablar en presente eterno y empezarás a dominar el tiempo. ¡No llegues tarde a este nivel!
''',
    items: const [
      VocabItem(word: 'today', translation: 'hoy', sentenceWithBlank: 'I have a meeting ___ afternoon.', sentenceAnswer: 'today', emoji: '📆'),
VocabItem(word: 'tomorrow', translation: 'mañana', sentenceWithBlank: 'We will travel ___ morning.', sentenceAnswer: 'tomorrow', emoji: '🗓️'),
VocabItem(word: 'yesterday', translation: 'ayer', sentenceWithBlank: 'She visited her grandma ___.', sentenceAnswer: 'yesterday', emoji: '⏳'),
VocabItem(word: 'now', translation: 'ahora', sentenceWithBlank: 'I am busy ___.', sentenceAnswer: 'now', emoji: '⏰'),
VocabItem(word: 'later', translation: 'más tarde', sentenceWithBlank: 'I will call you ___.', sentenceAnswer: 'later', emoji: '➡️'),
VocabItem(word: 'soon', translation: 'pronto', sentenceWithBlank: 'The bus will arrive ___.', sentenceAnswer: 'soon', emoji: '⌛'),
VocabItem(word: 'early', translation: 'temprano', sentenceWithBlank: 'He wakes up ___.', sentenceAnswer: 'early', emoji: '🌅'),
VocabItem(word: 'late', translation: 'tarde', sentenceWithBlank: 'She arrived ___.', sentenceAnswer: 'late', emoji: '🌙'),
VocabItem(word: 'hour', translation: 'hora', sentenceWithBlank: 'The class lasts one ___.', sentenceAnswer: 'hour', emoji: '🕐'),
VocabItem(word: 'hours', translation: 'horas', sentenceWithBlank: 'I studied for two ___.', sentenceAnswer: 'hours', emoji: '🕒'),
VocabItem(word: 'minute', translation: 'minuto', sentenceWithBlank: 'Wait a ___.', sentenceAnswer: 'minute', emoji: '🕜'),
VocabItem(word: 'minutes', translation: 'minutos', sentenceWithBlank: 'It takes five ___.', sentenceAnswer: 'minutes', emoji: '⏱️'),
VocabItem(word: 'week', translation: 'semana', sentenceWithBlank: 'I go to the gym every ___.', sentenceAnswer: 'week', emoji: '📅'),
VocabItem(word: 'weeks', translation: 'semanas', sentenceWithBlank: 'The course lasts three ___.', sentenceAnswer: 'weeks', emoji: '🗓️'),
VocabItem(word: 'month', translation: 'mes', sentenceWithBlank: 'My birthday is next ___.', sentenceAnswer: 'month', emoji: '🎉'),
VocabItem(word: 'months', translation: 'meses', sentenceWithBlank: 'I lived there for six ___.', sentenceAnswer: 'months', emoji: '📆'),
VocabItem(word: 'year', translation: 'año', sentenceWithBlank: 'This ___ is very important.', sentenceAnswer: 'year', emoji: '🎇'),
VocabItem(word: 'years', translation: 'años', sentenceWithBlank: 'They worked there for ten ___.', sentenceAnswer: 'years', emoji: '🗓️'),
VocabItem(word: 'weekend', translation: 'fin de semana', sentenceWithBlank: 'We relax on the ___.', sentenceAnswer: 'weekend', emoji: '🛌'),
VocabItem(word: 'weekday', translation: 'día laboral', sentenceWithBlank: 'Monday is a ___.', sentenceAnswer: 'weekday', emoji: '📘'),
VocabItem(word: 'morning', translation: 'mañana', sentenceWithBlank: 'I study in the ___.', sentenceAnswer: 'morning', emoji: '🌞'),
VocabItem(word: 'afternoon', translation: 'tarde', sentenceWithBlank: 'We meet in the ___.', sentenceAnswer: 'afternoon', emoji: '🌤️'),
VocabItem(word: 'evening', translation: 'atardecer/noche', sentenceWithBlank: 'He jogs in the ___.', sentenceAnswer: 'evening', emoji: '🌇'),
VocabItem(word: 'night', translation: 'noche', sentenceWithBlank: 'They work at ___.', sentenceAnswer: 'night', emoji: '🌙'),
VocabItem(word: 'midnight', translation: 'medianoche', sentenceWithBlank: 'She slept after ___.', sentenceAnswer: 'midnight', emoji: '🌌'),
VocabItem(word: 'noon', translation: 'mediodía', sentenceWithBlank: 'Lunch is at ___.', sentenceAnswer: 'noon', emoji: '🕛'),
VocabItem(word: 'calendar', translation: 'calendario', sentenceWithBlank: 'I marked the date on my ___.', sentenceAnswer: 'calendar', emoji: '📅'),
VocabItem(word: 'date', translation: 'fecha', sentenceWithBlank: 'What is today’s ___?', sentenceAnswer: 'date', emoji: '📝'),
VocabItem(word: 'time', translation: 'tiempo/hora', sentenceWithBlank: 'What ___ is it?', sentenceAnswer: 'time', emoji: '⏳'),
VocabItem(word: 'schedule', translation: 'horario', sentenceWithBlank: 'My ___ is very busy.', sentenceAnswer: 'schedule', emoji: '📋'),
VocabItem(word: 'daily', translation: 'diario', sentenceWithBlank: 'I read the news ___.', sentenceAnswer: 'daily', emoji: '📰'),
VocabItem(word: 'monthly', translation: 'mensual', sentenceWithBlank: 'I pay this bill ___.', sentenceAnswer: 'monthly', emoji: '💵'),
VocabItem(word: 'yearly', translation: 'anual', sentenceWithBlank: 'We renew the contract ___.', sentenceAnswer: 'yearly', emoji: '📑'),
VocabItem(word: 'before', translation: 'antes', sentenceWithBlank: 'Wash your hands ___ eating.', sentenceAnswer: 'before', emoji: '⬅️'),
VocabItem(word: 'after', translation: 'después', sentenceWithBlank: 'We rest ___ lunch.', sentenceAnswer: 'after', emoji: '➡️'),

    ],
  ),

  Level(
    title: 'LEVEL 10 — Places & Directions',
    description: 'Tap to study this level',
    number: 10,
    accentColor: 0xFF0097A7,
    imageUrl: 'asset:assets/images/levels/level10.png',
    version: 10,
    theory: '''
# Nivel 10: Lugares y Direcciones

¡Has llegado al hito de los 10 niveles! En esta etapa aprenderás a orientarte. Ya sea que estés de viaje o ayudando a un turista, saber dar direcciones y reconocer lugares es una de las habilidades más prácticas que existen.

En este nivel dominaremos el mapa de la ciudad:

### Lugares Importantes:
Vida Diaria: School, Office, Supermarket, Bank, Pharmacy.
Transporte: Airport, Bus station, Train station, Gas station.
Ocio: Park, Beach, Museum, Restaurant, Mall.

### ¿Cómo llego ahí? (Direcciones):
Giros: Left (izquierda), Right (derecha), Straight (recto).
Ubicación: Near (cerca), Far (lejos), Between (entre), Next to (al lado de).

### Elementos de la Calle:
Infraestructura: Street (calle), Bridge (puente), Traffic light (semáforo), Sidewalk (acera).
Navegación: Map, Address (dirección) y Corner (esquina).

### 💡 Tip de "Level Up":
Para preguntar por un lugar educadamente, usa: "Excuse me, where is the...?" (Disculpe, ¿dónde está el...?).
Ejemplo: "Excuse me, where is the bank?".

Misión: Al dominar estos 40 términos, habrás completado el vocabulario esencial para sobrevivir en cualquier ciudad de habla inglesa. ¡Felicidades por llegar hasta aquí!
''',
    items: const [
      VocabItem(word: 'school', translation: 'escuela', sentenceWithBlank: 'The kids walk to ___.', sentenceAnswer: 'school', emoji: '🏫'),
VocabItem(word: 'store', translation: 'tienda', sentenceWithBlank: 'I bought milk at the ___.', sentenceAnswer: 'store', emoji: '🏪'),
VocabItem(word: 'supermarket', translation: 'supermercado', sentenceWithBlank: 'We shop at the ___.', sentenceAnswer: 'supermarket', emoji: '🛒'),
VocabItem(word: 'park', translation: 'parque', sentenceWithBlank: 'They play at the ___.', sentenceAnswer: 'park', emoji: '🌳'),
VocabItem(word: 'hospital', translation: 'hospital', sentenceWithBlank: 'He works at the ___.', sentenceAnswer: 'hospital', emoji: '🏥'),
VocabItem(word: 'office', translation: 'oficina', sentenceWithBlank: 'She goes to her ___ every day.', sentenceAnswer: 'office', emoji: '🏢'),
VocabItem(word: 'bank', translation: 'banco', sentenceWithBlank: 'I need to go to the ___.', sentenceAnswer: 'bank', emoji: '🏦', sentenceTranslationWithBlank: 'Necesito ir al ___.'),
VocabItem(word: 'restaurant', translation: 'restaurante', sentenceWithBlank: 'We ate at a new ___.', sentenceAnswer: 'restaurant', emoji: '🍽️', sentenceTranslationWithBlank: 'Comimos en un ___ nuevo.'),
VocabItem(word: 'hotel', translation: 'hotel', sentenceWithBlank: 'They stayed at a ___.', sentenceAnswer: 'hotel', emoji: '🏨', sentenceTranslationWithBlank: 'Se hospedaron en un ___.'),
VocabItem(word: 'airport', translation: 'aeropuerto', sentenceWithBlank: 'The plane leaves from the ___.', sentenceAnswer: 'airport', emoji: '🛫'),
VocabItem(word: 'bus station', translation: 'terminal de buses', sentenceWithBlank: 'Meet me at the ___.', sentenceAnswer: 'bus station', emoji: '🚉'),
VocabItem(word: 'train station', translation: 'estación de tren', sentenceWithBlank: 'The train arrives at the ___.', sentenceAnswer: 'train station', emoji: '🚆'),
VocabItem(word: 'library', translation: 'biblioteca', sentenceWithBlank: 'I study at the ___.', sentenceAnswer: 'library', emoji: '📚'),
VocabItem(word: 'museum', translation: 'museo', sentenceWithBlank: 'We visited the ___.', sentenceAnswer: 'museum', emoji: '🏛️'),
VocabItem(word: 'beach', translation: 'playa', sentenceWithBlank: 'They swam at the ___.', sentenceAnswer: 'beach', emoji: '🏖️'),
VocabItem(word: 'mall', translation: 'centro comercial', sentenceWithBlank: 'She works at the ___.', sentenceAnswer: 'mall', emoji: '🛍️'),
VocabItem(word: 'pharmacy', translation: 'farmacia', sentenceWithBlank: 'I bought medicine at the ___.', sentenceAnswer: 'pharmacy', emoji: '💊'),
VocabItem(word: 'bakery', translation: 'panadería', sentenceWithBlank: 'I got bread at the ___.', sentenceAnswer: 'bakery', emoji: '🥐'),
VocabItem(word: 'gas station', translation: 'gasolinera', sentenceWithBlank: 'We stopped at the ___.', sentenceAnswer: 'gas station', emoji: '⛽'),
VocabItem(word: 'police station', translation: 'estación de policía', sentenceWithBlank: 'He went to the ___.', sentenceAnswer: 'police station', emoji: '🚓'),

VocabItem(word: 'left', translation: 'izquierda', sentenceWithBlank: 'Turn ___ at the corner.', sentenceAnswer: 'left', emoji: '⬅️'),
VocabItem(word: 'right', translation: 'derecha', sentenceWithBlank: 'Turn ___ after the store.', sentenceAnswer: 'right', emoji: '➡️'),
VocabItem(word: 'straight', translation: 'recto', sentenceWithBlank: 'Go ___ for two blocks.', sentenceAnswer: 'straight', emoji: '⬆️'),
VocabItem(word: 'behind', translation: 'detrás', sentenceWithBlank: 'The school is ___ the park.', sentenceAnswer: 'behind', emoji: '🔙'),
VocabItem(word: 'in front of', translation: 'en frente de', sentenceWithBlank: 'The bus stop is ___ the mall.', sentenceAnswer: 'in front of', emoji: '👁️'),
VocabItem(word: 'next to', translation: 'al lado de', sentenceWithBlank: 'The pharmacy is ___ the bank.', sentenceAnswer: 'next to', emoji: '↔️'),
VocabItem(word: 'between', translation: 'entre', sentenceWithBlank: 'The hotel is ___ two restaurants.', sentenceAnswer: 'between', emoji: '🔀'),
VocabItem(word: 'near', translation: 'cerca', sentenceWithBlank: 'My house is ___ the park.', sentenceAnswer: 'near', emoji: '📍'),
VocabItem(word: 'far', translation: 'lejos', sentenceWithBlank: 'The airport is ___ from here.', sentenceAnswer: 'far', emoji: '🛫'),
VocabItem(word: 'around', translation: 'alrededor de', sentenceWithBlank: 'Walk ___ the block.', sentenceAnswer: 'around', emoji: '🔄'),

VocabItem(word: 'corner', translation: 'esquina', sentenceWithBlank: 'The store is on the ___.', sentenceAnswer: 'corner', emoji: '🧱'),
VocabItem(word: 'street', translation: 'calle', sentenceWithBlank: 'They live on this ___.', sentenceAnswer: 'street', emoji: '🚧'),
VocabItem(word: 'road', translation: 'carretera', sentenceWithBlank: 'This ___ is very busy.', sentenceAnswer: 'road', emoji: '🛣️'),
VocabItem(word: 'bridge', translation: 'puente', sentenceWithBlank: 'Cross the ___.', sentenceAnswer: 'bridge', emoji: '🌉'),
VocabItem(word: 'highway', translation: 'autopista', sentenceWithBlank: 'We drove on the ___.', sentenceAnswer: 'highway', emoji: '🛻'),
VocabItem(word: 'sidewalk', translation: 'acera', sentenceWithBlank: 'Walk on the ___.', sentenceAnswer: 'sidewalk', emoji: '🚶‍♂️'),
VocabItem(word: 'traffic light', translation: 'semáforo', sentenceWithBlank: 'Stop at the ___.', sentenceAnswer: 'traffic light', emoji: '🚦'),
VocabItem(word: 'map', translation: 'mapa', sentenceWithBlank: 'Check the ___ for directions.', sentenceAnswer: 'map', emoji: '🗺️'),
VocabItem(word: 'address', translation: 'dirección', sentenceWithBlank: 'What is your ___?', sentenceAnswer: 'address', emoji: '🏠'),
VocabItem(word: 'downtown', translation: 'centro de la ciudad', sentenceWithBlank: 'We are going ___.', sentenceAnswer: 'downtown', emoji: '🌆'),
],
  ),

  Level(
    title: 'LEVEL 11 — Travel & Transportation',
    description: 'Tap to study this level',
    number: 11,
    accentColor: 0xFF0288D1,
    imageUrl: 'asset:assets/images/levels/level11.png',
    version: 10,
    theory: '''
# Nivel 11: Viajes y Transporte

¡Prepárate para despegar! Ya sea que estés en un aeropuerto, una estación de tren o pidiendo un taxi, estas palabras son tus mejores aliadas para moverte por el mundo sin perderte.

En este nivel aprenderás la logística necesaria para cualquier aventura:

### Medios de Transporte:
Aire y Tierra: Plane (avión), Bus, Train, Subway (metro), Taxi.
Personales: Car, Bike (bicicleta), Motorcycle.
Agua: Boat (bote) y Ship (barco).

### En la Terminal (Aeropuerto o Estación):
Documentos: Passport, ID, Ticket, Visa.
Logística: Luggage (equipaje), Platform (andén), Gate (puerta de embarque).
Procesos: Check-in (registro), Boarding (embarque), Arrival (llegada) y Departure (salida).

### Acciones de Viaje (Verbos):
Travel (viajar), Leave (salir), Arrive (llegar), Return (volver).
Ride: Se usa para vehículos donde te "montas" o vas de pasajero (ej. Ride the bus).

### 💡 Tip de "Level Up":
Cuando hables de transporte, la preposición estrella es "By".
Ejemplo: "I travel by plane" o "I go by bus".
¡Ojo! Si vas caminando, no dices "by foot", dices "On foot".

Misión: Domina estos términos y estarás listo para hacer tu maleta y explorar nuevos destinos. ¡Buen viaje!
''',
    items: const [
      VocabItem(word: 'bus', translation: 'bus', sentenceWithBlank: 'I waited for the ___.', sentenceAnswer: 'bus', emoji: '🚌'),
VocabItem(word: 'train', translation: 'tren', sentenceWithBlank: 'The ___ arrives at 5.', sentenceAnswer: 'train', emoji: '🚆'),
VocabItem(word: 'plane', translation: 'avión', sentenceWithBlank: 'The ___ is taking off.', sentenceAnswer: 'plane', emoji: '✈️'),
VocabItem(word: 'airport', translation: 'aeropuerto', sentenceWithBlank: 'We met at the ___.', sentenceAnswer: 'airport', emoji: '🛫'),
VocabItem(word: 'station', translation: 'estación', sentenceWithBlank: 'Go to the train ___.', sentenceAnswer: 'station', emoji: '🚉'),
VocabItem(word: 'ticket', translation: 'boleto', sentenceWithBlank: 'I bought a ___.', sentenceAnswer: 'ticket', emoji: '🎫'),
VocabItem(word: 'platform', translation: 'andén', sentenceWithBlank: 'The train leaves from the ___.', sentenceAnswer: 'platform', emoji: '🛤️'),
VocabItem(word: 'gate', translation: 'puerta', sentenceWithBlank: 'Boarding is at ___.', sentenceAnswer: 'gate', emoji: '🚪'),
VocabItem(word: 'luggage', translation: 'equipaje', sentenceWithBlank: 'My ___ is heavy.', sentenceAnswer: 'luggage', emoji: '🧳'),
VocabItem(word: 'suitcase', translation: 'maleta', sentenceWithBlank: 'I packed my ___.', sentenceAnswer: 'suitcase', emoji: '🧳'),
VocabItem(word: 'backpack', translation: 'mochila', sentenceWithBlank: 'I carry a ___.', sentenceAnswer: 'backpack', emoji: '🎒'),
VocabItem(word: 'passport', translation: 'pasaporte', sentenceWithBlank: 'Do you have your ___?', sentenceAnswer: 'passport', emoji: '🛂'),
VocabItem(word: 'ID', translation: 'identificación', sentenceWithBlank: 'Show your ___.', sentenceAnswer: 'ID', emoji: '🪪'),
VocabItem(word: 'visa', translation: 'visa', sentenceWithBlank: 'I applied for a ___.', sentenceAnswer: 'visa', emoji: '📄'),
VocabItem(word: 'map', translation: 'mapa', sentenceWithBlank: 'Look at the ___.', sentenceAnswer: 'map', emoji: '🗺️'),
VocabItem(word: 'taxi', translation: 'taxi', sentenceWithBlank: 'We took a ___.', sentenceAnswer: 'taxi', emoji: '🚕'),
VocabItem(word: 'car', translation: 'carro', sentenceWithBlank: 'I rented a ___.', sentenceAnswer: 'car', emoji: '🚗'),
VocabItem(word: 'bike', translation: 'bicicleta', sentenceWithBlank: 'He rides a ___.', sentenceAnswer: 'bike', emoji: '🚲'),
VocabItem(word: 'motorcycle', translation: 'motocicleta', sentenceWithBlank: 'She drives a ___.', sentenceAnswer: 'motorcycle', emoji: '🏍️'),
VocabItem(word: 'boat', translation: 'bote', sentenceWithBlank: 'We got on the ___.', sentenceAnswer: 'boat', emoji: '🛶'),
VocabItem(word: 'ship', translation: 'barco', sentenceWithBlank: 'The ___ left the port.', sentenceAnswer: 'ship', emoji: '🚢'),
VocabItem(word: 'subway', translation: 'metro', sentenceWithBlank: 'We took the ___.', sentenceAnswer: 'subway', emoji: '🚇'),
VocabItem(word: 'tram', translation: 'tranvía', sentenceWithBlank: 'I saw the ___.', sentenceAnswer: 'tram', emoji: '🚊'),
VocabItem(word: 'stop', translation: 'parada', sentenceWithBlank: 'This is my ___.', sentenceAnswer: 'stop', emoji: '🛑'),
VocabItem(word: 'route', translation: 'ruta', sentenceWithBlank: 'This is the best ___.', sentenceAnswer: 'route', emoji: '🗺️'),
VocabItem(word: 'destination', translation: 'destino', sentenceWithBlank: 'What is your ___?', sentenceAnswer: 'destination', emoji: '📍'),
VocabItem(word: 'arrival', translation: 'llegada', sentenceWithBlank: 'Our ___ is delayed.', sentenceAnswer: 'arrival', emoji: '🛬'),
VocabItem(word: 'departure', translation: 'salida', sentenceWithBlank: 'The ___ is at 8 AM.', sentenceAnswer: 'departure', emoji: '🛫'),
VocabItem(word: 'delay', translation: 'retraso', sentenceWithBlank: 'There is a ___.', sentenceAnswer: 'delay', emoji: '⏳'),
VocabItem(word: 'schedule', translation: 'horario', sentenceWithBlank: 'Check the ___.', sentenceAnswer: 'schedule', emoji: '📅'),
VocabItem(word: 'reservation', translation: 'reserva', sentenceWithBlank: 'I made a ___.', sentenceAnswer: 'reservation', emoji: '📘'),
VocabItem(word: 'check-in', translation: 'registro', sentenceWithBlank: 'We completed the ___.', sentenceAnswer: 'check-in', emoji: '📝'),
VocabItem(word: 'boarding', translation: 'embarque', sentenceWithBlank: '___ starts now.', sentenceAnswer: 'boarding', emoji: '🛫'),
VocabItem(word: 'seat', translation: 'asiento', sentenceWithBlank: 'This is my ___.', sentenceAnswer: 'seat', emoji: '💺'),
VocabItem(word: 'window seat', translation: 'asiento de ventana', sentenceWithBlank: 'I prefer the ___.', sentenceAnswer: 'window seat', emoji: '🪟'),
VocabItem(word: 'aisle seat', translation: 'asiento de pasillo', sentenceWithBlank: 'He chose the ___.', sentenceAnswer: 'aisle seat', emoji: '🛤️'),
VocabItem(word: 'driver', translation: 'conductor', sentenceWithBlank: 'The ___ stopped the car.', sentenceAnswer: 'driver', emoji: '🧑‍✈️'),
VocabItem(word: 'passenger', translation: 'pasajero', sentenceWithBlank: 'Every ___ must sit.', sentenceAnswer: 'passenger', emoji: '🧍'),
VocabItem(word: 'travel', translation: 'viajar', sentenceWithBlank: 'I want to ___.', sentenceAnswer: 'travel', emoji: '🌍'),
VocabItem(word: 'ride', translation: 'viajar/montar', sentenceWithBlank: 'Let’s ___ the bus.', sentenceAnswer: 'ride', emoji: '🚌'),
VocabItem(word: 'go', translation: 'ir', sentenceWithBlank: 'We can ___ now.', sentenceAnswer: 'go', emoji: '➡️'),
VocabItem(word: 'return', translation: 'volver', sentenceWithBlank: 'We will __ tomorrow.', sentenceAnswer: 'return', emoji: '↩️'),
VocabItem(word: 'leave', translation: 'salir', sentenceWithBlank: 'We ___ at 6.', sentenceAnswer: 'leave', emoji: '🏃'),
VocabItem(word: 'arrive', translation: 'llegar', sentenceWithBlank: 'We ___ at noon.', sentenceAnswer: 'arrive', emoji: '🕛'),
VocabItem(word: 'transfer', translation: 'transbordo', sentenceWithBlank: 'We need to make a ___.', sentenceAnswer: 'transfer', emoji: '🔁'),
],
  ),

  Level(
    title: 'LEVEL 12 — Irregular Verbs',
    description: 'Tap to study this level',
    number: 12,
    accentColor: 0xFF795548,
    imageUrl: 'asset:assets/images/levels/level12.png',
    version: 10,
    theory: '''
# Nivel 12: Verbos Irregulares (Pasado)

¡Bienvenido al nivel de los rebeldes! En inglés, la mayoría de los verbos en pasado terminan en "-ed", pero los Verbos Irregulares tienen sus propias reglas y cambian de forma caprichosa. 

Como no hay una fórmula mágica, la mejor estrategia es aprender los más comunes, ¡que son justo los que verás aquí!

### Los que cambian por completo:
Go (ir) → Went (fue)
See (ver) → Saw (vio)
Eat (comer) → Ate (comió)
Buy (comprar) → Bought (compró)

### Los que cambian solo una letra:
Run (correr) → Ran (corrió)
Drink (beber) → Drank (bebió)
Know (saber) → Knew (sabía)
Speak (hablar) → Spoke (habló)

### El caso curioso de "Read":
El verbo Read (leer) se escribe igual en presente y en pasado (Read), pero su pronunciación cambia. En pasado se pronuncia como el color rojo: /red/.

### 💡 Tip de "Level Up":
Para memorizarlos, trata de agruparlos por sonido. Por ejemplo, muchos que terminan en "ought" o "aught" suenan parecido: Bought, Brought, Thought, Caught. 

Misión: No intentes aprenderlos todos de golpe. Practica con las oraciones del nivel y verás cómo tu cerebro empieza a reconocer los patrones. ¡Tú puedes!
''',
    items: const [
      VocabItem(word: 'went', translation: 'fue', sentenceWithBlank: 'She ___ to the store yesterday.', sentenceAnswer: 'went', emoji: '🚶‍♂️'),
VocabItem(word: 'saw', translation: 'vio', sentenceWithBlank: 'He ___ a shooting star.', sentenceAnswer: 'saw', emoji: '🌠'),
VocabItem(word: 'took', translation: 'tomó', sentenceWithBlank: 'She ___ a picture of the beach.', sentenceAnswer: 'took', emoji: '📸'),
VocabItem(word: 'made', translation: 'hizo', sentenceWithBlank: 'They ___ a cake for the party.', sentenceAnswer: 'made', emoji: '🎂'),
VocabItem(word: 'said', translation: 'dijo', sentenceWithBlank: 'He ___ hello to everyone.', sentenceAnswer: 'said', emoji: '🗣️'),
VocabItem(word: 'knew', translation: 'sabía', sentenceWithBlank: 'I ___ the answer.', sentenceAnswer: 'knew', emoji: '🧠'),
VocabItem(word: 'found', translation: 'encontró', sentenceWithBlank: 'She ___ her lost keys.', sentenceAnswer: 'found', emoji: '🔑'),
VocabItem(word: 'came', translation: 'vino', sentenceWithBlank: 'They ___ late to the meeting.', sentenceAnswer: 'came', emoji: '🏃‍♂️'),
VocabItem(word: 'gave', translation: 'dio', sentenceWithBlank: 'He ___ her a gift.', sentenceAnswer: 'gave', emoji: '🎁'),
VocabItem(word: 'got', translation: 'obtuvo', sentenceWithBlank: 'She ___ a new job.', sentenceAnswer: 'got', emoji: '💼'),
VocabItem(word: 'left', translation: 'salió', sentenceWithBlank: 'He ___ early this morning.', sentenceAnswer: 'left', emoji: '🏃'),
VocabItem(word: 'felt', translation: 'sintió', sentenceWithBlank: 'She ___ happy today.', sentenceAnswer: 'felt', emoji: '😊'),
VocabItem(word: 'thought', translation: 'pensó', sentenceWithBlank: 'He ___ about the problem.', sentenceAnswer: 'thought', emoji: '💭'),
VocabItem(word: 'kept', translation: 'mantuvo', sentenceWithBlank: 'She ___ her promise.', sentenceAnswer: 'kept', emoji: '🤞'),
VocabItem(word: 'heard', translation: 'escuchó', sentenceWithBlank: 'I ___ a strange noise.', sentenceAnswer: 'heard', emoji: '👂'),
VocabItem(word: 'held', translation: 'sostuvo', sentenceWithBlank: 'He ___ the baby carefully.', sentenceAnswer: 'held', emoji: '👶'),
VocabItem(word: 'bought', translation: 'compró', sentenceWithBlank: 'She ___ a new phone.', sentenceAnswer: 'bought', emoji: '📱'),
VocabItem(word: 'became', translation: 'se volvió', sentenceWithBlank: 'He ___ a teacher.', sentenceAnswer: 'became', emoji: '👨‍🏫'),
VocabItem(word: 'began', translation: 'empezó', sentenceWithBlank: 'The show ___ on time.', sentenceAnswer: 'began', emoji: '🎬'),
VocabItem(word: 'broke', translation: 'rompió', sentenceWithBlank: 'He ___ the glass.', sentenceAnswer: 'broke', emoji: '💥'),
VocabItem(word: 'brought', translation: 'trajo', sentenceWithBlank: 'She ___ snacks to the party.', sentenceAnswer: 'brought', emoji: '🍿'),
VocabItem(word: 'built', translation: 'construyó', sentenceWithBlank: 'They ___ a house.', sentenceAnswer: 'built', emoji: '🏠'),
VocabItem(word: 'caught', translation: 'atrapó', sentenceWithBlank: 'He ___ the ball.', sentenceAnswer: 'caught', emoji: '⚾'),
VocabItem(word: 'drew', translation: 'dibujó', sentenceWithBlank: 'She ___ a picture of a cat.', sentenceAnswer: 'drew', emoji: '🐱'),
VocabItem(word: 'drank', translation: 'bebió', sentenceWithBlank: 'He ___ all the water.', sentenceAnswer: 'drank', emoji: '💧'),
VocabItem(word: 'ate', translation: 'comió', sentenceWithBlank: 'She ___ pizza for lunch.', sentenceAnswer: 'ate', emoji: '🍕'),
VocabItem(word: 'fell', translation: 'cayó', sentenceWithBlank: 'He ___ off the bike.', sentenceAnswer: 'fell', emoji: '🚲'),
VocabItem(word: 'flew', translation: 'voló', sentenceWithBlank: 'The bird ___ away.', sentenceAnswer: 'flew', emoji: '🕊️'),
VocabItem(word: 'forgot', translation: 'olvidó', sentenceWithBlank: 'She ___ her password.', sentenceAnswer: 'forgot', emoji: '🔒'),
VocabItem(word: 'met', translation: 'conoció', sentenceWithBlank: 'He ___ his best friend at school.', sentenceAnswer: 'met', emoji: '🤝'),
VocabItem(word: 'paid', translation: 'pagó', sentenceWithBlank: 'She ___ the bill.', sentenceAnswer: 'paid', emoji: '💳'),
VocabItem(word: 'ran', translation: 'corrió', sentenceWithBlank: 'He ___ very fast.', sentenceAnswer: 'ran', emoji: '🏃‍♂️'),
VocabItem(word: 'read', translation: 'leyó', sentenceWithBlank: 'She ___ the whole book.', sentenceAnswer: 'read', emoji: '📖'),
VocabItem(word: 'rode', translation: 'montó', sentenceWithBlank: 'He ___ his bike to school.', sentenceAnswer: 'rode', emoji: '🚴'),
VocabItem(word: 'sent', translation: 'envió', sentenceWithBlank: 'She ___ a message.', sentenceAnswer: 'sent', emoji: '📩'),
VocabItem(word: 'slept', translation: 'durmió', sentenceWithBlank: 'He ___ for eight hours.', sentenceAnswer: 'slept', emoji: '😴'),
VocabItem(word: 'spoke', translation: 'habló', sentenceWithBlank: 'They ___ for an hour.', sentenceAnswer: 'spoke', emoji: '🗨️'),
VocabItem(word: 'stood', translation: 'se paró', sentenceWithBlank: 'He ___ in line.', sentenceAnswer: 'stood', emoji: '🚶'),
VocabItem(word: 'swam', translation: 'nadó', sentenceWithBlank: 'She ___ in the pool.', sentenceAnswer: 'swam', emoji: '🏊'),
VocabItem(word: 'told', translation: 'contó', sentenceWithBlank: 'He ___ her the truth.', sentenceAnswer: 'told', emoji: '📢'),
VocabItem(word: 'understood', translation: 'entendió', sentenceWithBlank: 'She ___ the lesson.', sentenceAnswer: 'understood', emoji: '📘'),
VocabItem(word: 'wore', translation: 'usó', sentenceWithBlank: 'He ___ a blue jacket.', sentenceAnswer: 'wore', emoji: '🧥'),
VocabItem(word: 'won', translation: 'ganó', sentenceWithBlank: 'She ___ the game.', sentenceAnswer: 'won', emoji: '🏆'),
VocabItem(word: 'wrote', translation: 'escribió', sentenceWithBlank: 'He ___ a letter.', sentenceAnswer: 'wrote', emoji: '✍️'),
],

  ),

  Level(
    title: 'LEVEL 13 — Conversations & Social Phrases',
    description: 'Tap to study this level',
   number: 13,
    accentColor: 0xFF7CB342,
    imageUrl: 'asset:assets/images/levels/level13.png',
    version: 9,
    theory: '''
# Nivel 13: Frases Sociales y Conversación

¡Has llegado al corazón del idioma! Saber gramática es importante, pero saber decir "disculpe", "gracias" o "no entiendo" es lo que realmente te permite comunicarte con personas reales. 

En este nivel aprenderás las llaves maestras de la conversación:

### Cortesía y Buenos Modales:
Lo básico: Please, Thank you, You're welcome (de nada).
Para interrumpir o pedir perdón: Excuse me (disculpe) y Sorry (lo siento).
Confirmaciones: Yes, No, Maybe (tal vez), Of course (por supuesto).

### Saludos y Despedidas:
Dependiendo de la hora: Good morning, Good afternoon, Good evening.
Para irse: Goodbye, See you soon (nos vemos pronto), See you tomorrow.

### Conociendo a alguien:
Preguntas clave: What's your name?, Where are you from?, Nice to meet you.

### Supervivencia (Cuando estás perdido):
I don't understand (no entiendo).
Can you repeat? (¿puedes repetir?).
Can you help me? (¿puedes ayudarme?).

### Estados y Opiniones:
Cómo te sientes: I'm tired (cansado), I'm hungry (hambre), I'm busy (ocupado).
Tu postura: I agree (estoy de acuerdo) o I disagree.

### 💡 Tip de "Level Up":
¿Sabías que hay dos formas de decir "Buenas noches"? 
Usa Good evening cuando llegas a un lugar o saludas a alguien (ej. al entrar a un restaurante).
Usa Good night únicamente para despedirte o cuando ya te vas a dormir.

Misión: Practica estas frases en voz alta. Son las que más usarás en tus viajes y reuniones. ¡A por ello!
''',
    items: const [
     VocabItem(word: 'excuse me', translation: 'disculpe', sentenceWithBlank: '___, where is the bathroom?', sentenceAnswer: 'excuse me', emoji: '🙋'),
VocabItem(word: 'please', translation: 'por favor', sentenceWithBlank: 'Can you help me, ___?', sentenceAnswer: 'please', emoji: '🙏'),
VocabItem(word: 'thank you', translation: 'gracias', sentenceWithBlank: '___ for your help.', sentenceAnswer: 'thank you', emoji: '😊'),
VocabItem(word: 'thanks', translation: 'gracias', sentenceWithBlank: '___ for the ride.', sentenceAnswer: 'thanks', emoji: '👍'),
VocabItem(word: 'you’re welcome', translation: 'de nada', sentenceWithBlank: '—Thank you! —___.', sentenceAnswer: 'you’re welcome', emoji: '🙂'),
VocabItem(word: 'sorry', translation: 'lo siento', sentenceWithBlank: 'I’m ___ for the mistake.', sentenceAnswer: 'sorry', emoji: '😔'),
VocabItem(word: 'no problem', translation: 'no hay problema', sentenceWithBlank: '—Thanks! —___.', sentenceAnswer: 'no problem', emoji: '👌'),
VocabItem(word: 'hello', translation: 'hola', sentenceWithBlank: '___, how are you?', sentenceAnswer: 'hello', emoji: '👋'),
VocabItem(word: 'hi', translation: 'hola', sentenceWithBlank: '___, nice to meet you!', sentenceAnswer: 'hi', emoji: '😊'),
VocabItem(word: 'good morning', translation: 'buenos días', sentenceWithBlank: '___, everyone!', sentenceAnswer: 'good morning', emoji: '🌅'),
VocabItem(word: 'good afternoon', translation: 'buenas tardes', sentenceWithBlank: '___, sir.', sentenceAnswer: 'good afternoon', emoji: '🌞'),
VocabItem(word: 'good evening', translation: 'buenas noches', sentenceWithBlank: '___, welcome.', sentenceAnswer: 'good evening', emoji: '🌆'),
VocabItem(word: 'good night', translation: 'buenas noches', sentenceWithBlank: '___, sleep well.', sentenceAnswer: 'good night', emoji: '🌙'),
VocabItem(word: 'goodbye', translation: 'adiós', sentenceWithBlank: '___, see you tomorrow.', sentenceAnswer: 'goodbye', emoji: '👋'),
VocabItem(word: 'see you', translation: 'nos vemos', sentenceWithBlank: 'Okay, ___ later!', sentenceAnswer: 'see you', emoji: '👀'),
VocabItem(word: 'see you soon', translation: 'nos vemos pronto', sentenceWithBlank: 'Bye! ___!', sentenceAnswer: 'see you soon', emoji: '⏳'),
VocabItem(word: 'see you tomorrow', translation: 'nos vemos mañana', sentenceWithBlank: 'Good night! ___.', sentenceAnswer: 'see you tomorrow', emoji: '📅'),
VocabItem(word: 'how are you?', translation: '¿cómo estás?', sentenceWithBlank: 'Hi! ___.', sentenceAnswer: 'how are you?', emoji: '🙂'),
VocabItem(word: 'I’m fine', translation: 'estoy bien', sentenceWithBlank: '—How are you? —___.', sentenceAnswer: 'I’m fine', emoji: '😄'),
VocabItem(word: 'what’s your name?', translation: '¿cómo te llamas?', sentenceWithBlank: '___?', sentenceAnswer: 'what’s your name?', emoji: '📝'),
VocabItem(word: 'my name is…', translation: 'mi nombre es…', sentenceWithBlank: '___ Miguel.', sentenceAnswer: 'my name is…', emoji: '🙂'),
VocabItem(word: 'nice to meet you', translation: 'mucho gusto', sentenceWithBlank: '___!', sentenceAnswer: 'nice to meet you', emoji: '🤝'),
VocabItem(word: 'where are you from?', translation: '¿de dónde eres?', sentenceWithBlank: '___?', sentenceAnswer: 'where are you from?', emoji: '🌍'),
VocabItem(word: 'I’m from…', translation: 'soy de…', sentenceWithBlank: '___ Panama.', sentenceAnswer: 'I’m from…', emoji: '🇵🇦'),
VocabItem(word: 'how much?', translation: '¿cuánto cuesta?', sentenceWithBlank: '___ is this?', sentenceAnswer: 'how much?', emoji: '💲'),
VocabItem(word: 'can you help me?', translation: '¿puede ayudarme?', sentenceWithBlank: '___, please?', sentenceAnswer: 'can you help me?', emoji: '🙋‍♂️'),
VocabItem(word: 'I don’t understand', translation: 'no entiendo', sentenceWithBlank: 'Sorry, ___.', sentenceAnswer: 'I don’t understand', emoji: '❓'),
VocabItem(word: 'I understand', translation: 'entiendo', sentenceWithBlank: 'Okay, now ___.', sentenceAnswer: 'I understand', emoji: '✔️'),
VocabItem(word: 'can you repeat?', translation: '¿puede repetir?', sentenceWithBlank: '___ that, please?', sentenceAnswer: 'can you repeat?', emoji: '🔁'),
VocabItem(word: 'one moment', translation: 'un momento', sentenceWithBlank: '___, please.', sentenceAnswer: 'one moment', emoji: '⏱️'),
VocabItem(word: 'wait', translation: 'espera', sentenceWithBlank: 'Please ___ here.', sentenceAnswer: 'wait', emoji: '✋'),
VocabItem(word: 'yes', translation: 'sí', sentenceWithBlank: '___, I agree.', sentenceAnswer: 'yes', emoji: '✔️'),
VocabItem(word: 'no', translation: 'no', sentenceWithBlank: '___, thank you.', sentenceAnswer: 'no', emoji: '❌'),
VocabItem(word: 'maybe', translation: 'tal vez', sentenceWithBlank: '___ later.', sentenceAnswer: 'maybe', emoji: '🤔'),
VocabItem(word: 'of course', translation: 'por supuesto', sentenceWithBlank: '___ I can help.', sentenceAnswer: 'of course', emoji: '👌'),
VocabItem(word: 'really?', translation: '¿en serio?', sentenceWithBlank: '___?', sentenceAnswer: 'really?', emoji: '😲'),
VocabItem(word: 'I think so', translation: 'creo que sí', sentenceWithBlank: '___ too.', sentenceAnswer: 'I think so', emoji: '💭'),
VocabItem(word: 'I don’t think so', translation: 'creo que no', sentenceWithBlank: 'No, ___...', sentenceAnswer: 'I don’t think so', emoji: '🙅'),
VocabItem(word: 'what’s happening?', translation: '¿qué pasa?', sentenceWithBlank: '___ here?', sentenceAnswer: 'what’s happening?', emoji: '❗'),
VocabItem(word: 'what time is it?', translation: '¿qué hora es?', sentenceWithBlank: '___?', sentenceAnswer: 'what time is it?', emoji: '⏰'),
VocabItem(word: 'I’m hungry', translation: 'tengo hambre', sentenceWithBlank: '___, let’s eat.', sentenceAnswer: 'I’m hungry', emoji: '🍽️'),
VocabItem(word: 'I’m thirsty', translation: 'tengo sed', sentenceWithBlank: '___, I need water.', sentenceAnswer: 'I’m thirsty', emoji: '🥤'),
VocabItem(word: 'I’m tired', translation: 'estoy cansado', sentenceWithBlank: '___, I need rest.', sentenceAnswer: 'I’m tired', emoji: '😴'),
VocabItem(word: 'let’s go', translation: 'vámonos', sentenceWithBlank: 'Okay, ___.', sentenceAnswer: 'let’s go', emoji: '🏃‍♂️'),
VocabItem(word: 'come here', translation: 'ven aquí', sentenceWithBlank: '___, please.', sentenceAnswer: 'come here', emoji: '👉'),
VocabItem(word: 'look', translation: 'mira', sentenceWithBlank: '___ at this!', sentenceAnswer: 'look', emoji: '👀'),
VocabItem(word: 'listen', translation: 'escucha', sentenceWithBlank: '___ to me.', sentenceAnswer: 'listen', emoji: '🎧'),
VocabItem(word: 'I’m busy', translation: 'estoy ocupado', sentenceWithBlank: 'Sorry, ___.', sentenceAnswer: 'I’m busy', emoji: '📚'),
VocabItem(word: 'I’m ready', translation: 'estoy listo', sentenceWithBlank: '___ to start.', sentenceAnswer: 'I’m ready', emoji: '✅'),
VocabItem(word: 'I agree', translation: 'estoy de acuerdo', sentenceWithBlank: 'Yes, ___.', sentenceAnswer: 'I agree', emoji: '🤝'),
VocabItem(word: 'I disagree', translation: 'no estoy de acuerdo', sentenceWithBlank: 'Sorry, ___.', sentenceAnswer: 'I disagree', emoji: '🙅‍♂️'),
],
  ),

  Level(
    title: 'LEVEL 14 — Work & School',
    description: 'Tap to study this level',
    number: 14,
    accentColor: 0xFF607D8B,
    imageUrl: 'asset:assets/images/levels/level14.png',
    version: 10,
    theory: '''
# Nivel 14: Trabajo y Escuela

Ya sea que estés frente a un escritorio o en un aula, estas palabras son el motor de tu crecimiento. En este nivel, aprenderás a describir tus tareas diarias, tus herramientas y las personas con las que colaboras.

Domina el entorno productivo con estas categorías:

### Personas y Roles:
En clase: Teacher (maestro) y Student (estudiante).
En el trabajo: Boss (jefe), Manager (gerente) y Team (equipo).

### Objetos y Herramientas:
Tecnología: Computer, Laptop, Keyboard (teclado), Printer (impresora).
Escritorio: Pen (bolígrafo), Notebook (cuaderno), Desk (escritorio).

### Tareas y Procesos:
Logística: Meeting (reunión), Deadline (fecha límite), Schedule (horario), Project.
Evaluación: Exam, Test, Grade (nota), Subject (materia).

### Acciones de Aprendizaje:
Study (estudiar), Learn (aprender), Practice (practicar), Ask (preguntar) y Answer (responder).

### 💡 Tip de "Level Up":
No confundas "Homework" con "Task". 
Homework es específicamente la tarea para casa de la escuela. 
Task es cualquier tarea o labor general, especialmente en el trabajo. 
¡Y recuerda que en inglés no se dice "do an exam", se suele decir "take an exam"!

Misión: Usa este vocabulario para hablar de tus metas. ¡Cada palabra aprendida es una herramienta nueva para tu futuro!
''',
    items: const [
      VocabItem(word: 'teacher', translation: 'maestro', sentenceWithBlank: 'The ___ explained the lesson.', sentenceAnswer: 'teacher', emoji: '👨‍🏫'),
VocabItem(word: 'student', translation: 'estudiante', sentenceWithBlank: 'The ___ is studying English.', sentenceAnswer: 'student', emoji: '👩‍🎓'),
VocabItem(word: 'classroom', translation: 'aula', sentenceWithBlank: 'The ___ is very big.', sentenceAnswer: 'classroom', emoji: '🏫'),
VocabItem(word: 'school', translation: 'escuela', sentenceWithBlank: 'They walk to ___.', sentenceAnswer: 'school', emoji: '🏫'),
VocabItem(word: 'office', translation: 'oficina', sentenceWithBlank: 'She works in an ___.', sentenceAnswer: 'office', emoji: '🏢'),
VocabItem(word: 'job', translation: 'trabajo', sentenceWithBlank: 'He got a new ___.', sentenceAnswer: 'job', emoji: '💼'),
VocabItem(word: 'meeting', translation: 'reunión', sentenceWithBlank: 'The ___ starts at 3.', sentenceAnswer: 'meeting', emoji: '📅'),
VocabItem(word: 'boss', translation: 'jefe', sentenceWithBlank: 'My ___ is very strict.', sentenceAnswer: 'boss', emoji: '👔'),
VocabItem(word: 'manager', translation: 'gerente', sentenceWithBlank: 'The ___ approved the plan.', sentenceAnswer: 'manager', emoji: '🗂️'),
VocabItem(word: 'team', translation: 'equipo', sentenceWithBlank: 'Our ___ works well together.', sentenceAnswer: 'team', emoji: '👥'),
VocabItem(word: 'task', translation: 'tarea', sentenceWithBlank: 'Finish this ___ today.', sentenceAnswer: 'task', emoji: '📝'),
VocabItem(word: 'project', translation: 'proyecto', sentenceWithBlank: 'The ___ is almost done.', sentenceAnswer: 'project', emoji: '📁'),
VocabItem(word: 'deadline', translation: 'fecha límite', sentenceWithBlank: 'The ___ is tomorrow.', sentenceAnswer: 'deadline', emoji: '⏰'),
VocabItem(word: 'schedule', translation: 'horario', sentenceWithBlank: 'My ___ is very busy.', sentenceAnswer: 'schedule', emoji: '📆'),
VocabItem(word: 'break', translation: 'descanso', sentenceWithBlank: 'Let’s take a ___.', sentenceAnswer: 'break', emoji: '☕'),
VocabItem(word: 'computer', translation: 'computadora', sentenceWithBlank: 'The ___ is not working.', sentenceAnswer: 'computer', emoji: '💻'),
VocabItem(word: 'laptop', translation: 'laptop', sentenceWithBlank: 'My ___ is very fast.', sentenceAnswer: 'laptop', emoji: '💻'),
VocabItem(word: 'keyboard', translation: 'teclado', sentenceWithBlank: 'The ___ is new.', sentenceAnswer: 'keyboard', emoji: '⌨️'),
VocabItem(word: 'mouse', translation: 'ratón', sentenceWithBlank: 'I need a new ___.', sentenceAnswer: 'mouse', emoji: '🖱️'),
VocabItem(word: 'internet', translation: 'internet', sentenceWithBlank: 'The ___ is slow today.', sentenceAnswer: 'internet', emoji: '🌐'),
VocabItem(word: 'email', translation: 'correo electrónico', sentenceWithBlank: 'I sent an ___.', sentenceAnswer: 'email', emoji: '📧'),
VocabItem(word: 'document', translation: 'documento', sentenceWithBlank: 'Open the ___.', sentenceAnswer: 'document', emoji: '📄'),
VocabItem(word: 'book', translation: 'libro', sentenceWithBlank: 'She read the ___.', sentenceAnswer: 'book', emoji: '📖'),
VocabItem(word: 'homework', translation: 'tarea', sentenceWithBlank: 'Do your ___ now.', sentenceAnswer: 'homework', emoji: '📝'),
VocabItem(word: 'exam', translation: 'examen', sentenceWithBlank: 'The ___ is next week.', sentenceAnswer: 'exam', emoji: '✏️'),
VocabItem(word: 'test', translation: 'prueba', sentenceWithBlank: 'We have a ___ today.', sentenceAnswer: 'test', emoji: '🧪'),
VocabItem(word: 'study', translation: 'estudiar', sentenceWithBlank: 'I need to ___ more.', sentenceAnswer: 'study', emoji: '📚'),
VocabItem(word: 'learn', translation: 'aprender', sentenceWithBlank: 'I want to ___ English.', sentenceAnswer: 'learn', emoji: '🧠'),
VocabItem(word: 'practice', translation: 'practicar', sentenceWithBlank: 'You must ___ every day.', sentenceAnswer: 'practice', emoji: '🎯'),
VocabItem(word: 'write', translation: 'escribir', sentenceWithBlank: 'Please ___ your name.', sentenceAnswer: 'write', emoji: '✍️'),
VocabItem(word: 'read', translation: 'leer', sentenceWithBlank: '___ the instructions.', sentenceAnswer: 'read', emoji: '📘'),
VocabItem(word: 'listen', translation: 'escuchar', sentenceWithBlank: '___ to the teacher.', sentenceAnswer: 'listen', emoji: '🎧'),
VocabItem(word: 'speak', translation: 'hablar', sentenceWithBlank: 'Try to ___ in English.', sentenceAnswer: 'speak', emoji: '🗣️'),
VocabItem(word: 'ask', translation: 'preguntar', sentenceWithBlank: '___ a question.', sentenceAnswer: 'ask', emoji: '❓'),
VocabItem(word: 'answer', translation: 'responder', sentenceWithBlank: 'Please ___ the question.', sentenceAnswer: 'answer', emoji: '✔️'),
VocabItem(word: 'explain', translation: 'explicar', sentenceWithBlank: 'Can you ___ that?', sentenceAnswer: 'explain', emoji: '💬'),
VocabItem(word: 'teach', translation: 'enseñar', sentenceWithBlank: 'They ___ science.', sentenceAnswer: 'teach', emoji: '🧑‍🏫'),
VocabItem(word: 'learned', translation: 'aprendido', sentenceWithBlank: 'I have ___ a lot.', sentenceAnswer: 'learned', emoji: '📚'),
VocabItem(word: 'grade', translation: 'nota', sentenceWithBlank: 'She got a good ___.', sentenceAnswer: 'grade', emoji: '🏅'),
VocabItem(word: 'subject', translation: 'materia', sentenceWithBlank: 'Math is my favorite ___.', sentenceAnswer: 'subject', emoji: '➗'),
VocabItem(word: 'class', translation: 'clase', sentenceWithBlank: 'The ___ starts now.', sentenceAnswer: 'class', emoji: '📚'),
VocabItem(word: 'pen', translation: 'bolígrafo', sentenceWithBlank: 'I need a ___.', sentenceAnswer: 'pen', emoji: '🖊️'),
VocabItem(word: 'paper', translation: 'papel', sentenceWithBlank: 'Write it on ___.', sentenceAnswer: 'paper', emoji: '📄'),
VocabItem(word: 'notebook', translation: 'cuaderno', sentenceWithBlank: 'Bring your ___.', sentenceAnswer: 'notebook', emoji: '📓'),
VocabItem(word: 'chair', translation: 'silla', sentenceWithBlank: 'Sit on the ___.', sentenceAnswer: 'chair', emoji: '🪑'),
VocabItem(word: 'desk', translation: 'escritorio', sentenceWithBlank: 'The ___ is clean.', sentenceAnswer: 'desk', emoji: '🛋️'),
VocabItem(word: 'printer', translation: 'impresora', sentenceWithBlank: 'The ___ is out of ink.', sentenceAnswer: 'printer', emoji: '🖨️'),
VocabItem(word: 'worksheet', translation: 'hoja de trabajo', sentenceWithBlank: 'Complete the ___.', sentenceAnswer: 'worksheet', emoji: '📄'),
VocabItem(word: 'library', translation: 'biblioteca', sentenceWithBlank: 'The ___ is quiet.', sentenceAnswer: 'library', emoji: '📚'),
VocabItem(word: 'college', translation: 'universidad', sentenceWithBlank: 'He studies at ___.', sentenceAnswer: 'college', emoji: '🎓'),
    ],
  ),

  Level(
    title: 'LEVEL 15 — Phrasal Verbs',
    description: 'Tap to study this level',
    number: 15,
    accentColor: 0xFF673AB7,
    imageUrl: 'asset:assets/images/levels/level15.png',
    version: 10,
    theory: '''
# Nivel 15: Phrasal Verbs

¡Felicidades! Has llegado a uno de los temas más importantes y emocionantes del inglés. Los Phrasal Verbs son verbos que, al unirse con una pequeña palabra (preposición o adverbio), cambian su significado original.

No intentes traducirlos palabra por palabra; apréndelos como un solo concepto:

### Acciones Físicas y Movimiento:
Cuerpo: Sit down (sentarse), Stand up (ponerse de pie), Turn around (darse la vuelta).
Objetos: Pick up (recoger), Put down (soltar), Throw away (botar a la basura).
Ropa: Put on (ponerse ropa), Take off (quitarse ropa).

### En el Transporte y Viajes:
Entrar/Salir: Get in/Get out (para carros o taxis).
Subir/Bajar: Get on/Get off (para bus, tren o avión).
Hoteles: Check in (registrarse) y Check out (salir).

### El mundo de "Look" (Mirar):
Look for: Buscar algo perdido.
Look after: Cuidar a alguien.
Look up: Buscar información (en un libro o internet).

### Emociones y Relaciones:
Calm down (calmarse), Cheer up (animarse), Break up (terminar una relación), Grow up (crecer).

### 💡 Tip de "Level Up":
Muchos Phrasal Verbs son opuestos. Si los aprendes en parejas, los recordarás más rápido:
Turn on (encender) ↔️ Turn off (apagar).
Log in (entrar a cuenta) ↔️ Log out (salir de cuenta).

Misión: Estos verbos se usan en el 80% de las conversaciones casuales. ¡Domínalos y habrás dado un salto gigante en tu fluidez!
''',
    items: const [
      VocabItem(word: 'wake up', translation: 'despertarse', sentenceWithBlank: 'I ___ at 7 AM.', sentenceAnswer: 'wake up', emoji: '⏰'),
VocabItem(word: 'get up', translation: 'levantarse', sentenceWithBlank: 'I ___ from bed.', sentenceAnswer: 'get up', emoji: '🛏️'),
VocabItem(word: 'sit down', translation: 'sentarse', sentenceWithBlank: 'Please ___ here.', sentenceAnswer: 'sit down', emoji: '🪑'),
VocabItem(word: 'stand up', translation: 'ponerse de pie', sentenceWithBlank: 'Everyone, ___!', sentenceAnswer: 'stand up', emoji: '🚶'),
VocabItem(word: 'turn on', translation: 'encender', sentenceWithBlank: '___ the light.', sentenceAnswer: 'turn on', emoji: '💡'),
VocabItem(word: 'turn off', translation: 'apagar', sentenceWithBlank: '___ the TV.', sentenceAnswer: 'turn off', emoji: '📺'),
VocabItem(word: 'pick up', translation: 'recoger', sentenceWithBlank: 'Can you ___ the phone?', sentenceAnswer: 'pick up', emoji: '📞'),
VocabItem(word: 'put down', translation: 'poner/soltar', sentenceWithBlank: '___ the bag.', sentenceAnswer: 'put down', emoji: '👜'),
VocabItem(word: 'put on', translation: 'ponerse', sentenceWithBlank: '___ your jacket.', sentenceAnswer: 'put on', emoji: '🧥'),
VocabItem(word: 'take off', translation: 'quitarse/despegar', sentenceWithBlank: '___ your shoes.', sentenceAnswer: 'take off', emoji: '👟'),
VocabItem(word: 'look for', translation: 'buscar', sentenceWithBlank: 'I’m ___ my keys.', sentenceAnswer: 'look for', emoji: '🔍'),
VocabItem(word: 'look at', translation: 'mirar', sentenceWithBlank: '___ this picture.', sentenceAnswer: 'look at', emoji: '👀'),
VocabItem(word: 'look after', translation: 'cuidar', sentenceWithBlank: 'Can you ___ the kids?', sentenceAnswer: 'look after', emoji: '🧒'),
VocabItem(word: 'look up', translation: 'buscar (información)', sentenceWithBlank: '___ the word online.', sentenceAnswer: 'look up', emoji: '📘'),
VocabItem(word: 'find out', translation: 'descubrir', sentenceWithBlank: 'I want to ___ the truth.', sentenceAnswer: 'find out', emoji: '🔎'),
VocabItem(word: 'check in', translation: 'registrarse', sentenceWithBlank: 'We must ___ at the hotel.', sentenceAnswer: 'check in', emoji: '🏨'),
VocabItem(word: 'check out', translation: 'dejar habitación', sentenceWithBlank: 'We ___ tomorrow.', sentenceAnswer: 'check out', emoji: '🧳'),
VocabItem(word: 'go out', translation: 'salir', sentenceWithBlank: 'Let’s ___ tonight.', sentenceAnswer: 'go out', emoji: '🌃'),
VocabItem(word: 'come in', translation: 'entrar', sentenceWithBlank: 'Please ___!', sentenceAnswer: 'come in', emoji: '🚪'),
VocabItem(word: 'come back', translation: 'volver', sentenceWithBlank: '___ soon.', sentenceAnswer: 'come back', emoji: '↩️'),
VocabItem(word: 'get in', translation: 'entrar (vehículo)', sentenceWithBlank: '___ the car.', sentenceAnswer: 'get in', emoji: '🚗'),
VocabItem(word: 'get out', translation: 'salir', sentenceWithBlank: '___ of the taxi.', sentenceAnswer: 'get out', emoji: '🚕'),
VocabItem(word: 'get on', translation: 'subir (bus/tren)', sentenceWithBlank: '___ the bus.', sentenceAnswer: 'get on', emoji: '🚌'),
VocabItem(word: 'get off', translation: 'bajarse (bus/tren)', sentenceWithBlank: '___ at the next stop.', sentenceAnswer: 'get off', emoji: '🚉'),
VocabItem(word: 'give up', translation: 'rendirse', sentenceWithBlank: 'Never ___.', sentenceAnswer: 'give up', emoji: '💪'),
VocabItem(word: 'hurry up', translation: 'apurarse', sentenceWithBlank: '___, we’re late!', sentenceAnswer: 'hurry up', emoji: '🏃'),
VocabItem(word: 'slow down', translation: 'bajar velocidad', sentenceWithBlank: 'Please ___.', sentenceAnswer: 'slow down', emoji: '🐢'),
VocabItem(word: 'calm down', translation: 'calmarse', sentenceWithBlank: '___ and breathe.', sentenceAnswer: 'calm down', emoji: '😌'),
VocabItem(word: 'work out', translation: 'hacer ejercicio', sentenceWithBlank: 'I ___ every morning.', sentenceAnswer: 'work out', emoji: '🏋️'),
VocabItem(word: 'figure out', translation: 'resolver', sentenceWithBlank: 'I can ___ the problem.', sentenceAnswer: 'figure out', emoji: '🧩'),
VocabItem(word: 'set up', translation: 'configurar', sentenceWithBlank: 'Help me ___ the account.', sentenceAnswer: 'set up', emoji: '⚙️'),
VocabItem(word: 'turn around', translation: 'darse vuelta', sentenceWithBlank: '___ and look.', sentenceAnswer: 'turn around', emoji: '🔄'),
VocabItem(word: 'throw away', translation: 'botar', sentenceWithBlank: '___ the trash.', sentenceAnswer: 'throw away', emoji: '🗑️'),
VocabItem(word: 'come up with', translation: 'proponer/crear', sentenceWithBlank: 'I need to ___ a plan.', sentenceAnswer: 'come up with', emoji: '💡'),
VocabItem(word: 'run out of', translation: 'quedarse sin', sentenceWithBlank: 'We ___ milk.', sentenceAnswer: 'run out of', emoji: '🥛'),
VocabItem(word: 'put away', translation: 'guardar', sentenceWithBlank: '___ your clothes.', sentenceAnswer: 'put away', emoji: '👕'),
VocabItem(word: 'break down', translation: 'dañarse', sentenceWithBlank: 'My car ___.', sentenceAnswer: 'break down', emoji: '🚗💥'),
VocabItem(word: 'carry on', translation: 'continuar', sentenceWithBlank: '___ working.', sentenceAnswer: 'carry on', emoji: '➡️'),
VocabItem(word: 'catch up', translation: 'ponerse al día', sentenceWithBlank: 'I need to ___ on work.', sentenceAnswer: 'catch up', emoji: '📚'),
VocabItem(word: 'hold on', translation: 'esperar', sentenceWithBlank: '___ a second.', sentenceAnswer: 'hold on', emoji: '✋'),
VocabItem(word: 'hang up', translation: 'colgar', sentenceWithBlank: 'Don’t ___ the phone.', sentenceAnswer: 'hang up', emoji: '📞❌'),
VocabItem(word: 'log in', translation: 'iniciar sesión', sentenceWithBlank: 'Please ___ to continue.', sentenceAnswer: 'log in', emoji: '🔐'),
VocabItem(word: 'log out', translation: 'cerrar sesión', sentenceWithBlank: 'Don’t forget to ___.', sentenceAnswer: 'log out', emoji: '🚪'),
VocabItem(word: 'fill out', translation: 'llenar (formulario)', sentenceWithBlank: '___ the form.', sentenceAnswer: 'fill out', emoji: '📝'),
VocabItem(word: 'go back', translation: 'regresar', sentenceWithBlank: 'Let’s ___ home.', sentenceAnswer: 'go back', emoji: '↩️'),
VocabItem(word: 'bring back', translation: 'devolver/traer', sentenceWithBlank: 'Please ___ my book.', sentenceAnswer: 'bring back', emoji: '📖'),
VocabItem(word: 'take out', translation: 'sacar', sentenceWithBlank: '___ the trash.', sentenceAnswer: 'take out', emoji: '🗑️'),
VocabItem(word: 'move on', translation: 'seguir adelante', sentenceWithBlank: 'It’s time to ___.', sentenceAnswer: 'move on', emoji: '➡️'),
VocabItem(word: 'break up', translation: 'terminar relación', sentenceWithBlank: 'They decided to ___.', sentenceAnswer: 'break up', emoji: '💔'),
VocabItem(word: 'grow up', translation: 'crecer', sentenceWithBlank: 'Kids ___ fast.', sentenceAnswer: 'grow up', emoji: '🧒➡️🧑'),
VocabItem(word: 'cheer up', translation: 'animarse', sentenceWithBlank: 'Come on, ___!', sentenceAnswer: 'cheer up', emoji: '😄'),
VocabItem(word: 'clean up', translation: 'limpiar', sentenceWithBlank: 'Please ___ the room.', sentenceAnswer: 'clean up', emoji: '🧹'),
VocabItem(word: 'pay back', translation: 'pagar de vuelta', sentenceWithBlank: 'I’ll ___ the money tomorrow.', sentenceAnswer: 'pay back', emoji: '💵'),
VocabItem(word: 'show up', translation: 'aparecer', sentenceWithBlank: 'He didn’t ___.', sentenceAnswer: 'show up', emoji: '👤❓'),
VocabItem(word: 'take care of', translation: 'cuidar', sentenceWithBlank: 'I will ___ the dog.', sentenceAnswer: 'take care of', emoji: '🐶'),

    ],
  ),

];