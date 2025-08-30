import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

// --- Variáveis Globais para Simular um Estado Compartilhado ---
// Em uma aplicação real, isso seria gerenciado por um banco de dados (ex: Firestore) ou um gerenciador de estado (ex: Provider, Riverpod).
List<Map<String, String>> alertHistory = [];

void _logAlert(String type) {
  final now = DateTime.now();
  final dateFormat = DateFormat('dd/MM/yyyy');
  final timeFormat = DateFormat('HH:mm');
  alertHistory.add({
    'date': dateFormat.format(now),
    'time': timeFormat.format(now),
    'type': type,
    'status': 'Enviado', // Status fixo por enquanto
  });
}

// Definindo a paleta de cores para consistência
const Color primaryColor = Color(0xFF0D0F36);
const Color secondaryColor = Color(0xFF294380);
const Color accentColor = Color(0xFF69D2CD);
const Color greenColor = Color(0xFFB9F1D6);
const Color yellowColor = Color(0xFFF1F6CE);

// --- Telas de Autenticação ---

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/kuarup_logo.png', height: 100),
              const SizedBox(height: 24),
              const Text(
                'Bem-vindo de volta!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                  prefixIcon: Icon(Icons.email, color: yellowColor),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Senha',
                  prefixIcon: Icon(Icons.lock, color: yellowColor),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Lógica de login
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text('ENTRAR', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/recover_password'),
                child: const Text('Esqueceu a senha?', style: TextStyle(color: accentColor)),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/register'),
                child: const Text('Não tem conta? Registre-se', style: TextStyle(color: greenColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nome Completo',
                  prefixIcon: Icon(Icons.person, color: yellowColor),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                  prefixIcon: Icon(Icons.email, color: yellowColor),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Senha',
                  prefixIcon: Icon(Icons.lock, color: yellowColor),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Confirmar Senha',
                  prefixIcon: Icon(Icons.lock, color: yellowColor),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Lógica de registro
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text('CRIAR CONTA', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecoverPasswordPage extends StatelessWidget {
  const RecoverPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Informe seu e-mail para enviarmos um link de recuperação.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                  prefixIcon: Icon(Icons.email, color: yellowColor),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Lógica para enviar e-mail
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: secondaryColor,
                      title: const Text("E-mail Enviado!", style: TextStyle(color: Colors.white)),
                      content: const Text("Verifique sua caixa de entrada para o link de recuperação.", style: TextStyle(color: Colors.white70)),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text("OK", style: TextStyle(color: greenColor)),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text('ENVIAR LINK', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Telas Principais com Navegação e Geolocalização ---

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
      _logAlert('Alerta Manual');

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

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  // A lista de contatos é o estado que será gerenciado
  final List<Map<String, String>> _contacts = [
    {'name': 'Ana Paula', 'phone': '(11) 98765-4321'},
    {'name': 'João Silva', 'phone': '(11) 91234-5678'},
    {'name': 'Maria Oliveira', 'phone': '(11) 99887-6655'},
  ];

  // Mostra um diálogo para adicionar ou editar um contato
  void _showContactDialog({int? index}) {
    final isEditing = index != null;
    final nameController = TextEditingController(text: isEditing ? _contacts[index]['name'] : '');
    final phoneController = TextEditingController(text: isEditing ? _contacts[index]['phone'] : '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: secondaryColor,
        title: Text(isEditing ? "Editar Contato" : "Adicionar Contato",
            style: const TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.person, color: yellowColor),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Telefone",
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.phone, color: yellowColor),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancelar", style: TextStyle(color: accentColor)),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
                if (isEditing) {
                  _updateContact(index, nameController.text, phoneController.text);
                } else {
                  _addContact(nameController.text, phoneController.text);
                }
                Navigator.of(ctx).pop();
              }
            },
            child: Text(isEditing ? "Salvar" : "Adicionar",
                style: const TextStyle(color: greenColor)),
          ),
        ],
      ),
    );
  }

  // Adiciona um novo contato à lista
  void _addContact(String name, String phone) {
    setState(() {
      _contacts.add({'name': name, 'phone': phone});
    });
  }

  // Atualiza um contato existente
  void _updateContact(int index, String newName, String newPhone) {
    setState(() {
      _contacts[index]['name'] = newName;
      _contacts[index]['phone'] = newPhone;
    });
  }

  // Remove um contato da lista
  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Contatos de Confiança'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: yellowColor),
            onPressed: () {
              // Lógica de busca
            },
          ),
        ],
      ),
      body: _contacts.isEmpty
          ? const Center(
              child: Text(
                'Nenhum contato adicionado ainda.',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return Card(
                  color: secondaryColor,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: const CircleAvatar(
                      backgroundColor: yellowColor,
                      child: Icon(Icons.person, color: secondaryColor),
                    ),
                    title: Text(contact['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(contact['phone']!, style: const TextStyle(color: Colors.white70)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: accentColor),
                          onPressed: () => _showContactDialog(index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteContact(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showContactDialog(),
        backgroundColor: accentColor,
        child: const Icon(Icons.add, color: primaryColor),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: secondaryColor,
        selectedItemColor: yellowColor,
        unselectedItemColor: Colors.white54,
        currentIndex: 1, // Indica a tela de contatos
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (index == 1) {
            // Já está na tela de contatos
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

// --- Tela de Palavra-código ---

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
      _logAlert('Palavra-código');

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
