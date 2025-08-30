import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kuarup_safe/utils.dart';

class CodewordPage extends StatefulWidget {
  const CodewordPage({super.key});

  @override
  State<CodewordPage> createState() => _CodewordPageState();
}

class _CodewordPageState extends State<CodewordPage> {
  String _codeword = 'alerta'; // Palavra-código padrão
  bool _isListening = false;

  final _codewordController = TextEditingController();
  final _spokenCodewordController = TextEditingController();

  Future<void> _dispararAlerta() async {
    // Reutilizando a lógica de geolocalização da HomeScreen
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showDialog("Permissão de Localização Negada", "O acesso à localização é necessário para disparar o alerta.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showDialog("Permissão Negada Permanentemente", "O acesso à localização foi negado permanentemente. Habilite nas configurações.");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _showDialog("Alerta Enviado!", "Alerta disparado pela palavra-código! Sua geolocalização:\n\nLatitude: ${position.latitude}\nLongitude: ${position.longitude}");
      logAlert('Palavra-código');

    } catch (e) {
      _showDialog("Erro ao Obter Localização", "Não foi possível obter a sua localização. Verifique o GPS.");
    }
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

  void _showCodewordDialog() {
    _codewordController.text = _codeword;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: secondaryColor,
        title: const Text("Definir Palavra-código", style: TextStyle(color: Colors.white)),
        content: TextFormField(
          controller: _codewordController,
          decoration: const InputDecoration(
            labelText: 'Nova Palavra-código',
            labelStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.vpn_key, color: yellowColor),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancelar", style: TextStyle(color: accentColor)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _codeword = _codewordController.text;
              });
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Palavra-código salva como: "$_codeword"'),
                  backgroundColor: greenColor,
                ),
              );
            },
            child: const Text("Salvar", style: TextStyle(color: greenColor)),
          ),
        ],
      ),
    );
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });

    if (_isListening) {
      // Simula a escuta de áudio
      _spokenCodewordController.clear();
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: secondaryColor,
          title: const Text("Modo de Escuta Ativo", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Por favor, diga a palavra-código...",
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 10),
              TextFormField(
                controller: _spokenCodewordController,
                decoration: const InputDecoration(
                  labelText: 'Digite a palavra',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final spokenWord = _spokenCodewordController.text;
                if (spokenWord.toLowerCase().trim() == _codeword.toLowerCase().trim()) {
                  _dispararAlerta();
                } else {
                  _showDialog("Palavra Incorreta", "A palavra que você digitou não corresponde à palavra-código.");
                }
                Navigator.of(ctx).pop();
                setState(() {
                  _isListening = false;
                });
              },
              child: const Text("OK", style: TextStyle(color: greenColor)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Palavra-código'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isListening ? 'Ouvindo...' : 'Toque para ativar o modo de escuta.',
              style: const TextStyle(fontSize: 18, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: _toggleListening,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: yellowColor, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: yellowColor.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: _isListening
                    ? const CircularProgressIndicator(color: yellowColor)
                    : const Icon(Icons.mic_none, size: 80, color: yellowColor),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _showCodewordDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Definir Palavra-código',
                style: TextStyle(fontSize: 16, color: primaryColor),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Sua palavra-código atual é: "$_codeword"',
              style: const TextStyle(fontSize: 14, color: greenColor),
            ),
          ],
        ),
      ),
    );
  }
}