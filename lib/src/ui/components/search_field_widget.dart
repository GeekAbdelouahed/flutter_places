import 'dart:async';

import 'package:flutter/material.dart';

import 'clear_button_widget.dart';

class SearchFieldWidget extends StatefulWidget {
  final Function(String) onChanged;
  final TextStyle textStyle;
  final InputDecoration inputDecoration;
  final bool autoFocus;
  final Duration textChangeDuration;
  final Widget clearButton;
  final bool showClearButton;
  final int minSearchCharacters;

  const SearchFieldWidget({
    Key key,
    this.onChanged,
    this.inputDecoration,
    this.textStyle,
    this.autoFocus = true,
    this.textChangeDuration = const Duration(milliseconds: 500),
    this.clearButton,
    this.showClearButton = true,
    this.minSearchCharacters = 2,
  }) : super(key: key);

  @override
  _SearchFieldWidgetState createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  TextEditingController _textEditingController = TextEditingController();
  Timer _timer;

  void _onChanged() {
    if (_textEditingController.text.length < widget.minSearchCharacters) return;

    if (_timer?.isActive ?? false) {
      _timer?.cancel();
      _timer = null;
    }
    _timer = Timer(widget.textChangeDuration, () {
      widget.onChanged?.call(_textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (_) {
                _onChanged();
              },
              style: widget.textStyle ??
                  TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
              decoration: widget.inputDecoration ??
                  InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(.5),
                      fontSize: 18,
                    ),
                    border: InputBorder.none,
                  ),
              controller: _textEditingController,
              autofocus: widget.autoFocus ?? true,
              textInputAction: TextInputAction.search,
            ),
          ),
          if (widget.showClearButton)
            ClearButtonWidget(
              onPressed: () {
                _textEditingController.clear();
              },
              child: widget.clearButton,
            ),
        ],
      );

  @override
  void dispose() {
    _textEditingController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
