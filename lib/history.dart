import 'package:flutter/material.dart';
import 'package:kuarup_safe/utils.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Histórico de Alertas'),
      ),
      body: alertHistory.isEmpty
          ? const Center(
              child: Text(
                'Nenhum alerta enviado ainda.',
                style: TextStyle(fontSize: 18, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: alertHistory.length,
              itemBuilder: (context, index) {
                // Acessa os dados da lista global
                final entry = alertHistory[index];
                return Card(
                  color: secondaryColor,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: const Icon(Icons.warning_amber, color: yellowColor, size: 40),
                    title: Text(entry['type']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'Data: ${entry['date']} às ${entry['time']}\nStatus: ${entry['status']}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: accentColor, size: 16),
                    onTap: () {
                      // Lógica para ver detalhes do alerta
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: secondaryColor,
        selectedItemColor: yellowColor,
        unselectedItemColor: Colors.white54,
        currentIndex: 2, // Indica a tela de histórico
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (index == 1) {
            Navigator.of(context).pushReplacementNamed('/contacts');
          } else if (index == 2) {
            // Já está na tela de histórico
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