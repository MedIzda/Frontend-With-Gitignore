import 'package:flutter/material.dart';

import '../../constants.dart';

class SearchField extends StatelessWidget {
  final Color backgroundColor;
  final Color primaryColor;
  final String hintText;
  const SearchField({
    super.key,
    required this.backgroundColor,
    required this.primaryColor,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: primaryColor),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: defaultPadding),
          hintText: hintText,
          hintStyle: TextStyle(color: primaryColor),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(32))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1.0),
              borderRadius: const BorderRadius.all(
                Radius.circular(32),
              )),
          fillColor: Colors.white.withOpacity(0.0),
          filled: true,
          suffixIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.search, color: primaryColor))),
    );
  }
}

class AutocompleteField extends StatelessWidget {
  const AutocompleteField({Key? key}) : super(key: key);

  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.startsWith(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black, // black border
              ),
            ),
            hintText: 'Type something...',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
          ),
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              height: 200.0,
              child: ListView(
                padding: EdgeInsets.zero,
                children: options
                    .map((String option) => GestureDetector(
                          onTap: () {
                            onSelected(option);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child: Text(
                              option,
                              style: const TextStyle(
                                color: Colors.white, // white font color
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
