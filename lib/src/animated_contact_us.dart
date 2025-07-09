// Conditional import to avoid dart:io crash on web
import 'dart:io' if (dart.library.html) 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // only need this for social icons (font_awesome_flutter)
import 'package:url_launcher/url_launcher.dart';

import 'widgets/animated_entry.dart'; // Custom widget to smoothly fade & slide items in
import 'widgets/hover_icon_button.dart'; // Custom hoverable icon button (for social icons)

/// This widget displays contact info like email, phone, and website,
/// and animates their appearance alongside social media icons.
/// ```
class AnimatedContactUs extends StatefulWidget {
  /// Email address to be displayed (optional).
  final String? email;

  /// Phone number to be shown and dialed.
  final String phone;

  /// Website URL (optional).
  final String? website;

  /// Instagram username (optional).
  final String? instagram;

  /// Facebook username (optional).
  final String? facebook;

  /// Twitter/X username (optional).
  final String? twitter;

  /// GitHub username (optional).
  final String? github;

  /// WhatsApp number (optional).
  final String? whatsapp;

  /// Snapchat username (optional).
  final String? snapchat;

  /// LinkedIn username (optional).
  final String? linkedIn;

  /// TikTok username (optional).
  final String? tiktok;

  /// Whether to show the label text for each contact card.
  final bool showLabels;

  /// Main color for the icons and text highlights.
  final Color? primaryColor;

  /// Custom label for the email field.
  final String? emailLabel;

  /// Custom label for the phone field.
  final String? phoneLabel;

  /// Custom label for the website field.
  final String? websiteLabel;

  /// Label for the "Follow Us" section.
  final String? followUsLabel;

  /// Creates an animated contact section with social media links.
  const AnimatedContactUs({
    super.key,
    this.email,
    required this.phone,
    this.website,
    this.instagram,
    this.facebook,
    this.twitter,
    this.github,
    this.whatsapp,
    this.snapchat,
    this.tiktok,
    this.linkedIn,
    this.showLabels = true,
    this.primaryColor,
    this.emailLabel,
    this.phoneLabel,
    this.websiteLabel,
    this.followUsLabel,
  });

  @override
  State<AnimatedContactUs> createState() => _AnimatedContactUsState();
}

class _AnimatedContactUsState extends State<AnimatedContactUs> {
  final List<bool> _visibleCards =
      []; // Tracks visibility state of each contact card
  final List<bool> _visibleSocials =
      []; // Tracks visibility state of each social icon
  bool get isIOS => !kIsWeb && html.Platform.isIOS;
  bool get isAndroid => !kIsWeb && html.Platform.isAndroid;

  Color get _mainColor =>
      widget.primaryColor ?? Theme.of(context).colorScheme.primary;

  @override
  void initState() {
    super.initState();

    // Staggered animation for contact cards
    Future.forEach(List.generate(_cardCount, (i) => i), (int i) async {
      await Future.delayed(Duration(milliseconds: 140 * i));
      if (mounted) {
        setState(() {
          if (_visibleCards.length <= i) {
            _visibleCards.add(true);
          } else {
            _visibleCards[i] = true;
          }
        });
      }
    });

    // Staggered animation for social icons
    Future.forEach(List.generate(_socialCount, (i) => i), (int i) async {
      await Future.delayed(Duration(milliseconds: 20 * (_cardCount + i)));
      if (mounted) {
        setState(() {
          if (_visibleSocials.length <= i) {
            _visibleSocials.add(true);
          } else {
            _visibleSocials[i] = true;
          }
        });
      }
    });
  }

  // Total number of contact cards (email, phone, website, optionally WhatsApp)
  int get _cardCount {
    int count = 3;
    if (widget.whatsapp != null) count++;
    return count;
  }

