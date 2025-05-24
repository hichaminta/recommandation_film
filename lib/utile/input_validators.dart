import 'dart:convert';

//import 'package:html_escape/html_escape.dart';

class InputValidators {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  static String sanitizeEmail(String email) {
    // Convertir en minuscules
    String sanitized = email.toLowerCase().trim();
    // Supprimer les caractères dangereux
    sanitized = HtmlEscape().convert(sanitized);
    return sanitized;
  }

  static String sanitizeUsername(String username) {
    // Supprimer les espaces au début et à la fin
    String sanitized = username.trim();
    // Supprimer les caractères spéciaux sauf underscore
    sanitized = sanitized.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');
    // Échapper les caractères HTML
    sanitized = HtmlEscape().convert(sanitized);
    return sanitized;
  }

  static bool isStrongPassword(String password) {
    // Au moins 8 caractères
    if (password.length < 8) return false;
    
    // Au moins une majuscule
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    
    // Au moins une minuscule
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    
    // Au moins un chiffre
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    
    // Au moins un caractère spécial
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    
    return true;
  }

  static String sanitizeInput(String input) {
    // Supprimer les caractères de contrôle et les espaces inutiles
    String sanitized = input.trim().replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '');
    // Échapper les caractères HTML
    sanitized = HtmlEscape().convert(sanitized);
    return sanitized;
  }
} 