import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kuarup_safe/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  Future<void> _dispararAlerta() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Verificar permissões
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showDialog("Permissão de Localização Negada", "O acesso à localização é necessário para disparar o alerta. Por favor, habilite nas configurações do seu dispositivo.");
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showDialog("Permissão Negada Permanentemente", "O acesso à localização foi negado permanentemente. Por favor, habilite manualmente nas configurações do seu dispositivo.");
        setState(() {
            _isLoading = false;
          });
        return;
      }

      // 2. Obter a localização
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 3. Exibir o resultado do alerta e registrar no histórico
      _showDialog("Alerta Enviado!", "Sua rede de apoio foi notificada. A geolocalização foi enviada:\n\nLatitude: ${position.latitude}\nLongitude: ${position.longitude}");
      logAlert('Alerta Manual');

    } catch (e) {
      _showDialog("Erro ao Obter Localização", "Não foi possível obter a sua localização. Por favor, verifique se o GPS está ativado.");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: secondaryColor,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: Text(content, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK", style: TextStyle(color: greenColor)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            _showDialog("Tela de Configurações", "Aqui o usuário acessaria as configurações e informações do app.");
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/kuarup_logo.png', width: 40, height: 40),
          ),
        ),
        title: const Text('Kuarup Safe', style: TextStyle(color: Colors.white)),
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
                border: Border.all(color: accentColor, width: 4),
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
              onPressed: _isLoading ? null : _dispararAlerta,
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('DISPARAR ALERTA', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/codeword');
              },
              child: const Text(
                'Configurar Palavra-código',
                style: TextStyle(fontSize: 16, color: accentColor),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: secondaryColor,
        selectedItemColor: yellowColor,
        unselectedItemColor: Colors.white54,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushReplacementNamed('/contacts');
          } else if (index == 2) {
            Navigator.of(context).pushReplacementNamed('/history');
          }
        },
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