  // Total number of social icons to display
  int get _socialCount {
    int count = 0;
    if (widget.website != null) count++;
    if (widget.facebook != null) count++;
    if (widget.instagram != null) count++;
    if (widget.twitter != null) count++;
    if (widget.github != null) count++;
    if (widget.whatsapp != null) count++;
    if (widget.snapchat != null) count++;
    if (widget.linkedIn != null) count++;
    if (widget.tiktok != null) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> contactCards = [];

    // Email card
    if (widget.email != null) {
      contactCards.add(
        _buildCard(
          index: contactCards.length,
          context: context,
          icon: Icons.email,
          label: widget.emailLabel ?? 'Email',
          value: widget.email!,
          onTap: () => _launchEmail(widget.email!),
        ),
      );
    }

    // Phone card
    contactCards.add(
      _buildCard(
        index: contactCards.length,
        context: context,
        icon: Icons.phone,
        label: widget.phoneLabel ?? 'Phone Number',
        value: widget.phone,
        onTap: () => _launchPhone(widget.phone),
      ),
    );

    // Optional WhatsApp card
    // if (widget.whatsapp != null) {
    //   contactCards.add(_buildCard(
    //     index: contactCards.length,
    //     context: context,
    //     icon: FontAwesomeIcons.whatsapp,
    //     label: tr_whatsapp.tr(),
    //     value: widget.whatsapp!,
    //     onTap: () => _launchWhatsApp(widget.whatsapp!),
    //   ));
    // }

    // Website card
    if (widget.website != null) {
      contactCards.add(
        _buildCard(
          index: contactCards.length,
          context: context,
          icon: Icons.language,
          label: widget.websiteLabel ?? 'Website',
          value: widget.website!,
          url: widget.website,
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...contactCards,
          const SizedBox(height: 24),
          Text(
            widget.followUsLabel ?? 'Follow Us',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildSocialIcons(), // Displays social media icons
        ],
      ),
    );
  }

  // Builds an animated contact card with optional URL launch or tap action
  Widget _buildCard({
    required int index,
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    String? url,
    VoidCallback? onTap,
  }) {
    final isVisible = index < _visibleCards.length && _visibleCards[index];

    return AnimatedEntry(
      visible: isVisible,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _mainColor.withAlpha((255 * 0.1).round()),
            child: Icon(icon, color: _mainColor),
          ),
          title:
              widget.showLabels
                  ? Text(label, style: Theme.of(context).textTheme.titleMedium)
                  : null,
          subtitle: GestureDetector(
            onTap: onTap ?? (url != null ? () => _launchURL(url) : null),
            child: Text(
              value,
              style: TextStyle(
                color: url != null ? _mainColor : null,
                decoration: url != null ? TextDecoration.underline : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Builds a responsive row of social media icon buttons with animations
  Widget _buildSocialIcons() {
    final List<_SocialIconData> data = [];

    if (widget.facebook != null) {
      data.add(
        _SocialIconData(
          FontAwesomeIcons.facebook,
          () => _launchFacebook(widget.facebook!),
        ),
      );
    }
    if (widget.instagram != null) {
      data.add(
        _SocialIconData(
          FontAwesomeIcons.instagram,
          () => _launchInstagram(widget.instagram!),
        ),
      );
    }
    if (widget.twitter != null) {
      data.add(
        _SocialIconData(
          FontAwesomeIcons.twitter,
          () => _launchTwitter(widget.twitter!),
        ),
      );
    }
    if (widget.github != null) {
      data.add(
        _SocialIconData(
          FontAwesomeIcons.github,
          () => _launchGithub(widget.github!),
        ),
      );
    }
    if (widget.whatsapp != null) {
      data.add(
        _SocialIconData(
          FontAwesomeIcons.whatsapp,
          () => _launchWhatsApp(widget.whatsapp!),
        ),
      );
    }

    // Website icon is always included
    if (widget.website != null) {
      data.add(
        _SocialIconData(Icons.language, () => _launchURL(widget.website!)),
      );
    }

    if (widget.snapchat != null) {
      data.add(
        _SocialIconData(
          FontAwesomeIcons.snapchat,
          () => _launchSnapchat(widget.snapchat!),
        ),
      );
    }

    if (widget.linkedIn != null) {
      data.add(
        _SocialIconData(
          FontAwesomeIcons.linkedin,
          () => _launchLinkedIn(widget.linkedIn!),
        ),
      );
    }

    if (widget.tiktok != null) {
      data.add(
        _SocialIconData(
          FontAwesomeIcons.tiktok,
          () => _launchTikTok(widget.tiktok!),
        ),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: List.generate(data.length, (index) {
        final item = data[index];
        final isVisible =
            index < _visibleSocials.length && _visibleSocials[index];

        return AnimatedEntry(
          visible: isVisible,
          child: HoverIconButton(icon: item.icon, onTap: item.onTap),
        );
      }),
    );
  }

  void _launchEmail(String email) async {
    final encodedEmail = Uri.encodeComponent(email);
    final uri = Uri.parse('mailto:$encodedEmail');

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        _showError('Could not open email client.');
      }
    } catch (e) {
      _showError('Error launching email: $e');
    }
  }

  void _launchPhone(String phoneNumber) async {
    final cleaned = phoneNumber.replaceAll(
      RegExp(r'\s+'),
      '',
    ); // to remove any spaces
    final uri = Uri.parse('tel:$cleaned');

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        _showError('Could not open dialer.');
      }
    } catch (e) {
      _showError('Error launching phone: $e');
    }
  }

  // Opens a given URL in the system browser
  void _launchURL(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    final uri = Uri.tryParse(Uri.encodeFull(url));
    if (uri == null) {
      _showError('Invalid URL: $url');
      return;
    }
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        _showError('Could not open: $url');
      }
    } catch (e) {
      _showError('Error opening link: $e');
    }
  }

