// ignore: depend_on_referenced_packages

import 'package:flutter/material.dart';

class OptionsItems extends StatelessWidget {
  final List<dynamic> options;
  final String correctAnswer;
  final int selectedIndex;
  final bool showCorrect;
  final ValueChanged<int> onOptionSelected;

  const OptionsItems(
      {super.key,
      required this.options,
      required this.onOptionSelected,
      required this.selectedIndex,
      required this.showCorrect,
      required this.correctAnswer});

//  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Add this line
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: options.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: selectedIndex == index
                    ? (showCorrect && options[index] == correctAnswer)
                        ? Colors.green
                        : Colors.grey
                    : (showCorrect && options[index] == correctAnswer)
                        ? Colors.green
                        : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: Colors.black)),
            child: InkWell(
              onTap: showCorrect
                  ? null
                  : () {
                      onOptionSelected(index);
                    },
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      left: BorderSide(color: Colors.black),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(String.fromCharCode(65 + index)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        options[index],
                        softWrap: true,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
