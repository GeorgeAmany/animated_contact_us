# 📨 animated_contact_us

A beautiful and customizable Flutter widget to display animated contact information and social media links with smooth entry effects.

Ideal for apps, portfolios, or business apps that want to provide sleek, professional contact UIs with little effort.

---

## ✨ Features

- Animated entry for contact cards and social icons
- Customizable primary color and labels
- Supports phone, email, website, WhatsApp
- Built-in support for social media icons:
    - Facebook
    - Instagram
    - Twitter (X)
    - GitHub
    - Snapchat
    - LinkedIn
    - TikTok
- Mouse hover animations (Web/Desktop)
- Tap animations (Mobile)

---

## Getting started

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  animated_contact_us: ^0.0.1
  
## Preview

![Demo](https://github.com/GeorgeAmany/animated_contact_us/blob/main/example/assets/demo.gif?raw=true)

## Usage

Here’s a simple example of how to use the `ContactUsWidget`:

```dart
import 'package:flutter/material.dart';
import 'package:animated_contact_us/animated_contact_us.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Us Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ContactUsWidget(
            phone: '+1 (123) 456-7890',
            email: 'example@email.com',
            website: 'example.com',
            instagram: 'yourprofile',
            facebook: 'yourpage',
            twitter: 'yourhandle',
            github: 'yourgithub',
            whatsapp: '+11234567890',
            snapchat: 'snapname',
            linkedIn: 'linkedinid',
            tiktok: 'tiktokuser',
            showLabels: true,
            primaryColor: Colors.teal,
            emailLabel: 'Email',
            phoneLabel: 'Phone',
            websiteLabel: 'Website',
            followUsLabel: 'Follow us on',
          ),
        ),
      ),
    );
  }
}