import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'not_found_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'https://i0.wp.com/codigoespagueti.com/wp-content/uploads/2023/10/Increible-fanart-convierte-a-waifus-de-My-Hero-Academia-en-heroinas-de-Sailor-Moon.jpg',
      'https://wallpapers.com/images/hd/anime-waifu-collage-characters-on-white-aesthetic-ehlkprllnvpr2lu7.jpg',
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjGAA3bSUP1wshfPOAWM0fyT_59PzPkw-SApv1NH61vUP7lLXcvCynhmN4jaSL0x9VgHDM7sn1a9O1llfy5vqZKToDkPqyvaBjHF1xMuWfBkd091YeIdvkELktAUMFRQUh-THiHPEjOFVdP/s1600/Captura.JPG',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // logo en esquina izquierda
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png', // Deberías usar un asset local
                    height: 32,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'BuenBaje',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return IconButton(
                      icon: Icon(themeProvider.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny),
                      onPressed: () {
                        themeProvider.toggleTheme(!themeProvider.isDarkMode);
                      },
                    );
                  },
                ),
              ],
            ),
            // menú desplegable en la derecha
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.black87),
              onSelected: (value) {
                if (value == 'logout') {
                  FirebaseAuth.instance.signOut();
                  // El AuthWrapper se encargará de la navegación
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(value: 'inicio', child: Text('Inicio')),
                const PopupMenuItem(value: 'perfil', child: Text('Perfil')),
                const PopupMenuItem(value: 'config', child: Text('Configuración')),
                const PopupMenuDivider(),
                const PopupMenuItem(value: 'logout', child: Text('Cerrar Sesión')),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // carrusel
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,
                ),
                items: images.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            // titulo y ver mas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Destacados',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const NotFoundScreen(),
                      ));
                    },
                    child: const Text('Ver más →'),
                  ),
                ],
              ),
            ),

            // Sección inferior temporal
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.shade50,
              child: const Text(
                'Aquí irá otra sección próximamente papu👻',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}