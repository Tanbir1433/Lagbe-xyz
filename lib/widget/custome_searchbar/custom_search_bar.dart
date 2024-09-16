import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  CustomSearchBarState createState() => CustomSearchBarState();
}

class CustomSearchBarState extends State<CustomSearchBar> {
  bool isExpanded = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          if (!isExpanded) {
            _focusNode.unfocus();
          }
        });
      },
      child: Material(
        color: isExpanded ? Colors.white : Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 1),
          child: FocusScope(
            node: FocusScopeNode(),
            child: Row(
              children: [
                const Icon(Icons.search,color: Colors.black54,size: 32),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: widget.controller,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 19,color: Colors.black54)
                    ),
                    autofocus: false,
                    onChanged: widget.onChanged,
                  ),
                ),
                /*GestureDetector(
                  onTap: () {
                    widget.controller.clear();
                    _focusNode.unfocus();
                  },
                  child: const Icon(Icons.close),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}