import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final Function()? onSeleted;
  final String? initialText;
  DialogBox(
      {Key? key,
      required this.controller,
      required this.onSeleted,
      required this.initialText})
      : super(key: key) {
    controller.text = initialText;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: Colors.purple[200],
      content: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        height: MediaQuery.sizeOf(context).height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                   height:  MediaQuery.sizeOf(context).height * 0.03,
                  textColor: Colors.white,
                  onPressed: onSeleted,
                  color: Colors.purple,
                  child: const Text('Add Todo'),
                ),
                const SizedBox(
                  width: 5,
                ),
                MaterialButton(
                  height:  MediaQuery.sizeOf(context).height * 0.03,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.purple,
                  child: const Text('Cancel'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
