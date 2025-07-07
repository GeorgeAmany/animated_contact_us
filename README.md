# animated_contact_us

A beautiful and customizable Flutter widget to display animated contact information and social media links with smooth entry effects.

Ideal for apps, portfolios, or business apps that want to provide sleek, professional contact UIs with little effort.

---

> Developed by **George Amany**, a Flutter developer, with guidance and mentorship by **Abdelrahman Ibrahem** (Tech Lead).  
> This package reflects great teamwork and technical support throughout the process.

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
    - WhatsApp
    - Snapchat
    - LinkedIn
    - TikTok
- Mouse hover animations (Web/Desktop)
- Tap animations (Mobile)

---
## Preview

![Demo](https://raw.githubusercontent.com/GeorgeAmany/animated_contact_us/main/example/assets/demo.gif)
---

## Getting started

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  animated_contact_us: ^0.0.5

## Usage

Example of how to use the `AnimatedContactUs`:

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
          child: AnimatedContactUs(
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