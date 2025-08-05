import 'package:flutter/material.dart';
import 'package:custom_app_drawer/custom_app_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Custom App Drawer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Test Custom App Drawer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _notificationCount = 5;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: CustomAppDrawer(
        config: DrawerConfig(
          userName: 'Mario Rossi',
          userEmail: 'mario.rossi@test.com',
          headerGradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple, Colors.purple, Colors.purpleAccent],
          ),
          items: [
            DrawerItemConfig(
              icon: Icons.home,
              title: 'Home',
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Home selezionata');
              },
            ),
            DrawerItemConfig(
              icon: Icons.dashboard,
              title: 'Dashboard',
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Dashboard selezionata');
              },
            ),
            DrawerItemConfig(
              icon: Icons.person,
              title: 'Profilo',
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Profilo selezionato');
              },
            ),
            DrawerItemConfig(
              icon: Icons.notifications,
              title: 'Notifiche',
              trailing:
                  _notificationCount > 0
                      ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$_notificationCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                      : null,
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _notificationCount = 0;
                });
                _showSnackBar('Notifiche lette!');
              },
            ),
            DrawerItemConfig(
              icon: Icons.star,
              title: 'Preferiti',
              trailing: const Icon(Icons.favorite, color: Colors.red, size: 20),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Preferiti selezionati');
              },
            ),
            DrawerItemConfig(
              icon: Icons.settings,
              title: 'Impostazioni',
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Impostazioni selezionate');
              },
            ),
            const DrawerItemConfig.divider(),
            DrawerItemConfig(
              icon: Icons.help_outline,
              title: 'Aiuto',
              onTap: () {
                Navigator.pop(context);
                _showHelpDialog();
              },
            ),
            DrawerItemConfig(
              icon: Icons.info_outline,
              title: 'Info',
              onTap: () {
                Navigator.pop(context);
                _showInfoDialog();
              },
            ),
            DrawerItemConfig(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                Navigator.pop(context);
                _showLogoutDialog();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 20),
            const Text(
              '🎉 Custom App Drawer Test!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hai premuto il pulsante questo numero di volte:',
              textAlign: TextAlign.center,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 30),
            const Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      '📋 Test Features:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('• Apri il drawer per testare'),
                    Text('• Badge notifiche personalizzabili'),
                    Text('• Icone trailing'),
                    Text('• Gradient header'),
                    Text('• Divider tra sezioni'),
                    Text('• Dialog interattivi'),
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _notificationCount++;
                });
                _showSnackBar('Nuova notifica aggiunta!');
              },
              icon: const Icon(Icons.add_alert),
              label: const Text('Aggiungi Notifica'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementa',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Aiuto'),
            content: const Text(
              'Questo è un test del Custom App Drawer!\n\n'
              'Features testate:\n'
              '• Header con gradient personalizzato\n'
              '• Badge notifiche dinamiche\n'
              '• Icone trailing personalizzate\n'
              '• Divider per organizzare il menu\n'
              '• Azioni personalizzabili',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Info'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Custom App Drawer v1.0.0'),
                SizedBox(height: 8),
                Text('Test App - Funzionalità Complete'),
                SizedBox(height: 8),
                Text('✅ Package testato con successo!'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Logout'),
            content: const Text(
              'Sei sicuro di voler uscire dall\'applicazione?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Annulla'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showSnackBar('Logout effettuato (simulato)!');
                },
                child: const Text('Logout'),
              ),
            ],
          ),
    );
  }
}
