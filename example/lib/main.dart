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