import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/color_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../provider/app_state_provider.dart';

class TranslateLanguageView extends StatefulWidget {
  @override
  _TranslateLanguageViewState createState() => _TranslateLanguageViewState();
}

class _TranslateLanguageViewState extends State<TranslateLanguageView> {
  String _selectedLanguage = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Provider.of<AppState>(context, listen: false).locale;
    setState(() {
      _selectedLanguage =
          locale.languageCode == 'vi' ? 'Tiếng Việt' : 'English';
    });
  }

  void _changeLanguage(String languageCode) {
    final newLocale = Locale(languageCode);
    Provider.of<AppState>(context, listen: false).setLocale(newLocale);
    setState(() {
      _selectedLanguage = languageCode == 'vi' ? 'Vietnamese' : 'English';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.lightBackgroundSM,
      appBar: AppBar(
        title: Text(
          '${AppLocalizations.of(context)!.language}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Divider(color: Colors.grey[300], height: 1),
            ListTile(
              title: Text(
                'English',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: _selectedLanguage == "English"
                  ? Icon(Icons.check, color: ColorUtils.primaryColor)
                  : null,
              onTap: () => _changeLanguage('en'),
            ),
            Divider(color: Colors.grey[300], height: 1),
            ListTile(
              title: Text(
                'Tiếng Việt',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: _selectedLanguage == "Tiếng Việt"
                  ? Icon(Icons.check, color: ColorUtils.primaryColor)
                  : null,
              onTap: () => _changeLanguage('vi'),
            ),
            Divider(color: Colors.grey[300], height: 1),
          ],
        ),
      ),
    );
  }
}