  // Launches WhatsApp chat with optional message
  Future<void> _launchWhatsApp(String phone, {String message = ''}) async {
    final encodedMessage = Uri.encodeComponent(message);
    final androidUrl = "whatsapp://send?phone=$phone&text=$encodedMessage";
    final iosUrl = "https://wa.me/$phone?text=$encodedMessage";
    final webUrl =
        "https://api.whatsapp.com/send/?phone=$phone&text=$encodedMessage";

    try {
      if (isIOS) {
        if (await canLaunchUrl(Uri.parse(iosUrl))) {
          await launchUrl(
            Uri.parse(iosUrl),
            mode: LaunchMode.externalApplication,
          );
          return;
        }
      } else {
        if (await canLaunchUrl(Uri.parse(androidUrl))) {
          await launchUrl(
            Uri.parse(androidUrl),
            mode: LaunchMode.externalApplication,
          );
          return;
        }
      }
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching WhatsApp: $e');
    }
  }

  // Launches Facebook profile or fallback to browser
  Future<void> _launchFacebook(String username) async => _launchSocial(
    ios: 'fb://profile/$username',
    android: 'fb://facewebmodal/f?href=https://facebook.com/$username',
    web: 'https://facebook.com/$username',
  );

  Future<void> _launchInstagram(String username) async => _launchSocial(
    ios: 'instagram://user?username=$username',
    android: 'instagram://user?username=$username',
    web: 'https://instagram.com/$username',
  );

  Future<void> _launchTwitter(String username) async => _launchSocial(
    ios: 'twitter://user?screen_name=$username',
    android: 'twitter://user?screen_name=$username',
    web: 'https://twitter.com/$username',
  );

  Future<void> _launchGithub(String username) async => launchUrl(
    Uri.parse('https://github.com/$username'),
    mode: LaunchMode.externalApplication,
  );

  Future<void> _launchSnapchat(String username) async => _launchSocial(
    ios: 'snapchat://add/$username',
    android: 'snapchat://add/$username',
    web: 'https://www.snapchat.com/add/$username',
  );

  Future<void> _launchLinkedIn(String username) async => _launchSocial(
    ios: 'linkedin://in/$username',
    android: 'linkedin://in/$username',
    web: 'https://www.linkedin.com/in/$username',
  );

  Future<void> _launchTikTok(String username) async => _launchSocial(
    ios: 'snssdk1128://user/profile/$username',
    android: 'snssdk1128://user/profile/$username',
    web: 'https://www.tiktok.com/@$username',
  );

  // Tries to open native app URL, falls back to web version
  Future<void> _launchSocial({
    required String ios,
    required String android,
    required String web,
  }) async {
    final native = isIOS ? ios : android;
    final fallback = Uri.parse(web);

    try {
      final success = await launchUrl(
        Uri.parse(native),
        mode: LaunchMode.externalApplication,
      );
      if (!success) {
        await launchUrl(fallback, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      await launchUrl(fallback, mode: LaunchMode.externalApplication);
    }
  }

  void _showError(String message) {
    final context = this.context;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

// Simple model to store icon and its tap handler
class _SocialIconData {
  final IconData icon;
  final VoidCallback onTap;

  _SocialIconData(this.icon, this.onTap);
}
