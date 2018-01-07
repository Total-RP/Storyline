----------------------------------------------------------------------------------
--  Storyline
--	---------------------------------------------------------------------------
--	Copyright 2015 Sylvain Cossement (telkostrasz@totalrp3.info)
--	Copyright 2015 Renaud "Ellypse" Parize (ellypse@totalrp3.info)
--
--	Licensed under the Apache License, Version 2.0 (the "License");
--	you may not use this file except in compliance with the License.
--	You may obtain a copy of the License at
--
--		http://www.apache.org/licenses/LICENSE-2.0
--
--	Unless required by applicable law or agreed to in writing, software
--	distributed under the License is distributed on an "AS IS" BASIS,
--	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--	See the License for the specific language governing permissions and
--	limitations under the License.
----------------------------------------------------------------------------------

Storyline_API = {
	lib = {},
	locale = {},
};

Storyline_API.locale.info = {

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_EN
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	
	["enUS"] = {
		localeText = "English",
		localeContent = {
			SL_STORYLINE = "Storyline",
			SL_SELECT_DIALOG_OPTION = "Select dialog option",
			SL_SELECT_AVAILABLE_QUEST = "Select available quest",
			SL_ACCEPTANCE = "I accept.",
			SL_DECLINE = "I refuse.",
			SL_NEXT = "Continue",
			SL_CONTINUE = "Complete quest",
			SL_NOT_YET = "Come back when it's done",
			SL_CHECK_OBJ = "Check objectives",
			SL_RESET = "Rewind",
			SL_RESET_TT = "Rewind this dialogue.",
			SL_REWARD_MORE = "You will also get",
			SL_REWARD_MORE_SUB = "\nMoney: |cffffffff%s|r\nExperience: |cffffffff%s xp|r\n\n|cffffff00Click:|r Get your reward!",
			SL_GET_REWARD = "Get your reward",
			SL_SELECT_REWARD = "Select your reward",
			SL_CONFIG = "Settings",
			SL_CONFIG_WELCOME = [[Thank you for using Storyline!

You can follow Storyline developers on Twitter |cff55acee@EllypseCelwe|r and |cff55acee@Telkostrasz|r to get news about the add-on and sneek peaks of its development.
]],
			SL_CONFIG_LANGUAGE = "Language",
			SL_CONFIG_TEXTSPEED_TITLE = "Text animation speed",
			SL_CONFIG_TEXTSPEED = "%.1fx",
			SL_CONFIG_TEXTSPEED_INSTANT = "No animation",
			SL_CONFIG_TEXTSPEED_HIGH = "Fast",
			SL_CONFIG_AUTOEQUIP = "Auto equip reward (experimental)",
			SL_CONFIG_AUTOEQUIP_TT = "Auto equip rewards if it has a better item lvl.",
			SL_CONFIG_FORCEGOSSIP = "Show flavor texts",
			SL_CONFIG_FORCEGOSSIP_TT = "Show flavor texts on NPCs like merchants or fly masters.",
			SL_CONFIG_USE_KEYBOARD = "Use keyboard shortcuts",
			SL_CONFIG_USE_KEYBOARD_TT = "Use keyboard shortcuts to navigate inside dialogs (space bar to advance, backspace to go back, keys 1 to 0 to select a dialog choice)",
			SL_CONFIG_HIDEORIGINALFRAMES = "Hide original frames",
			SL_CONFIG_HIDEORIGINALFRAMES_TT = "Hide the original quest frame and NPC dialogs frame.",
			SL_CONFIG_LOCKFRAME = "Lock frame",
			SL_CONFIG_LOCKFRAME_TT = "Lock Storyline frame so it cannot be moved by mistake.",
			SL_CONFIG_SAMPLE_TEXT = "Grumpy wizards make toxic brew for the evil queen and jack",
			SL_CONFIG_BIG_SAMPLE_TEXT = [[Here’s to the crazy ones. The misfits. The rebels. The troublemakers. The round pegs in the square holes. The ones who see things differently. They’re not fond of rules. And they have no respect for the status quo. You can quote them, disagree with them, glorify or vilify them. About the only thing you can’t do is ignore them.]],
			SL_CONFIG_QUEST_TITLE = "Quest title",
			SL_CONFIG_DIALOG_TEXT = "Dialog text",
			SL_CONFIG_NPC_NAME = "NPC name",
			SL_CONFIG_NEXT_ACTION = "Next action",
			SL_CONFIG_DIALOG_CHOICES = "Dialog choices",
			SL_CONFIG_STYLING_OPTIONS = "Styling options",
			SL_CONFIG_STYLING_OPTIONS_SUBTEXT = "", -- Nothing for now, maybe later
			SL_CONFIG_MISCELLANEOUS_SUBTEXT = "", -- Nothing for now, maybe later
			SL_CONFIG_MISCELLANEOUS = "Miscellaneous options",
			SL_CONFIG_DEBUG = "Debug mode",
			SL_CONFIG_DEBUG_TT = "Enable the debug frame showing development data under Storyline frame",
			SL_CONFIG_DISABLE_IN_INSTANCES = "Disable Storyline in instances",
			SL_CONFIG_DISABLE_IN_INSTANCES_TT = "Automatically disable Storyline when you are inside an instance (dungeon, battleground, raid, scenario…)",
			SL_CONFIG_DISABLE_IN_DMF = "Disable Storyline on DMF island",
			SL_CONFIG_DISABLE_IN_DMF_TT = "Automatically disable Storyline when you are in the Darkmoon Faire Island.",
			SL_CONFIG_UI_LAYOUT_ENGINE = "Use default frames position",
			SL_CONFIG_UI_LAYOUT_ENGINE_TT = [[Use the default layout so that Storyline appears on the left like the character or spell frame and gets pushed if new frames are opened.

The frame cannot be moved when using the default position. This option requires a reload of the UI.]],
			SL_RESIZE = "Resize",
			SL_RESIZE_TT = "Drag and drop to resize",
			SL_ABOUT = "About",
			SL_ABOUT_TEXT = [[This is add-on is being maintained and updated thanks to the help of Ellype's Patreon (|cffcccccchttp://patreon.com/Ellypse|r) supporters:

%s
]],
		}
	},
	
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_FR
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	
	["frFR"] = {
		localeText = "Français",
		localeContent =
		--@localization(locale="frFR", format="lua_table", handle-unlocalized="ignore")@
		--@do-not-package@
		{
			["SL_ACCEPTANCE"] = "J'accepte.",
			["SL_CHECK_OBJ"] = "Vérifier objectifs",
			["SL_CONFIG"] = "Configuration",
			["SL_CONFIG_AUTOEQUIP"] = "Équipement automatique (expérimental)",
			["SL_CONFIG_AUTOEQUIP_TT"] = "Équipe automatiquement les récompense si elles ont un meilleur niveau d'équipement.",
			["SL_CONFIG_BIG_SAMPLE_TEXT"] = [=[« C'est un trou de verdure où chante une rivière,
Accrochant follement aux herbes des haillons
D'argent ; où le soleil, de la montagne fière,
Luit : c'est un petit val qui mousse de rayons. »
— Arthur Rimbaud]=],
			["SL_CONFIG_DEBUG"] = "Mode débug",
			["SL_CONFIG_DEBUG_TT"] = "Activer le mode débug pour afficher la fenêtre d'informations de développement sous la fenêtre principale de Storyline.",
			["SL_CONFIG_DIALOG_CHOICES"] = "Options de dialogue",
			["SL_CONFIG_DIALOG_TEXT"] = "Texte de dialogues",
			["SL_CONFIG_DISABLE_IN_INSTANCES"] = "Désactiver Storyline en instance",
			["SL_CONFIG_DISABLE_IN_INSTANCES_TT"] = "Désactiver Storyline automatiquement dans les instances (donjons, champs de bataille, raid, scenario…)",
			["SL_CONFIG_FORCEGOSSIP"] = "Forcer les textes des PNJs",
			["SL_CONFIG_FORCEGOSSIP_TT"] = "Forcer l'affichage des textes des PNJs normalement masqués, comme les marchands ou les maîtres de vol.",
			["SL_CONFIG_HIDEORIGINALFRAMES"] = "Cacher les fenêtres originales",
			["SL_CONFIG_HIDEORIGINALFRAMES_TT"] = "Cacher les fenêtres originales du jeu (quêtes et dialogues de PNJs) pour qu'il n'y ait que Storyline de visible à l'écran.",
			["SL_CONFIG_LANGUAGE"] = "Langue",
			["SL_CONFIG_LOCKFRAME"] = "Verrouiller la fenêtre",
			["SL_CONFIG_LOCKFRAME_TT"] = "Verrouiller la fenêtre de Storyline pour empêcher un déplacement par erreur.",
			["SL_CONFIG_MISCELLANEOUS"] = "Options diverses",
			["SL_CONFIG_NEXT_ACTION"] = "Action suivante",
			["SL_CONFIG_NPC_NAME"] = "Nom du PNJ",
			["SL_CONFIG_QUEST_TITLE"] = "Titre de la quête",
			["SL_CONFIG_SAMPLE_TEXT"] = "Voix ambiguë d’un cœur qui au zéphyr préfère les jattes de kiwi.",
			["SL_CONFIG_STYLING_OPTIONS"] = "Options d’affichage",
			["SL_CONFIG_TEXTSPEED"] = "%.1fx",
			["SL_CONFIG_TEXTSPEED_HIGH"] = "Rapide",
			["SL_CONFIG_TEXTSPEED_INSTANT"] = "Pas de défilement",
			["SL_CONFIG_TEXTSPEED_TITLE"] = "Vitesse d'animation du texte",
			["SL_CONFIG_UI_LAYOUT_ENGINE"] = "Position par défaut",
			["SL_CONFIG_UI_LAYOUT_ENGINE_TT"] = [=[Utiliser les positions de fenêtres par défaut, alignées sur la gauche, comme pour la fenêtre de personnage ou le grimoire.

La fenêtre ne peut plus être déplacée dans ce mode. Cette option requière un rechargement de l'interface.]=],
			["SL_CONFIG_USE_KEYBOARD"] = "Utiliser les raccourcis clavier",
			["SL_CONFIG_USE_KEYBOARD_TT"] = "Utiliser les raccourcis clavier pour naviguer dans les dialogues (barre espace pour avancer, touche retour pour revenir en arrière, touches 1 à 0 pour sélectionner une option de dialogue).",
			["SL_CONFIG_WELCOME"] = [=[Merci d'utiliser Storyline!

Vous pouvez suivre les développeurs de Storyline sur Twitter, |cff55acee@EllypseCelwe|r et |cff55acee@Telkostrasz|r, pour recevoir des informations sur les mise-à-jour de l'add-on et des aperçu de son développement.]=],
			["SL_CONTINUE"] = "Terminer la quête",
			["SL_DECLINE"] = "Je refuse.",
			["SL_GET_REWARD"] = "Prenez votre récompense",
			["SL_NEXT"] = "Continuer",
			["SL_NOT_YET"] = "Revenez quand cela sera fait",
			["SL_RESET"] = "Début",
			["SL_RESET_TT"] = "Revenir au début du dialogue",
			["SL_RESIZE"] = "Redimensionner",
			["SL_RESIZE_TT"] = "Cliquer-glisser pour redimensionner",
			["SL_REWARD_MORE"] = "Vous recevrez aussi",
			["SL_REWARD_MORE_SUB"] = [=[
Argent: |cffffffff%s|r
Expérience: |cffffffff%s xp|r

|cffffff00Clic:|r Prenez votre récompense !]=],
			["SL_SELECT_AVAILABLE_QUEST"] = "Sélectionnez une quête",
			["SL_SELECT_DIALOG_OPTION"] = "Sélectionnez une option",
			["SL_SELECT_REWARD"] = "Choisissez votre récompense",
			["SL_STORYLINE"] = "Storyline",
		}
		--@end-do-not-package@
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_SP
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	["esES"] = {
		localeText = "Español",
		localeContent =
		--@localization(locale="esES", format="lua_table", handle-unlocalized="ignore")@
		--@do-not-package@
		{
			["SL_ACCEPTANCE"] = "Acepto",
			["SL_CHECK_OBJ"] = "Comprueba los objetivos",
			["SL_CONFIG"] = "Configuración",
			["SL_CONFIG_AUTOEQUIP"] = "Equipar automáticamente las recompensas (experimental)",
			["SL_CONFIG_AUTOEQUIP_TT"] = "Equipa automáticamente las recompensas si tienen un nivel de equipo mejor.",
			["SL_CONFIG_BIG_SAMPLE_TEXT"] = [=[¿Dónde están ahora el caballo y el caballero? ¿Dónde está el cuerno que sonaba? ¿Dónde están el yelmo y la coraza, y los luminosos cabellos flotantes? ¿Dónde están la mano en las cuerdas del arpa y el fuego rojo encendido? ¿Dónde están la primavera y la cosecha y la espiga alta que crece? Han pasado como lluvia en la montaña, como un viento en el prado; los días han descendido en el oeste en la sombra de detrás de las colinas. ¿Quién recogerá el humo de la ardiente madera muerta, o verá los años fugitivos que vuelven del mar?
—Poema de Rohan sobre su fundador, Eorl el Joven]=],
			["SL_CONFIG_DEBUG"] = "Modo de depuración",
			["SL_CONFIG_DEBUG_TT"] = "Activa el marco de depuración que muestra información de desarrollo debajo del marco de Storyline",
			["SL_CONFIG_DIALOG_TEXT"] = "Texto de dialogo",
			["SL_CONFIG_DISABLE_IN_INSTANCES"] = "Deshabilitar Storyline en estancias",
			["SL_CONFIG_DISABLE_IN_INSTANCES_TT"] = "Deshabilitar automáticamente Storyline cuando estés en una estancia (mazmorra, campo de batalla, banda, escenario...)",
			["SL_CONFIG_FORCEGOSSIP"] = "Forzar diálogos de PNJs",
			["SL_CONFIG_FORCEGOSSIP_TT"] = "Fuerza a que aparezcan diálogos generalmente ocultos en PNJs, como comerciantes y maestros de vuelo",
			["SL_CONFIG_HIDEORIGINALFRAMES"] = "Ocultar los marcos originales",
			["SL_CONFIG_HIDEORIGINALFRAMES_TT"] = "Oculta los marcos originales (diálogos de misión y PNJ) de forma que solo Storyline estará visible en la pantalla",
			["SL_CONFIG_LANGUAGE"] = "Idioma",
			["SL_CONFIG_LOCKFRAME"] = "Bloquear marco",
			["SL_CONFIG_LOCKFRAME_TT"] = "Bloquea el marco de Storyline de forma que no se mueva por error.",
			["SL_CONFIG_MISCELLANEOUS"] = "Opciones varias",
			["SL_CONFIG_NEXT_ACTION"] = "Siguiente acción",
			["SL_CONFIG_NPC_NAME"] = "Nombre del PNJ",
			["SL_CONFIG_QUEST_TITLE"] = "Título de la misión",
			["SL_CONFIG_SAMPLE_TEXT"] = "Malas noticias amigos, Carapútrea ha muerto. Pero buenas noticias, amigos. ¡Ha dejado un moco, que no es poco!",
			["SL_CONFIG_STYLING_OPTIONS"] = "Opciones de estilo",
			["SL_CONFIG_TEXTSPEED"] = "%.1fx",
			["SL_CONFIG_TEXTSPEED_HIGH"] = "Alta",
			["SL_CONFIG_TEXTSPEED_INSTANT"] = "Sin animación",
			["SL_CONFIG_TEXTSPEED_TITLE"] = "Velocidad de animación del texto",
			["SL_CONFIG_UI_LAYOUT_ENGINE"] = "Usar posición por defecto de los marcos",
			["SL_CONFIG_UI_LAYOUT_ENGINE_TT"] = [=[Usar el diseño por defecto para que Storyline aparezca a la izquierda del personaje o marco de hechizo y quede relegado si otros marcos se abren.

El marco no puede ser movido si se utiliza la posición por defecto. Esta opción requiere una recarga de la interfaz.]=],
			["SL_CONFIG_USE_KEYBOARD"] = "Utilizar atajos de teclado",
			["SL_CONFIG_USE_KEYBOARD_TT"] = "Utiliza atajos del teclado para moverte por los diálogos (barra espaciadora para avanzar, retroceso para volver, teclas 1 al 0 para seleccionar una opción de diálogo)",
			["SL_CONFIG_WELCOME"] = [=[¡Gracias por usar Storyline!

Puedes seguir a los desarrolladores de Storyline en Twitter, |cff55acee@EllypseCelwe|r y |cff55acee@Telkostrasz|r para recibir noticias acerca del addon y adelantos de su desarrollo.]=],
			["SL_CONTINUE"] = "Completar misión",
			["SL_DECLINE"] = "Me niego",
			["SL_GET_REWARD"] = "Obtener recompensa",
			["SL_NEXT"] = "Continuar",
			["SL_NOT_YET"] = "Vuelve cuando hayas acabado",
			["SL_RESET"] = "Vuelve atrás",
			["SL_RESET_TT"] = "Vuelve atrás este dialogo",
			["SL_RESIZE"] = "Redimensionar",
			["SL_RESIZE_TT"] = "Arrastra y suelta para redimensionar",
			["SL_REWARD_MORE"] = "Además conseguirás",
			["SL_REWARD_MORE_SUB"] = [=[
Dinero: |cffffffff%s|r
Experiencia: |cffffffff%s exp|r

|cffffff00Clic:|r ¡Obtén tu recompensa!]=],
			["SL_SELECT_AVAILABLE_QUEST"] = "Selecciona una misión disponible",
			["SL_SELECT_DIALOG_OPTION"] = "Selecciona una opción de dialogo",
			["SL_SELECT_REWARD"] = "Selecciona tu recompensa",
			["SL_STORYLINE"] = "Storyline",
		}
		--@end-do-not-package@
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_DE
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	["deDE"] = {
		localeText = "Deutsch",
		localeContent =
		--@localization(locale="deDE", format="lua_table", handle-unlocalized="ignore")@
		--@do-not-package@
		{
			["SL_ACCEPTANCE"] = "Ich akzeptiere.",
			["SL_CHECK_OBJ"] = "Questziele überprüfen",
			["SL_CONFIG"] = "Einstellungen",
			["SL_CONFIG_AUTOEQUIP"] = "Belohnung automatisch anlegen",
			["SL_CONFIG_AUTOEQUIP_TT"] = "Belohnungen automatisch anlegen, falls sie eine bessere Gegenstandsstufe haben.",
			["SL_CONFIG_DEBUG"] = "Debugmodus",
			["SL_CONFIG_DEBUG_TT"] = "Aktiviere das Debugfenster, das Entwicklungsdaten unter dem Storyline-Fenster anzeigt",
			["SL_CONFIG_DIALOG_TEXT"] = "Dialogtext",
			["SL_CONFIG_DISABLE_IN_INSTANCES"] = "Storyline in Instanzen deaktivieren",
			["SL_CONFIG_FORCEGOSSIP"] = "Geschwätz immer anzeigen",
			["SL_CONFIG_FORCEGOSSIP_TT"] = "Geschwätz bei NSCs wie Händler und Flugmeister immer anzeigen.",
			["SL_CONFIG_HIDEORIGINALFRAMES"] = "Originalfenster verstecken",
			["SL_CONFIG_HIDEORIGINALFRAMES_TT"] = "Versteckt die Originalfenster (Quest- und NPC-Dialoge), sodass nur Storyline auf dem Bildschirm sichtbar ist.",
			["SL_CONFIG_LANGUAGE"] = "Sprache",
			["SL_CONFIG_LOCKFRAME"] = "Fenster fixieren",
			["SL_CONFIG_LOCKFRAME_TT"] = "Fixiert das Storyline-Fenster, sodass es nicht aus Versehen verschoben werden kann.",
			["SL_CONFIG_MISCELLANEOUS"] = "Sonstige Optionen",
			["SL_CONFIG_NEXT_ACTION"] = "Nächste Aktion",
			["SL_CONFIG_NPC_NAME"] = "NSC-Name",
			["SL_CONFIG_QUEST_TITLE"] = "Questtitel",
			["SL_CONFIG_TEXTSPEED"] = "%.1fx",
			["SL_CONFIG_TEXTSPEED_HIGH"] = "Hoch",
			["SL_CONFIG_TEXTSPEED_INSTANT"] = "Keine Animation.",
			["SL_CONFIG_TEXTSPEED_TITLE"] = "Textanimationsgeschwindigkeit",
			["SL_CONFIG_UI_LAYOUT_ENGINE"] = "Standardfensterposition verwenden",
			["SL_CONFIG_USE_KEYBOARD"] = "Tastaturkürzel verwenden",
			["SL_CONFIG_USE_KEYBOARD_TT"] = "Verwende Tastaturkürzel, um in Dialogen zu navigieren (Leertaste für weiter, Rücktaste für zurück, Tasten 1 bis 0 zum Auswählen einer Dialogoption)",
			["SL_CONFIG_WELCOME"] = [=[Danke, dass du Storyline verwendest!

Du kannst den Entwicklern von Storyline auf Twitter folgen |cff55acee@EllypseCelwe|r und |cff55acee@Telkostrasz|r, um Neuigkeiten und Einblicke zur Entwicklung dieses Add-Ons zu bekommen.]=],
			["SL_CONTINUE"] = "Quest abschließen",
			["SL_DECLINE"] = "Ich lehne ab.",
			["SL_GET_REWARD"] = "Erhaltet Eure Belohnung",
			["SL_NEXT"] = "Fortsetzen",
			["SL_NOT_YET"] = "Kehrt zurück, wenn es erledigt ist",
			["SL_RESET"] = "Zurückspulen",
			["SL_RESET_TT"] = "Spult diesen Dialog zurück.",
			["SL_RESIZE"] = "Größe ändern",
			["SL_RESIZE_TT"] = "Ziehen und loslassen, um die Größe zu ändern",
			["SL_REWARD_MORE"] = "Ihr bekommt außerdem",
			["SL_REWARD_MORE_SUB"] = [=[Geld: |cffffffff%s|r
Erfahrung: |cffffffff%s EP|r

|cffffff00Klick:|r Erhaltet Eure Belohnung!]=],
			["SL_SELECT_AVAILABLE_QUEST"] = "Verfügbare Quest wählen",
			["SL_SELECT_DIALOG_OPTION"] = "Dialogoption wählen",
			["SL_SELECT_REWARD"] = "Wählt Eure Belohnung",
			["SL_STORYLINE"] = "Storyline",
		}
		--@end-do-not-package@

	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_IT
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	["itIT"] = {
		localeText = "Italiano",
		localeContent =
		--@localization(locale="itIT", format="lua_table", handle-unlocalized="ignore")@
		--@do-not-package@
		{
			["SL_ACCEPTANCE"] = "Accetto.",
			["SL_CHECK_OBJ"] = "Controlla gli obiettivi",
			["SL_CONFIG"] = "Impostazioni",
			["SL_CONFIG_AUTOEQUIP"] = "Equipaggia automaticamente la ricompensa (sperimentale)",
			["SL_CONFIG_AUTOEQUIP_TT"] = "Equipaggia automaticamente la ricompensa se il LivOg è più alto",
			["SL_CONFIG_BIG_SAMPLE_TEXT"] = "Warcraft (traducibile come \"l'arte della guerra\") è una saga fantasy creata dall'azienda statunitense Blizzard Entertainment, iniziata nel 1993 con la pubblicazione del videogioco strategico in tempo reale Warcraft: Orcs & Humans. In seguito, oltre a videogiochi, sono stati prodotti romanzi, fumetti nonché giochi da tavolo e di carte collezionabili. L'ambientazione della serie che è stata via via sviluppata è nota come universo di Warcraft. Nella lista dei dieci giochi più importanti di tutti i tempi, stilata nel marzo 2007 da un comitato presieduto da Henry Lowood della Stanford University, è stata inclusa al nono posto l'intera serie di Warcraft.",
			["SL_CONFIG_DEBUG"] = "Modalità Debug",
			["SL_CONFIG_DEBUG_TT"] = "Attiva il riquadro per il Debug mostrando dati di sviluppo attraverso il riquadro di Storyline",
			["SL_CONFIG_DIALOG_TEXT"] = "Testo del dialogo",
			["SL_CONFIG_DISABLE_IN_INSTANCES"] = "Disattiva Storyline nelle Istanze",
			["SL_CONFIG_DISABLE_IN_INSTANCES_TT"] = "Disabilita in automatico Storyline quando ci si trova all'interno delle Istanze (Spedizioni, Campi di Battaglia, Incursioni, Scenari...)",
			["SL_CONFIG_FORCEGOSSIP"] = "Attiva i convenevoli",
			["SL_CONFIG_FORCEGOSSIP_TT"] = "Attiva i convenevoli per i PNG come Mercanti o Maestri di Volo.",
			["SL_CONFIG_HIDEORIGINALFRAMES"] = "Nascondi i riquadri predefiniti",
			["SL_CONFIG_HIDEORIGINALFRAMES_TT"] = "Nasconde i riquadri predefiniti di Missioni e dialoghi dei PNG.",
			["SL_CONFIG_LANGUAGE"] = "Lingua",
			["SL_CONFIG_LOCKFRAME"] = "Blocca",
			["SL_CONFIG_LOCKFRAME_TT"] = "Blocca il riquadro di Storyline così da evitare di spostarlo per errore.",
			["SL_CONFIG_MISCELLANEOUS"] = "Opzioni aggiuntive",
			["SL_CONFIG_NEXT_ACTION"] = "Azione successiva",
			["SL_CONFIG_NPC_NAME"] = "Nome del PNG",
			["SL_CONFIG_QUEST_TITLE"] = "Titolo della Missione",
			["SL_CONFIG_SAMPLE_TEXT"] = "Quel vituperabile xenofobo zelante assaggia il whisky ed esclama: alleluja!",
			["SL_CONFIG_STYLING_OPTIONS"] = "Configurazione del carattere",
			["SL_CONFIG_TEXTSPEED"] = "%.1fx",
			["SL_CONFIG_TEXTSPEED_HIGH"] = "Rapida",
			["SL_CONFIG_TEXTSPEED_INSTANT"] = "Nulla",
			["SL_CONFIG_TEXTSPEED_TITLE"] = "Velocità dell'animazione del testo",
			["SL_CONFIG_UI_LAYOUT_ENGINE"] = "Usa la posizione predefinita",
			["SL_CONFIG_UI_LAYOUT_ENGINE_TT"] = [=[Usa la posizione predefinita cosi che Storyline appaia sulla sinistra come il riquadro del Personaggio o del Grimorio, in modo che venga riposizionato quando un nuovo riquadro viene aperto.

Il riquadro non può essere mosso quando si utilizza la posizione predefinita e, abilitare questa opzione, richiede un riavvio dell'IU.]=],
			["SL_CONFIG_USE_KEYBOARD"] = "Usa le scorciatoie da tastiera",
			["SL_CONFIG_USE_KEYBOARD_TT"] = "Utilizza le scorciatoie da tastiera per muoverti all'interno dei dialoghi (Barra spaziatrice per avanzare, Backspace per tornare indietro e i pulsanti da 1 a 0 per selezionare la scelta nei dialoghi)",
			["SL_CONFIG_WELCOME"] = [=[Grazie per aver scelto Storyline!

È possibile seguire gli sviluppatori di Storyline su Twitter |cff55acee@EllypseCelwe|r e |cff55acee@Telkostrasz|r per avere notizie sull'addon e anticipazioni riguardo il suo sviluppo.
]=],
			["SL_CONTINUE"] = "Completa la Missione",
			["SL_DECLINE"] = "Declino.",
			["SL_GET_REWARD"] = "Ricompensa guadagnata",
			["SL_NEXT"] = "Continua",
			["SL_NOT_YET"] = "Ritorna quando avrai concluso.",
			["SL_RESET"] = "Riavvolgi",
			["SL_RESET_TT"] = "Riavvolgi questo dialogo.",
			["SL_RESIZE"] = "Ridimensiona",
			["SL_RESIZE_TT"] = "Trascina e rilascia per ridimensionare",
			["SL_REWARD_MORE"] = "Si otterrà anche",
			["SL_REWARD_MORE_SUB"] = [=[
Denaro: |cffffffff%s|r
Esperienza: |cffffffff%s xp|r

|cffffff00Click:|r Prendi la tua ricompensa!]=],
			["SL_SELECT_AVAILABLE_QUEST"] = "Seleziona la Missione disponibile",
			["SL_SELECT_DIALOG_OPTION"] = "Seleziona un'opzione del dialogo",
			["SL_SELECT_REWARD"] = "Scegli la tua ricompensa",
			["SL_STORYLINE"] = "Storyline",
		}
		--@end-do-not-package@

	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_RU
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*


	["ruRU"] = {
		localeText = "Russian",
		localeContent =
		--@localization(locale="ruRU", format="lua_table", handle-unlocalized="ignore")@
		--@do-not-package@
		{
			["SL_ACCEPTANCE"] = "Принимаю",
			["SL_CHECK_OBJ"] = "Показать цель задания",
			["SL_CONFIG"] = "Параметры",
			["SL_CONFIG_AUTOEQUIP"] = "Автоматически экипировать награды (Экспериментальная функция)",
			["SL_CONFIG_AUTOEQUIP_TT"] = "Автоматически экипировать награду, если она имеет более высокий уровень предмета.",
			["SL_CONFIG_BIG_SAMPLE_TEXT"] = "Когда я переводил эту строчку, со мной связались представители одной крупной компании, предложив разместить здесь рекламу. Деньги были неплохие, но я отказался. Ведь, есть вещи, которые не продаются... А для всего остального есть мастеркард! Ведь мастеркард, это мировая система, объединяющая более 22 тысяч компаний в 210 странах мира! Это самые удобные сервисы и гарантия безопасности ваших денег!",
			["SL_CONFIG_DEBUG"] = "Режим отладки",
			["SL_CONFIG_DEBUG_TT"] = "Включить отладочный фрейм, отображающий информацию для разработчиков под фреймом Storyline",
			["SL_CONFIG_DIALOG_TEXT"] = "Текст диалога",
			["SL_CONFIG_DISABLE_IN_INSTANCES"] = "Скрывать Storylline в инстансах",
			["SL_CONFIG_DISABLE_IN_INSTANCES_TT"] = "Автоматически скрывать Storyline внутри инстансов (подземельях, полях битв, рейдах, сценариях...) ",
			["SL_CONFIG_FORCEGOSSIP"] = "Включить диалоги НИП.",
			["SL_CONFIG_FORCEGOSSIP_TT"] = "Включает диалоги с некоторыми НИП, такими как торговцы и укротители грифонов, при взаимодействии с ними.",
			["SL_CONFIG_HIDEORIGINALFRAMES"] = "Скрыть стандартные окна",
			["SL_CONFIG_HIDEORIGINALFRAMES_TT"] = "Скрыть оригинальные квестовые и диалоговые окна.",
			["SL_CONFIG_LANGUAGE"] = "Язык",
			["SL_CONFIG_LOCKFRAME"] = "Закрепить окно",
			["SL_CONFIG_LOCKFRAME_TT"] = "Зафиксировать окно Storyline, чтобы его нельзя было сдвинуть по ошибке.",
			["SL_CONFIG_MISCELLANEOUS"] = "Прочие опции",
			["SL_CONFIG_NEXT_ACTION"] = "Далее",
			["SL_CONFIG_NPC_NAME"] = "Имя НИП",
			["SL_CONFIG_QUEST_TITLE"] = "Название задания",
			["SL_CONFIG_SAMPLE_TEXT"] = "Съешь же ещё этих мягких французских булок, да выпей чаю.",
			["SL_CONFIG_STYLING_OPTIONS"] = "Настройки отображения",
			["SL_CONFIG_TEXTSPEED"] = "%.1fx",
			["SL_CONFIG_TEXTSPEED_HIGH"] = "Высокая",
			["SL_CONFIG_TEXTSPEED_INSTANT"] = "Без анимации",
			["SL_CONFIG_TEXTSPEED_TITLE"] = "Скорость анимации текста",
			["SL_CONFIG_UI_LAYOUT_ENGINE"] = "Использовать стандартное местоположение окна",
			["SL_CONFIG_UI_LAYOUT_ENGINE_TT"] = [=[Использовать стандартное расположение, Storyline появится слева, подобно окну персонажа или заклинаний и будет сдвигаться, если новые окна будут открыты.

Окно нельзя передвигать когда используется стандартное расположение. Использование данной настройки требует перезагрузки интерфейса..]=],
			["SL_CONFIG_USE_KEYBOARD"] = "Использовать горячие клавиши",
			["SL_CONFIG_USE_KEYBOARD_TT"] = "Использовать горячие клавиши во время диалогов. Пробел - далее. Backspace - назад. Кнопки от 1 до 0 - выбор варианта.",
			["SL_CONFIG_WELCOME"] = [=[Спасибо за использование Storyline!

Вы можете подписаться на разработчиков Storyline в Twitter |cff55acee@EllypseCelwe|r и |cff55acee@Telkostrasz|r чтобы получать свежие новости об аддоне и ходе его разработки.]=],
			["SL_CONTINUE"] = "Завершить задание",
			["SL_DECLINE"] = "Отказываюсь",
			["SL_GET_REWARD"] = "Получить награду",
			["SL_NEXT"] = "Продолжить",
			["SL_NOT_YET"] = "Возвращайся, когда закончишь",
			["SL_RESET"] = "Вернуться назад",
			["SL_RESET_TT"] = "Повторить диалог",
			["SL_RESIZE"] = "Размер окна",
			["SL_RESIZE_TT"] = "Потяните, чтобы изменить размер окна",
			["SL_REWARD_MORE"] = "Вы также получите",
			["SL_REWARD_MORE_SUB"] = [=[Деньги: |cffffffff%s|r
Опыт: |cffffffff%s xp|r

|cffffff00Click:|r Получите свою награду!]=],
			["SL_SELECT_AVAILABLE_QUEST"] = "Выберите доступное задание",
			["SL_SELECT_DIALOG_OPTION"] = "Выберите вариант ответа",
			["SL_SELECT_REWARD"] = "Выберите награду",
			["SL_STORYLINE"] = "Storyline",
		}
		--@end-do-not-package@
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_ZHTW
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*


	["zhTW"] = {
		localeText = "Traditional Chinese",
		localeContent =
		--@localization(locale="zhTW", format="lua_table", handle-unlocalized="ignore")@
		--@do-not-package@
		{
			["SL_ACCEPTANCE"] = "我接受。",
			["SL_CHECK_OBJ"] = "任務目標是...",
			["SL_CONFIG"] = "設定",
			["SL_CONFIG_AUTOEQUIP"] = "自動裝備獎勵物品 (實驗性功能)",
			["SL_CONFIG_AUTOEQUIP_TT"] = "當物品等級較高時，自動裝備獎勵。",
			["SL_CONFIG_BIG_SAMPLE_TEXT"] = "在魔獸世界還在內部測試的時候，遊戲裡曾有許多有待修正的bug，其中有個bug是，在大陸間航行的船隻有時會莫名失效，於是暴雪設置了幾個NPC，讓玩家直接傳送到另一個大陸，其中的一個NPC則深受玩家喜愛，普萊斯霍德船長(暫定船長)，暫定船長究竟有多受歡迎呢? 玩家甚至特意為這個NPC做了詞曲，在bug修正後，暫定船長就被移除了。不過，在魔獸正式上線後，這bug又出現了，暴雪只能再把暫定船長搬了出來，玩家深愛上了船長，於是當暴雪移除這個NPC時。玩家哭著鬧著吼著吵著，要求暴雪把船長送回來。於是在大災變裡，暴雪又將NPC放進遊戲，是一個85級的精英部落陣營NPC，不過這NPC沒有達到預期效果，模型也改過了，反正，已經不是當年那個船長了。但是，暫定船長會永遠地活在我們心裡。",
			["SL_CONFIG_DEBUG"] = "除錯模式",
			["SL_CONFIG_DEBUG_TT"] = "啟用除錯框架，在任務故事劇情視窗下方顯示開發資訊。",
			["SL_CONFIG_DIALOG_TEXT"] = "對話文字",
			["SL_CONFIG_DISABLE_IN_INSTANCES"] = "副本中停用任務故事劇情",
			["SL_CONFIG_DISABLE_IN_INSTANCES_TT"] = "在副本 (地城、戰場、團隊、事件) 時自動停用任務故事劇情",
			["SL_CONFIG_FORCEGOSSIP"] = "顯示閒聊文字",
			["SL_CONFIG_FORCEGOSSIP_TT"] = "顯示NPC的閒聊文字，例如商人或飛行管理員。",
			["SL_CONFIG_HIDEORIGINALFRAMES"] = "隱藏遊戲原本的對話視窗",
			["SL_CONFIG_HIDEORIGINALFRAMES_TT"] = "隱藏原始的任務框架和NPC對話視窗。",
			["SL_CONFIG_LANGUAGE"] = "語言",
			["SL_CONFIG_LOCKFRAME"] = "鎖定視窗",
			["SL_CONFIG_LOCKFRAME_TT"] = "鎖定任務故事情節視窗，避免不小心移動。",
			["SL_CONFIG_MISCELLANEOUS"] = "其他選項",
			["SL_CONFIG_NEXT_ACTION"] = "下一步動作",
			["SL_CONFIG_NPC_NAME"] = "NPC 名字",
			["SL_CONFIG_QUEST_TITLE"] = "任務標題",
			["SL_CONFIG_SAMPLE_TEXT"] = "暗影聚兮，黑鴉噬日。 天火盡兮，玄翼蔽空。吾雛吾民，歇兮憩兮；斯是殘陽，終有眠期。",
			["SL_CONFIG_STYLING_OPTIONS"] = "樣式選項",
			["SL_CONFIG_TEXTSPEED"] = "%.1fx",
			["SL_CONFIG_TEXTSPEED_HIGH"] = "快速",
			["SL_CONFIG_TEXTSPEED_INSTANT"] = "無動畫",
			["SL_CONFIG_TEXTSPEED_TITLE"] = "文字動畫速度",
			["SL_CONFIG_UI_LAYOUT_ENGINE"] = "使用預設的視窗排列位置",
			["SL_CONFIG_UI_LAYOUT_ENGINE_TT"] = [=[使用遊戲預設的視窗排列方式，任務故事劇情會顯示在角色資訊或法術書的左側，當新視窗開啟時會被推往旁邊。

使用預設位置時無法移動視窗。需要重新載入介面才會生效。]=],
			["SL_CONFIG_USE_KEYBOARD"] = "使用鍵盤快速鍵",
			["SL_CONFIG_USE_KEYBOARD_TT"] = "使用鍵盤快速鍵導覽對話 (空白鍵往前，倒退鍵往後，按鍵 1 到 0 選擇對話內容，右鍵點擊或Shift+空白鍵快速顯示整段對話。)",
			["SL_CONFIG_WELCOME"] = "感謝使用任務故事劇情 Storyline!",
			["SL_CONTINUE"] = "完成任務",
			["SL_DECLINE"] = "我拒絕。",
			["SL_GET_REWARD"] = "取得你的獎勵",
			["SL_NEXT"] = "繼續",
			["SL_NOT_YET"] = "完成後再來",
			["SL_RESET"] = "回顧內容",
			["SL_RESET_TT"] = "回顧對話內容。",
			["SL_RESIZE"] = "調整大小",
			["SL_RESIZE_TT"] = "拖曳滑鼠來調整大小。",
			["SL_REWARD_MORE"] = "還可以獲得",
			["SL_REWARD_MORE_SUB"] = [=[
金錢: |cffffffff%s|r
經驗值: |cffffffff%s xp|r

|cffffff00點一下:|r 取得你的獎勵!]=],
			["SL_SELECT_AVAILABLE_QUEST"] = "選擇任務",
			["SL_SELECT_DIALOG_OPTION"] = "選擇對話內容",
			["SL_SELECT_REWARD"] = "選擇你的獎勵",
			["SL_STORYLINE"] = "任務故事劇情",
		}
		--@end-do-not-package@
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_koKR
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*


	["koKR"] = {
		localeText = "Korean",
		localeContent =
		--@localization(locale="koKR", format="lua_table", handle-unlocalized="ignore")@
		--@do-not-package@
		{
			["SL_ACCEPTANCE"] = "알겠습니다.",
			["SL_CHECK_OBJ"] = "임무 확인하기",
			["SL_CONFIG"] = "설정",
			["SL_CONFIG_AUTOEQUIP"] = "자동으로 보상 착용 (시험중)",
			["SL_CONFIG_AUTOEQUIP_TT"] = "보상 아이템의 아이템 레벨이 기존 아이템보다 높을 경우 자동으로 착용합니다.",
			["SL_CONFIG_BIG_SAMPLE_TEXT"] = "저는 등산을 좋아해서 매주마다 산에 오르곤 합니다. 언제나처럼 산길을 열심히 올라가는데 도인처럼 보이는 어느 행인이 어깨에 웬 새를 얹혀놓고 걸어가고 있더군요. 신기한 김에 \"선생님, 그 어깨에 얹혀놓은 새 이름이 뭔가요?\" 하고 물어 보았습니다. 제 말을 들은 그분께서 어깨를 보고는 말하시길, \"앗 깜짝이야 뭐야 이거\"",
			["SL_CONFIG_DEBUG"] = "디버그 모드",
			["SL_CONFIG_DEBUG_TT"] = "스토리라인 창 아래에 디버그 창을 보이게 합니다.",
			["SL_CONFIG_DIALOG_TEXT"] = "대화 본문",
			["SL_CONFIG_DISABLE_IN_INSTANCES"] = "인스턴스에서 스토리라인 비활성화",
			["SL_CONFIG_DISABLE_IN_INSTANCES_TT"] = "인스턴스에 들어가면 자동으로 스토리라인을 비활성화 합니다. (던전, 전장, 레이드, 시나리오 등...)",
			["SL_CONFIG_FORCEGOSSIP"] = "상관없는 대화 보여주기",
			["SL_CONFIG_FORCEGOSSIP_TT"] = "퀘스트가 없는 상인이나 비행 전문가의 대화 구문도 보이게 합니다.",
			["SL_CONFIG_HIDEORIGINALFRAMES"] = "기존 창 숨기기",
			["SL_CONFIG_HIDEORIGINALFRAMES_TT"] = "기존의 퀘스트 창을 숨깁니다.",
			["SL_CONFIG_LANGUAGE"] = "언어",
			["SL_CONFIG_LOCKFRAME"] = "창 잠그기",
			["SL_CONFIG_LOCKFRAME_TT"] = "실수로 움직여지지 않게 퀘스트라인 창을 잠급니다.",
			["SL_CONFIG_MISCELLANEOUS"] = "그 외의 설정",
			["SL_CONFIG_NEXT_ACTION"] = "다음 행동",
			["SL_CONFIG_NPC_NAME"] = "NPC 이름",
			["SL_CONFIG_QUEST_TITLE"] = "퀘스트 이름",
			["SL_CONFIG_SAMPLE_TEXT"] = "다람쥐 헌 쳇바퀴에 타고파",
			["SL_CONFIG_STYLING_OPTIONS"] = "꾸미기 설정",
			["SL_CONFIG_TEXTSPEED"] = "%.1fx",
			["SL_CONFIG_TEXTSPEED_HIGH"] = "빠르게",
			["SL_CONFIG_TEXTSPEED_INSTANT"] = "애니메이션 없음",
			["SL_CONFIG_TEXTSPEED_TITLE"] = "글이 나타나는 속도",
			["SL_CONFIG_UI_LAYOUT_ENGINE"] = "고정된 창 위치 사용",
			["SL_CONFIG_UI_LAYOUT_ENGINE_TT"] = [=[기존 퀘스트 창처럼 스토리라인이 캐릭터 혹은 스킬 창을 오른쪽으로 밀어냅니다.

창이 고정된 위치에서 움직일 수 없게 됩니다. 이 옵션을 체크하면 UI를 재시작합니다.]=],
			["SL_CONFIG_USE_KEYBOARD"] = "단축키 사용",
			["SL_CONFIG_USE_KEYBOARD_TT"] = "대화를 넘기는 데에도 단축키를 사용합니다(스페이스바는 다음으로, 백스페이스는 뒤로, 1부터 0까지의 숫자 키는 다중 선택지 고르기).",
			["SL_CONFIG_WELCOME"] = [=[스토리라인을 이용해 주셔서 감사합니다!

스토리라인 제작진의 트위터, |cff55acee@EllypseCelwe|r 와 |cff55acee@Telkostrasz|r를 팔로우하시고 스토리라인의 새로운 소식을 알아보세요.
]=],
			["SL_CONTINUE"] = "퀘스트 완료",
			["SL_DECLINE"] = "거절하겠습니다.",
			["SL_GET_REWARD"] = "보상 획득하기",
			["SL_NEXT"] = "다음으로",
			["SL_NOT_YET"] = "일을 마치고 돌아오겠습니다.",
			["SL_RESET"] = "다시 보기",
			["SL_RESET_TT"] = "이 대화를 처음부터 다시 봅니다.",
			["SL_RESIZE"] = "크기 조정",
			["SL_RESIZE_TT"] = "끌었다 놓으면 창의 크기를 바꿀 수 있습니다.",
			["SL_REWARD_MORE"] = "당신이 얻을 보상은",
			["SL_REWARD_MORE_SUB"] = "\\n돈: |cffffffff%s|r\\n경험치: |cffffffff%s xp|r\\n\\n|cffffff00눌러서|r 수령하세요!",
			["SL_SELECT_AVAILABLE_QUEST"] = "수행할 임무 선택",
			["SL_SELECT_DIALOG_OPTION"] = "할 일 선택",
			["SL_SELECT_REWARD"] = "보상을 선택하십시오",
			["SL_STORYLINE"] = "스토리라인",
		}
		--@end-do-not-package@

	},


	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_ptBR
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	["ptBR"] = {
		localeText = "Brazilian Portuguese",
		localeContent =
		--@localization(locale="ptBR", format="lua_table", handle-unlocalized="ignore")@
		--@do-not-package@
		{
			["SL_ACCEPTANCE"] = "Aceito.",
			["SL_CHECK_OBJ"] = "Checar objetivos.",
			["SL_CONFIG"] = "Configurações.",
			["SL_CONFIG_AUTOEQUIP"] = "Auto equipar recompensa (experimental)",
			["SL_CONFIG_AUTOEQUIP_TT"] = "Auto equipar recompensa se o item for melhor.",
			["SL_CONFIG_BIG_SAMPLE_TEXT"] = "Por muito tempo achei que a ausência é falta. E lastimava, ignorante, a falta. Hoje não a lastimo. Não há falta na ausência. A ausência é um estar em mim. E sinto-a, branca, tão pegada, aconchegada nos meus braços, que rio e danço e invento exclamações alegres, porque a ausência, essa ausência assimilada, ninguém a rouba mais de mim.",
			["SL_CONFIG_DEBUG"] = "Modo de depuração",
			["SL_CONFIG_DEBUG_TT"] = "Ativar a interface de depuração mostrando dados de desenvolvedor na interface do Storyline",
			["SL_CONFIG_DIALOG_TEXT"] = "Texto de diálogo",
			["SL_CONFIG_DISABLE_IN_INSTANCES"] = "Desativar o Storyline em instâncias",
			["SL_CONFIG_DISABLE_IN_INSTANCES_TT"] = "Automaticamente desativa o Storyline quando você estiver em instâncias (masmorras, campos de batalha, raides, cenários)",
			["SL_CONFIG_FORCEGOSSIP"] = "Mostrar textos temáticos",
			["SL_CONFIG_FORCEGOSSIP_TT"] = "Mostrar textos temáticos em PNJs como mercadores ou mestres de vôo.",
			["SL_CONFIG_HIDEORIGINALFRAMES"] = "Esconder interface original",
			["SL_CONFIG_HIDEORIGINALFRAMES_TT"] = "Esconder a interface de missões original e o quadro de diálogo de PNJ.",
			["SL_CONFIG_LANGUAGE"] = "Idioma",
			["SL_CONFIG_LOCKFRAME"] = "Travar interface",
			["SL_CONFIG_LOCKFRAME_TT"] = "Travar a interface do Storyline para que não seja movida acidentalmente.",
			["SL_CONFIG_MISCELLANEOUS"] = "Opções diversas",
			["SL_CONFIG_NEXT_ACTION"] = "Próxima ação",
			["SL_CONFIG_NPC_NAME"] = "Nome do NPC",
			["SL_CONFIG_QUEST_TITLE"] = "Título da missão",
			["SL_CONFIG_SAMPLE_TEXT"] = "Um pequeno jabuti xereta viu dez cegonhas felizes.",
			["SL_CONFIG_STYLING_OPTIONS"] = "Opções de estilo",
			["SL_CONFIG_TEXTSPEED"] = "%.1fx",
			["SL_CONFIG_TEXTSPEED_HIGH"] = "Rápido",
			["SL_CONFIG_TEXTSPEED_INSTANT"] = "Sem animação",
			["SL_CONFIG_TEXTSPEED_TITLE"] = "Velocidade de animação",
			["SL_CONFIG_UI_LAYOUT_ENGINE"] = "Usar a posição padrão da janela",
			["SL_CONFIG_UI_LAYOUT_ENGINE_TT"] = "Usa o leiate padrão para que o Storyline apareça na esquerda como a janela do personagem ou a janela dos feitiços e seja empurrada se novas janelas forem abertas",
			["SL_CONFIG_USE_KEYBOARD"] = "Usar atalhos de teclado",
			["SL_CONFIG_USE_KEYBOARD_TT"] = "Usar atalhos no teclado para navegar nos diálogos (espaço para avançar, backspace para voltar, teclas de 1 a 0 para selecionar opções de diálogo)",
			["SL_CONFIG_WELCOME"] = [=[Obrigado por utilizar o Storyline!

Você pode seguir os desenvolvedores no Twitter |cff55acee@EllypseCelwe|r e |cff55acee@Telkostrasz|r para receber atualizações sobre o add-on e prévias do desenvolvimento.]=],
			["SL_CONTINUE"] = "Completar missão",
			["SL_DECLINE"] = "Me recuso.",
			["SL_GET_REWARD"] = "Receber recompensa",
			["SL_NEXT"] = "Continuar",
			["SL_NOT_YET"] = "Volte quando estiver pronto",
			["SL_RESET"] = "Retroceder",
			["SL_RESET_TT"] = "Retroceder esse diálogo",
			["SL_RESIZE"] = "Redimensionar",
			["SL_RESIZE_TT"] = "Arraste para redimensionar",
			["SL_REWARD_MORE"] = "Você também receberá",
			["SL_REWARD_MORE_SUB"] = [=[Moeda: |cffffffff%s|r
Experiência: |cffffffff%s|r

|cffffff00Clique:|r Receba sua recompensa!]=],
			["SL_SELECT_AVAILABLE_QUEST"] = "Selecione uma missão",
			["SL_SELECT_DIALOG_OPTION"] = "Selecione a opção de diálogo",
			["SL_SELECT_REWARD"] = "Escolha a recompensa",
			["SL_STORYLINE"] = "Enredo",
		}
		--@end-do-not-package@

	},
}

local error, tostring = error, tostring;

local LOCALS = Storyline_API.locale.info;
local DEFAULT_LOCALE = "enUS";
Storyline_API.locale.DEFAULT_LOCALE = DEFAULT_LOCALE;
local effectiveLocal = {};
local localeFont;
local current;

-- Initialize a locale for the addon.
function Storyline_API.locale.init()
	-- Register config

	current = Storyline_Data.config.locale or GetLocale();
	if not LOCALS[current] then
		current = DEFAULT_LOCALE;
	end
	-- Pick the right font
	if current == "zhCN" then
		localeFont = "Fonts\\ARKai_T.TTF";
	elseif current == "zhTW" then
		localeFont = "Fonts\\bLEI00D.TTF";
	elseif current == "ruRU" then
		localeFont = "Fonts\\FRIZQT___CYR.TTF";
	elseif current == "koKR" then
		localeFont = "Fonts\\2002.TTF";
	else
		localeFont = "Fonts\\FRIZQT__.TTF";
	end
	effectiveLocal = LOCALS[current].localeContent;

	Storyline_Data.config.locale = current;
	Storyline_API.locale.localeFont = localeFont;
end

--	Return the localized text link to this key.
--	If the key isn't present in the current Locals table, then return the default localization.
--	If the key is totally unknown from TRP3, then an error will be lifted.
local function getText(key)
	if effectiveLocal[key] or LOCALS[DEFAULT_LOCALE].localeContent[key] then
		return effectiveLocal[key] or LOCALS[DEFAULT_LOCALE].localeContent[key];
	end
	error("Unknown localization key: ".. tostring(key));
end
Storyline_API.locale.getText = getText;

function Storyline_API.locale.getLocales()
	return Storyline_API.locale.info;
end