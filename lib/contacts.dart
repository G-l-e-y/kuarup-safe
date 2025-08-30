import 'package:flutter/material.dart';
import 'package:kuarup_safe/utils.dart';

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
