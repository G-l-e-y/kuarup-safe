import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F36),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F36),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            // Simula a navegação para a tela de configurações com um pop-up
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: const Color(0xFF294380),
                title: const Text(
                  "Tela de Configurações",
                  style: TextStyle(color: Colors.white),
                ),
                content: const Text(
                  "Aqui o usuário acessaria as configurações e informações do app.",
                  style: TextStyle(color: Colors.white70),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text("Fechar", style: TextStyle(color: Color(0xFFB9F1D6))),
                  ),
                ],
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/kuarup_logo.png',
              width: 40,
              height: 40,
            ),
          ),
        ),
        title: const Text(
          'Kuarup Safe',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(140),
                border: Border.all(color: const Color(0xFF69D2CD), width: 4),
                image: const DecorationImage(
                  image: AssetImage('assets/mapa.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 80,
                ),
              ),
            ),
            const SizedBox(height: 120),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: const Color(0xFF294380),
                    title: const Text(
                      "Alerta Enviado!",
                      style: TextStyle(color: Colors.white),
                    ),
                    content: const Text(
                      "Sua rede de apoio foi notificada. A geolocalização foi enviada.",
                      style: TextStyle(color: Colors.white70),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text("OK", style: TextStyle(color: Color(0xFFB9F1D6))),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF294380),
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'DISPARAR ALERTA',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF294380),
        selectedItemColor: const Color(0xFFF1F6CE),
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Contatos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
        ],
      ),
    );
  }
}