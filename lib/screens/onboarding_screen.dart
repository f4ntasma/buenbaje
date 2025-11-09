import 'package:flutter/material.dart';
import 'auth_screen.dart'; // Navegaremos a la pantalla de autenticación

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/onboarding1.png", // Reemplaza con tus imágenes
      "title": "¡Bienvenido a BuenBaje!",
      "description": "Encuentra productos increíbles a punto de vencer a precios de remate."
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Ahorra Dinero",
      "description": "Aprovecha ofertas únicas y reduce el desperdicio de alimentos."
    },
    {
      "image": "assets/images/onboarding3.png",
      "title": "Explora Cerca de Ti",
      "description": "Descubre comercios locales con productos que necesitan un hogar."
    },
    {
      "image": "assets/images/onboarding4.png",
      "title": "¡Únete a la Comunidad!",
      "description": "Regístrate y empieza a salvar comida y tu cartera hoy mismo."
    },
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _navigateToAuthScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    data: _onboardingData[index],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => buildDot(index: index),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage == _onboardingData.length - 1) {
                    _navigateToAuthScreen();
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  _currentPage == _onboardingData.length - 1 ? 'Comenzar' : 'Siguiente',
                ),
              ),
            ),
            TextButton(
              onPressed: _navigateToAuthScreen,
              child: const Text('Saltar'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index ? Theme.of(context).primaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final Map<String, String> data;
  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.asset(data["image"]!, height: 250), // Descomenta cuando tengas las imágenes
        Text(data["title"]!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(data["description"]!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}