import 'package:flutter/material.dart';
import 'package:language_tool/language_tool.dart';
import '../Widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController? textEditingController = TextEditingController();

  var tool = LanguageTool();
  var result;
  List? R;

  @override
  void initState() {
    R = [];
  }

  Future checkspell() async {
    result = await tool.check(textEditingController!.text);
    markMistakes(result, textEditingController!.text);
    result = await tool.check(textEditingController!.text);
    setState(() {
      R = result;
    });

    printDetails(result);
  }

  ///Prints every property for every [WritingMistake] passed.
  void printDetails(List<WritingMistake> result) {
    for (var mistake in result) {
      print('''
        Issue: ${mistake.message}
        IssueType: ${mistake.issueDescription}
        positioned at: ${mistake.offset}
        with the lengh of ${mistake.length}.
        Possible corrections: ${mistake.replacements}
    ''');
    }
  }

  /// prints the given [sentence] with all mistakes marked red.
  void markMistakes(List<WritingMistake> result, String sentence) {
    var red = '\u001b[31m';
    var reset = '\u001b[0m';

    var addedChars = 0;

    for (var mistake in result) {
      sentence = sentence.replaceRange(
        mistake.offset! + addedChars,
        mistake.offset! + mistake.length! + addedChars,
        red +
            sentence.substring(mistake.offset! + addedChars,
                mistake.offset! + mistake.length! + addedChars) +
            reset,
      );
      addedChars += 9;
    }

    print(sentence);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spelling Checker"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*.05,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomContainer(
              widget :TextField(
                controller: textEditingController,
                cursorColor: Colors.black,
                showCursor: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                decoration: const InputDecoration(
                  hintText: "Enter Your Text Here",
                  hintStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
                onPressed: checkspell,
                child: const Text(
                  "Click Here to check possible spelling fix",
                  style: TextStyle(fontSize: 20),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomContainer(
              widget: SingleChildScrollView(
                reverse: true,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: R!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SelectableText(
                        showCursor: true,
                        toolbarOptions: const ToolbarOptions(
                            copy: true,
                            selectAll: true,
                            cut: false,
                            paste: false),
                        "${R![index].replacements.take(5)}\n",
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      );
                    }),
              ),
            ),
    ),

        ],
      ),
    );
  }
}
