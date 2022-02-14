import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  String translate = "";
  String translated = "";
  final translator = GoogleTranslator();

  List<String> fromLanguage = ['auto', 'en', 'ru', 'uz'];
  List<String> fromFullLanguage = ['Automatic', 'English', 'Russian', 'Uzbek'];

  String selectedFrom = '';
  String selectedTo = '';
  int fromLan = 0;
  int toLan = 2;

  TextEditingController controller = TextEditingController();

  // var connectivity;

  @override
  void initState() {
    super.initState();
    selectedFrom = fromLanguage[fromLan];
    selectedTo = fromLanguage[toLan];
  }

  void displayBottomSheet(BuildContext context, int index, height) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        elevation: 0,
        builder: (ctx) {
          return SizedBox(
              height: height,
              child: index == fromLan
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        buttonSheet(0, fromLan),
                        buttonSheet(1, fromLan),
                        buttonSheet(2, fromLan),
                        buttonSheet(3, fromLan),
                      ],
                    )
                  : index == toLan
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            buttonSheet(1, toLan),
                            buttonSheet(2, toLan),
                            buttonSheet(3, toLan),
                          ],
                        )
                      : Container());
        });
  }

  Widget buttonSheet(id, typeLan) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: const Color(0xFFE3E0E0)),
        child: MaterialButton(
          height: 60,
          onPressed: () {
            setState(() {
              if (typeLan == fromLan) {
                if (id == toLan) {
                  var change = translated;
                  translated = translate;
                  translate = change;
                  toLan = fromLan;
                  selectedTo = fromFullLanguage[toLan];
                }
                fromLan = id;
                selectedFrom = fromFullLanguage[fromLan];
                translateText(translate);
              } else if (typeLan == toLan) {
                if (fromLan == id) {
                  var change = translated;
                  translated = translate;
                  translate = change;
                  // translate = '';
                  fromLan = toLan;
                  selectedFrom = fromFullLanguage[fromLan];
                }
                toLan = id;
                selectedTo = fromFullLanguage[toLan];
                translateText(translate);
              }
            });
            Navigator.pop(context);
          },
          color: id == typeLan ? Colors.blue : Colors.transparent,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          focusColor: const Color(0xFFA5A5A5),
          highlightElevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              fromFullLanguage[id],
              style: TextStyle(
                color: id == typeLan ? Colors.white : Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Translate",
          style: TextStyle(color: Color(0xFF009688), fontSize: 24),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    height: 80,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xFFE3E0E0),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  displayBottomSheet(context, fromLan,
                                      MediaQuery.of(context).size.height * 0.4);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                color: Colors.transparent,
                                elevation: 0,
                                focusColor: const Color(0xFFA5A5A5),
                                highlightElevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    fromFullLanguage[fromLan],
                                    style: const TextStyle(
                                      fontFamily: 'SecolarOne',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward_rounded),
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xFFE3E0E0),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  displayBottomSheet(context, toLan,
                                      MediaQuery.of(context).size.height * 0.3);
                                },
                                color: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                focusColor: const Color(0xFFA5A5A5),
                                highlightElevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    fromFullLanguage[toLan],
                                    style: const TextStyle(
                                      fontFamily: 'SecolarOne',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            flex: 4,
                          ),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                flex: 15,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          width: size.width * 0.9,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                TextField(
                                  minLines: 1,
                                  maxLines: 300,
                                  keyboardType: TextInputType.multiline,
                                  controller: controller,
                                  onSubmitted: (value) => translateText(value),
                                  onEditingComplete: () => translateText(translate),
                                  textDirection: TextDirection.ltr,
                                  onChanged: (text) {
                                    translateText(text);
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter Text",
                                    border: InputBorder.none,
                                  ),
                                  style: const TextStyle(
                                      fontFamily: 'SecolarOne', fontSize: 26),
                                ),
                                translate != ""
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            const Divider(
                                              height: 1,
                                              color: Colors.blue,
                                              thickness: 1.5,
                                              indent: 50,
                                              endIndent: 50,
                                            ),
                                            TextField(
                                              minLines: 1,
                                              maxLines: 300,
                                              readOnly: true,
                                              keyboardType: TextInputType.multiline,
                                              enableIMEPersonalizedLearning: true,
                                              decoration: InputDecoration(
                                                hintText: translated,
                                                border: InputBorder.none,
                                              ),
                                              style: const TextStyle(
                                                  fontFamily: 'SecolarOne',
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(alignment: Alignment.bottomRight,child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Powered by Ahmadjon Developer",textAlign: TextAlign.end,),
          )),
        ],
      ),
    );
  }

  void translateText(text) {
    setState(() {
      if (text == "") translated = '';
      translate = text;
      translator
          .translate(translate,
              from: fromLanguage[fromLan], to: fromLanguage[toLan])
          .then((value) {
        translated = value.text;
      });
    });
  }
}
