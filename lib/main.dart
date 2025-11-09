import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const BuenBajeApp());
}

class BuenBajeApp extends StatelessWidget {
  const BuenBajeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuenBaje',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'https://i0.wp.com/codigoespagueti.com/wp-content/uploads/2023/10/Increible-fanart-convierte-a-waifus-de-My-Hero-Academia-en-heroinas-de-Sailor-Moon.jpg',
      'https://wallpapers.com/images/hd/anime-waifu-collage-characters-on-white-aesthetic-ehlkprllnvpr2lu7.jpg',
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjGAA3bSUP1wshfPOAWM0fyT_59PzPkw-SApv1NH61vUP7lLXcvCynhmN4jaSL0x9VgHDM7sn1a9O1llfy5vqZKToDkPqyvaBjHF1xMuWfBkd091YeIdvkELktAUMFRQUh-THiHPEjOFVdP/s1600/Captura.JPG',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // logo en esquina izquierda
            Row(
              children: [
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png',
                  height: 32,
                ),
                const SizedBox(width: 8),
                const Text(
                  'BuenBaje',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // menú desplegable en la derecha
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.black87),
              onSelected: (value) {
                if (value == 'perfil') {
                  // acción de ejemplo temporalmente hasta meter la otra sección
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Buscandote papu...')),
                  );
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(value: 'inicio', child: Text('Inicio')),
                const PopupMenuItem(value: 'perfil', child: Text('Perfil')),
                const PopupMenuItem(value: 'config', child: Text('Configuración')),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Aún no hay nada por ahora... xd')),
                      );
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