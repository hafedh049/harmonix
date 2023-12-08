import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:harmonix/utils/globals.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  final FlutterTts flutterTts = FlutterTts();
  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection("results").where("falses", isNotEqualTo: {}).get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          final List<Map<String, dynamic>> data = snapshot.data!.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> e) => e.data()).toList();
          return data.isEmpty
              ? const Center(child: Text("No Results Yet."))
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) => GestureDetector(
                    onTap: () async {
                      await flutterTts.speak(data[index]["falses"].values.toList().join());
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: blue.withOpacity(.2), borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (MapEntry<String, dynamic> entry in data[index]["falses"].entries) ...<Widget>[
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(color: Colors.red.withOpacity(.3), borderRadius: BorderRadius.circular(5)),
                              child: Text(entry.key, style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 23, fontWeight: FontWeight.w400)),
                            ),
                            const SizedBox(height: 20),
                            Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.green.withOpacity(.3), borderRadius: BorderRadius.circular(5)), child: const Text("Correct Answer", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400))),
                            const SizedBox(width: 10),
                            Flexible(child: Text(entry.value, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400))),
                            const SizedBox(height: 20),
                          ],
                          Row(
                            children: <Widget>[
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(color: blue.withOpacity(.3), borderRadius: BorderRadius.circular(5)),
                                child: Text(formatDate(data[index]["date"].toDate(), <String>[yyyy, '-', mm, '-', dd]), style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: teal));
        } else {
          return Center(child: Text(snapshot.error.toString()));
        }
      },
    );
  }
}
