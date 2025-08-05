# Custom App Drawer

Un package Flutter riutilizzabile che fornisce un app drawer personalizzabile e elegante, compatibile con Material Design 3.

## Features

- 🎨 **Completamente personalizzabile**: Configura colori, gradient, stili di testo e contenuti
- 📱 **Material Design 3**: Compatibile con le ultime linee guida di design di Material
- 🔧 **Facile da integrare**: Semplice da aggiungere a qualsiasi progetto Flutter esistente
- 🎯 **Type-safe**: Configurazione type-safe con classi di configurazione dedicate
- 🌟 **Header personalizzabile**: Supporta header completamente personalizzabili
- 📋 **Elementi configurabili**: Aggiungi, rimuovi e personalizza facilmente gli elementi del menu

## Installazione

### Da GitHub

Aggiungi questa dipendenza al tuo `pubspec.yaml`:

```yaml
dependencies:
  custom_app_drawer:
    git:
      url: https://github.com/davideloddeDev/flutter-appDrawer.git
      ref: main
```

Poi esegui:

```bash
flutter pub get
```

## Utilizzo di base

### Importazione

```dart
import 'package:custom_app_drawer/custom_app_drawer.dart';
```

### Utilizzo con variabili pubbliche (Raccomandato)

Il Custom App Drawer è progettato per essere completamente configurabile dall'esterno. Tutti i dati devono essere gestiti nel progetto principale:

```dart
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Tutte le variabili sono gestite qui nel progetto principale
  String userName = 'Mario Rossi';
  String userEmail = 'mario.rossi@email.com';
  int notificationCount = 5;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppDrawer(
        config: DrawerConfig(
          userName: userName,
          userEmail: userEmail,
          headerGradient: LinearGradient(
            colors: isDarkMode 
              ? [Colors.grey[800]!, Colors.grey[600]!]
              : [Colors.blue, Colors.blueAccent],
          ),
          items: [
            DrawerItemConfig(
              icon: Icons.home,
              title: 'Home',
              onTap: () {
                Navigator.pop(context);
                // La tua logica qui
              },
            ),
            DrawerItemConfig(
              icon: Icons.notifications,
              title: 'Notifiche',
              trailing: notificationCount > 0
                ? Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$notificationCount',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                : null,
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  notificationCount = 0; // Aggiorna la variabile locale
                });
              },
            ),
            DrawerItemConfig(
              icon: isDarkMode ? Icons.light_mode : Icons.dark_mode,
              title: isDarkMode ? 'Modalità Chiara' : 'Modalità Scura',
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  isDarkMode = !isDarkMode; // Toggle tema
                });
              },
            ),
          ],
        ),
      ),
      // resto del tuo Scaffold...
    );
  }
}
```

### Utilizzo semplice

```dart
Scaffold(
  appBar: AppBar(title: Text('La mia App')),
  drawer: CustomAppDrawer(),
  body: // Il tuo contenuto
)
```

### Utilizzo avanzato con configurazione

```dart
Scaffold(
  appBar: AppBar(title: Text('La mia App')),
  drawer: CustomAppDrawer(
    config: DrawerConfig(
      userName: 'Mario Rossi',
      userEmail: 'mario.rossi@email.com',
      headerBackgroundColor: Colors.blue,
      items: [
        DrawerItemConfig(
          icon: Icons.home,
          title: 'Home',
          onTap: () {
            Navigator.pop(context);
            // La tua logica qui
          },
        ),
        DrawerItemConfig(
          icon: Icons.settings,
          title: 'Impostazioni',
          onTap: () => Navigator.pushNamed(context, '/settings'),
        ),
        DrawerItemConfig.divider(), // Aggiunge un divider
        DrawerItemConfig(
          icon: Icons.logout,
          title: 'Logout',
          onTap: () => _handleLogout(),
        ),
      ],
    ),
  ),
  body: // Il tuo contenuto
)
```

## Configurazione

### DrawerConfig

La classe `DrawerConfig` permette di personalizzare completamente l'aspetto e il comportamento del drawer:

```dart
DrawerConfig(
  userName: 'Nome Utente',              // Nome mostrato nell'header
  userEmail: 'email@esempio.com',       // Email mostrata nell'header
  userAvatarUrl: 'https://...',         // URL dell'immagine profilo
  customHeader: Widget(),               // Header completamente personalizzato
  headerBackgroundColor: Colors.blue,   // Colore di sfondo dell'header
  headerGradient: LinearGradient(...),  // Gradient personalizzato per l'header
  userNameStyle: TextStyle(...),        // Stile del testo del nome
  userEmailStyle: TextStyle(...),       // Stile del testo dell'email
  items: [                              // Lista degli elementi del menu
    // I tuoi elementi qui
  ],
)
```

### DrawerItemConfig

Ogni elemento del menu può essere configurato usando `DrawerItemConfig`:

```dart
DrawerItemConfig(
  icon: Icons.home,           // Icona dell'elemento
  title: 'Home',              // Testo dell'elemento
  onTap: () {                 // Azione quando l'elemento viene toccato
    // La tua logica qui
  },
  trailing: Icon(Icons.new),  // Widget opzionale a destra (badge, icone, etc.)
)
```

Per aggiungere un divider:

```dart
DrawerItemConfig.divider()
```

## Esempi

### Header personalizzato

```dart
DrawerConfig(
  customHeader: Container(
    height: 200,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple, Colors.blue],
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 40, child: Icon(Icons.person)),
          SizedBox(height: 10),
          Text('La mia app', style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    ),
  ),
  items: [...],
)
```

### Elementi con badge

```dart
DrawerItemConfig(
  icon: Icons.notifications,
  title: 'Notifiche',
  trailing: Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text('3', style: TextStyle(color: Colors.white, fontSize: 12)),
  ),
  onTap: () => Navigator.pushNamed(context, '/notifications'),
)
```

### Gestione della navigazione

```dart
DrawerItemConfig(
  icon: Icons.settings,
  title: 'Impostazioni',
  onTap: () {
    Navigator.pop(context); // Chiudi il drawer
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  },
)
```

## Personalizzazione avanzata

### Gradient personalizzato per l'header

```dart
DrawerConfig(
  headerGradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.deepPurple,
      Colors.purple,
      Colors.purpleAccent,
    ],
  ),
  // altri parametri...
)
```

### Stili di testo personalizzati

```dart
DrawerConfig(
  userNameStyle: TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  ),
  userEmailStyle: TextStyle(
    color: Colors.white70,
    fontSize: 14,
    fontStyle: FontStyle.italic,
  ),
  // altri parametri...
)
```

## Compatibilità

- Flutter SDK: >=3.0.0
- Dart: >=3.0.0

## Contribuire

I contributi sono benvenuti! Per favore:

1. Fai un fork del repository
2. Crea un branch per la tua feature (`git checkout -b feature/amazing-feature`)
3. Committa le tue modifiche (`git commit -m 'Add some amazing feature'`)
4. Pusha il branch (`git push origin feature/amazing-feature`)
5. Apri una Pull Request

## Licenza

Questo progetto è sotto licenza MIT - vedi il file [LICENSE](LICENSE) per i dettagli.

## Changelog

### 1.0.0
- Release iniziale
- Supporto per configurazione completa del drawer
- Header personalizzabile
- Elementi del menu configurabili
- Supporto per divider
- Compatibilità Material Design 3
