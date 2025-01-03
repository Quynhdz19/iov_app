import 'package:flutter/material.dart';

class CustomAddField extends StatefulWidget {
  final String label;
  final List<String> options;
  final Function(List<String>) onChanged;
  final String? initialSelectedItems;

  const CustomAddField({
    Key? key,
    required this.label,
    required this.options,
    required this.onChanged,
    this.initialSelectedItems,
  }) : super(key: key);

  @override
  State<CustomAddField> createState() => _CustomAddFieldState();
}

class _CustomAddFieldState extends State<CustomAddField> {
  List<String> selectedItems = [];
  String searchQuery = "";

  @override
  void initState() {
    print("CustomAddField initState called ${widget.initialSelectedItems}");
    super.initState();
    // Phân tách chuỗi khởi tạo thành danh sách các giá trị
    if (widget.initialSelectedItems != null && widget.initialSelectedItems!.isNotEmpty) {
      selectedItems = widget.initialSelectedItems!.split(', ').toList();
      print("selectedItems $selectedItems");
    }
  }

  void _openSelectionDialog() async {
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
                      Text(
                        widget.label,
                        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      // Search Field
                      TextField(
                        onChanged: (value) {
                          setStateDialog(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Search...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
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
                                    widget.onChanged(selectedItems); // Truyền giá trị ra ngoài
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
        widget.onChanged(selectedItems); // Truyền giá trị ra ngoài
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: InkWell(
              onTap: _openSelectionDialog,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  selectedItems.isEmpty ? "" : selectedItems.join(", "),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}