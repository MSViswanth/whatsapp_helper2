import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

///Home Page for the app
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Uri _url = Uri.parse("https://wa.me/");

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 0.1 * MediaQuery.of(context).size.height),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            "Enter your phone number with country code",
            style: GoogleFonts.varelaRound(
              textStyle: Theme.of(context).textTheme.bodyLarge,
              fontWeight: FontWeight.w900,
              // color: Theme.of(context).textTheme.bodyText1?.color,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),

        ///Decorated TextField
        Container(
          decoration: BoxDecoration(
            // color: const Color(0xFFBAF1EB),
            border: Border.all(
              width: 2.0,
              color: Theme.of(context).highlightColor,
            ),
            borderRadius: BorderRadius.circular(32.0),
          ),
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: textEditingController,
            onSubmitted: (value) {
              if (kDebugMode) {
                print(value);
              }
              _url = Uri.parse('https://wa.me/$value');
              _launchUrl();
            },
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(16.0),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            autofocus: true,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              // fontSize: 40,
              fontWeight: FontWeight.w900,
              // color: Theme.of(context).primaryColor,
            ),
            cursorColor: Theme.of(context).colorScheme.secondary,
          ),
        ),

        ///Send Button
        Center(
          child: Container(
            width: 0.3 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(64.0),
            ),
            margin: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                _url = Uri.parse('https://wa.me/${textEditingController.text}');
                _launchUrl();
              },
              child: Text(
                "Send",
                style: GoogleFonts.varelaRound(
                  textStyle: Theme.of(context).textTheme.headlineSmall,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
