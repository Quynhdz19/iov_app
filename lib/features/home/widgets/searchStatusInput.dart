import 'package:flutter/material.dart';

class SearchStatusInput extends StatefulWidget {
  final String label;
  final List<String> options;
  final Function(List<String>) onChanged;
  final String? initialSelectedItems;
  final bool notEditing;
  final VoidCallback? onClear;

  const SearchStatusInput({
    Key? key,
    required this.label,
    required this.options,
    required this.onChanged,
    this.initialSelectedItems,
    required this.notEditing,
    this.onClear
  }) : super(key: key);

  @override
  State<SearchStatusInput> createState() => _SearchStatusInputState();
}

class _SearchStatusInputState extends State<SearchStatusInput> {
  List<String> selectedItems = [];
  String searchQuery = "";
  bool isCleared = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialSelectedItems != null && widget.initialSelectedItems!.isNotEmpty) {
      selectedItems = widget.initialSelectedItems!.split(', ').toList();
    }
  }

  /// Method to clear selected items
  void clearSelectedItems() {
    setState(() {
      selectedItems.clear();
      widget.onChanged(selectedItems); // Notify parent widget
    });
  }

  void _openSelectionDialog() async {
    if (widget.notEditing) {
      return;
    }
    final result = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (value) {
                          setStateDialog(() {
                            searchQuery = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "Search...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: widget.options
                                .where((option) =>
                                option.toLowerCase().contains(searchQuery.toLowerCase()))
                                .map(
                                  (option) => CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                title: Text(option),
                                value: selectedItems.contains(option),
                                onChanged: (isChecked) {
                                  setState(() {
                                    if (isChecked == true) {
                                      selectedItems.add(option);
                                    } else {
                                      selectedItems.remove(option);
                                    }
                                    widget.onChanged(selectedItems); // Notify parent widget
                                  });
                                  setStateDialog(() {});
                                },
                              ),
                            )
                                .toList(),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() => selectedItems = [...widget.options]);
                              widget.onChanged(selectedItems);
                              setStateDialog(() {});
                            },
                            child: const Text("Select All"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, selectedItems);
                            },
                            child: const Text("Done"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedItems = result;
        widget.onChanged(selectedItems); // Notify parent widget
      });
    }
  }
  void _clearSelection() {
    setState(() {
      selectedItems.clear();
      widget.onChanged(selectedItems);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        readOnly: true,
        onTap: _openSelectionDialog,
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        controller: TextEditingController(
          text: selectedItems.isEmpty ? "" : selectedItems.join(", "),
        ),
        style: TextStyle(
          color: widget.notEditing ? Colors.grey : Colors.black,
        ),
      ),
    );
  }
}