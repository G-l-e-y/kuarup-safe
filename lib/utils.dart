import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// --- Variáveis Globais para Simular um Estado Compartilhado ---
// Em uma aplicação real, isso seria gerenciado por um banco de dados (ex: Firestore) ou um gerenciador de estado (ex: Provider, Riverpod).
List<Map<String, String>> alertHistory = [];

void logAlert(String type) {
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
