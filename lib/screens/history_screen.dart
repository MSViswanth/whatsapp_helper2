import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_helper/helpers/database_helper.dart';

import '../models/number.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin {
  late List<Number> history;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshHistory();
  }

  Future refreshHistory() async {
    setState(() {
      isLoading = true;
    });
    history = await DatabaseHelper.instance.readAllNumbers();
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text("History"),
          actions: isLoading || history.isEmpty ? [] : [
            TextButton(
              onPressed: () async {
                await DatabaseHelper.instance.deleteAll();
                refreshHistory();
              },
              child: Text("Delete All"),
            ),
          ],
        ),
        body:
            isLoading
                ? CircularProgressIndicator()
                : history.isEmpty
                ? Center(
                  child: Text("Please use \"Send\" screen to send messages."),
                )
                : ListView(
                  children: List.generate(history.length, (index) {
                    //Data
                    String number = history[index].number;
                    DateTime dateTime =
                        DateTime.parse(history[index].dateTime).toLocal();
                    DateFormat dateFormat = DateFormat.yMMMMd().add_jm();
                    String date = dateFormat.format(dateTime);
                    return Dismissible(
                      key: Key(history[index].id.toString()),
                      onDismissed: (direction) async {
                        await DatabaseHelper.instance.deleteNumber(
                          history[index].id,
                        );
                      },
                      child: ListTile(
                        title: Text(
                          number,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        subtitle: Text(date),
                        trailing: OutlinedButton(
                          onPressed: () {
                            Uri uri = Uri.parse('tel:$number');
                            launchUrl(uri);
                          },
                          child: Icon(Icons.call),
                        ),
                        onTap: () {
                          Uri uri = Uri.parse(
                            'https://wa.me/${history[index].number}',
                          );
                          launchUrl(uri);
                        },
                      ),
                    );
                  }),
                ),
      ),
    );
  }
}
