# Bluetooth Chat App

De Bluetooth Chat App is een Flutter applicatie waarmee gebruikers met elkaar kunnen chatten. De app maakt gebruik van Bluetooth waardoor 2 mobiele telefoons met elkaar kunnen verbinden om berichten uit te wisselen.

## Installatie

1. **Clone de repository naar je machine:**
   git clone [https://github.com/brentvanmalsen/bluetooth-chat.git]

2. **Open het project:**
   Open het project in een IDE, zoals VS Code, Xcode, of Android Studio.

3. **Installeer dependencies:**
   Zorg ervoor dat je de benodigde dependencies hebt geïntsalleerd door het volgende commando uit te voeren in de terminal: `flutter pub get`
   
4. **Run de app:**
   Nadat alle dependencies up-to-date zijn kun je de app runnen (uitvoeren) op een simulator of fysiek apparaat, zowel Android als IOS 

## Pubspec.yaml

- `all_bluetooth`: Deze package geeft de functionaliteit om Bluetooth verbindingen te beheren.  
- `permission_handler`: Om toestemming te vragen voor het mogen gebruiken van de Bluetooth.  
- `flutter_chat_bubble`: Om gemakkelijk widgets te gebruiken voor het maken van een chat interface.

## Functionaliteiten

- Bluetooth verbinding: Er kan een verbinding gemaakt worden met andere mobiele apparaten via Bluetooth.  
- Chatinterface: De app heeft een chatinterface waarin je berichten kunt typen en vezenden naar gekoppelde apparaten.
- Vragen om toestemming: Bij het openen van de app wordt er om toestemming gevraagd voor het gebruiken van Bluetooth.
- Statuscontrole: In de app kun je zien of dat de Bluetooth is ingeschakeld op het apparaat

## Bestandsstructuur

- `home_screen.dart`: Dit is de startpagina van de app. Op dit scherm staan knoppen om verbinding te maken met een ander apparaat via Bluetooth en om de Bluetooth server te starten.  
- `chat_screen.dart`: De interface om chats te versturen en te ontvangen tussen de verbonden apparaten.  
- `main.dart`: Deze pagina luistert naar een verbinding en bepaald of dat de Home pagina of de Chat pagina weergegeven moet worden.
- `message.dart`: Hier wordt aangegeven of dat het bericht wat binnenkomt of verstuurd wordt van jezelf is of niet.

## Opmerkingen

- De app controleert alleen of dat de Bluetooth is ingeschakeld, op het fysieke apparaat is het nodig om 'Bluetooth scanning' aan te zetten.
- Wanneer je voor de eerste keer verbinding maakt moet je de Bluetooth server knop gebruiken op apparaat 1, om met apparaat 2 verbinding te kunnen maken. Wanneer dit gedaan is hoef je alleen maar gebruik te maken van 'Verbonden apparaten'.

## Gemaakt door

Brent van Malsen.  


