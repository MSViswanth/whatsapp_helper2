import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

///Home Page for the app
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WhatsApp Helper",
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: const Color(0xFFBAF1EB),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.1 * MediaQuery.of(context).size.height,
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              "Enter your phone number with country code",
              style: GoogleFonts.varelaRound(
                textStyle: Theme.of(context).textTheme.bodyLarge,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                // color: Theme.of(context).textTheme.bodyText1?.color,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),

          ///Decorated TextField
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFBAF1EB),
              borderRadius: BorderRadius.circular(64.0),
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
                FilteringTextInputFormatter.digitsOnly
              ],
              autofocus: true,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor,
                  ),
              cursorColor: Theme.of(context).colorScheme.secondary,
            ),
          ),

          ///Send Button
          Center(
            child: Container(
              width: 0.3 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(64.0),
              ),
              margin: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () {
                  _url =
                      Uri.parse('https://wa.me/${textEditingController.text}');
                  _launchUrl();
                },
                child: Text(
                  "Send",
                  style: GoogleFonts.varelaRound(
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    // color: Theme.of(context).textTheme.bodyText1?.color,
                    color: const Color(0xFFBAF1EB),
                  ),
                ),
              ),
            ),
          ),

          ///International Input TextField
          // Container(
          //   decoration: BoxDecoration(
          //     color: const Color(0xFFBAF1EB),
          //     borderRadius: BorderRadius.circular(64.0),
          //   ),
          //   margin: const EdgeInsets.all(16.0),
          //   child: InternationalPhoneNumberInput(
          //     onInputChanged: (phoneNumber) {
          //       print(phoneNumber);
          //     },
          //
          //     inputDecoration: const InputDecoration(
          //       enabledBorder: InputBorder.none,
          //       focusedBorder: InputBorder.none,
          //       contentPadding: EdgeInsets.all(16.0),
          //     ),
          //     keyboardType: TextInputType.number,
          //     // inputFormatters: <TextInputFormatter>[
          //     //   FilteringTextInputFormatter.digitsOnly
          //     // ],
          //     autoFocus: true,
          //     textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
          //           fontSize: 40,
          //           fontWeight: FontWeight.w900,
          //           color: Theme.of(context).primaryColor,
          //         ),
          //     cursorColor: Theme.of(context).colorScheme.secondary,
          //     selectorConfig: const SelectorConfig(
          //       selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
