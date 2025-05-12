import 'package:flutter/material.dart';

import '../model/data.dart';

class AddNewItem extends StatefulWidget {
  AddNewItem({required this.fun, super.key});
  void Function(Data expense) fun;
  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? dateOfExpense;
  Category selectedCategory = Category.food;

  void presentDatePicker() async {
    final currentDate = DateTime.now();
    final firstDate =
        DateTime(currentDate.year - 1, currentDate.month, currentDate.day);

    final date = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: currentDate);
    setState(() {
      dateOfExpense = date;
    });
  }

  void checkData() {
    final doubleAmount = double.tryParse(amountController.text);
    final validAmount = doubleAmount == null || doubleAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        validAmount ||
        dateOfExpense == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Data'),
          content: const Text('Please Enter Valid Data'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }
    var newExpense = Data(
        title: titleController.text.trim(),
        amount: doubleAmount,
        date: dateOfExpense!,
        category: selectedCategory);
    widget.fun(newExpense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, keyboardSpace + 15),
              child: width < 500
                  ? Column(
                      children: [
                        TextField(
                          controller: titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(labelText: 'Title'),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  prefixText: '\$ ',
                                  labelText: 'Amount',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    dateOfExpense == null
                                        ? 'No Date Picked'
                                        : formatter.format(dateOfExpense!),
                                  ),
                                  IconButton(
                                    onPressed: presentDatePicker,
                                    icon: const Icon(Icons.calendar_month),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            DropdownButton(
                                value: selectedCategory,
                                items: Category.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name.toUpperCase(),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value == null) {
                                    return;
                                  }
                                  setState(() {
                                    selectedCategory = value;
                                  });
                                }),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: checkData,
                              child: const Text('Save expense'),
                            ),
                          ],
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: titleController,
                                maxLength: 50,
                                decoration:
                                    const InputDecoration(labelText: 'Title'),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  prefixText: '\$ ',
                                  labelText: 'Amount',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            DropdownButton(
                                value: selectedCategory,
                                items: Category.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name.toUpperCase(),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value == null) {
                                    return;
                                  }
                                  setState(() {
                                    selectedCategory = value;
                                  });
                                }),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  dateOfExpense == null
                                      ? 'No Date Picked'
                                      : formatter.format(dateOfExpense!),
                                ),
                                IconButton(
                                  onPressed: presentDatePicker,
                                  icon: const Icon(Icons.calendar_month),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: checkData,
                              child: const Text('Save expense'),
                            ),
                          ],
                        )
                      ],
                    )),
        ),
      );
    });
  }
}
