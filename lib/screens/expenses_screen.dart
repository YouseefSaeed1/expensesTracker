import 'package:flutter/material.dart';
import 'package:second_app/chart/chart.dart';
import '../model/data.dart';
import 'add_new_item.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  void showTheSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (cntx) => AddNewItem(fun: addExpense),
    );
  }

  Widget showContent() {
    if (list.isEmpty) {
      return const Center(
        child: Text('there is no Expenses yet'),
      );
    } else {
      return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                margin: Theme.of(context).cardTheme.margin,
              ),
              key: ValueKey(list[index]),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                removeExpense(list[index]);
              },
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list[index].title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${list[index].amount.toStringAsFixed(2)}',
                          ),
                          Row(
                            children: [
                              Icon(
                                map[list[index].category],
                                color: Colors.brown,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                list[index].formattingTheData,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  void addExpense(Data expense) {
    setState(() {
      list.add(expense);
    });
  }

  void removeExpense(Data expense) {
    final expenseIndex = list.indexOf(expense);
    setState(() {
      list.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Deleted expense'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                list.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpensesTracker'),
        actions: [
          IconButton(
            onPressed: showTheSheet,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(13.0),
          child: width < 600
              ? Column(
                  children: [
                    Chart(expenses: list),
                    Expanded(
                      child: showContent(),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: Chart(expenses: list)),
                    Expanded(
                      child: showContent(),
                    ),
                  ],
                )),
    );
  }
}
