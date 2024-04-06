import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
  primaryColor: Color.fromRGBO(195, 177, 225, 1);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Page App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second': (context) => BudgetTrackerPage(),
        '/third': (context) => ThirdPage(),
      },
    );
  }
}
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _usernameFocused = false;
  bool _passwordFocused = false;

  @override
  void initState() {
    super.initState();
    _usernameFocus.addListener(_onUsernameFocusChange);
    _passwordFocus.addListener(_onPasswordFocusChange);
  }

  @override
  void dispose() {
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _onUsernameFocusChange() {
    setState(() {
      _usernameFocused = _usernameFocus.hasFocus;
    });
  }

  void _onPasswordFocusChange() {
    setState(() {
      _passwordFocused = _passwordFocus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WalletWatch'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(195, 177, 225, 100),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              focusNode: _usernameFocus,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _usernameFocused ? Color.fromRGBO(195, 177, 225, 1) : Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(195, 177, 225, 1), width: 2.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress, cursorColor: Color.fromRGBO(0, 0, 0, 1)
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              focusNode: _passwordFocus,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _passwordFocused ? Colors.yellow : Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(195, 177, 225, 1), width: 2.0),
                ),
              ),
              obscureText: true, cursorColor: Color.fromRGBO(0, 0, 0, 1)
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(195, 177, 225, 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class BudgetTrackerPage extends StatefulWidget {
  const BudgetTrackerPage({Key? key}) : super(key: key);

  @override
  _BudgetTrackerPageState createState() => _BudgetTrackerPageState();
}

class _BudgetTrackerPageState extends State<BudgetTrackerPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<Map<String, dynamic>> _transactions = [];
  double _totalExpenditure = 0.0;

  void _addTransaction() {
    final String enteredDescription = _descriptionController.text;
    final double? enteredAmount = double.tryParse(_amountController.text);
    if (enteredDescription.isEmpty || enteredAmount == null || enteredAmount <= 0) {
   
      return;
    }

    setState(() {
      _transactions.add({
        'description': enteredDescription,
        'amount': enteredAmount,
      });
      _totalExpenditure += enteredAmount;
      _amountController.clear();
      _descriptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
        backgroundColor: Color.fromRGBO(195, 177, 225, 1), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.show_chart),
            onPressed: () {
              Navigator.pushNamed(context, '/third');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:  Color.fromRGBO(195, 177, 225, 1), 
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder( 
                  borderSide: BorderSide(color: Color.fromRGBO(195, 177, 225, 1),  width: 2.0),
                ),
                hintStyle: TextStyle(
                  color: _amountController.text.isNotEmpty ? Colors.black : Color.fromRGBO(195, 177, 225, 1), 
                ),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)), 
              cursorColor: Color.fromRGBO(0, 0, 0, 1),  
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(195, 177, 225, 1),
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder( 
                  borderSide: BorderSide(color: Color.fromRGBO(195, 177, 225, 1), width: 2.0),
                ),
                hintStyle: TextStyle(
                  color: _descriptionController.text.isNotEmpty ? Colors.black : Color.fromRGBO(195, 177, 225, 1), 
                ),
              ),
              style: TextStyle(color: Color.fromRGBO(195, 177, 225, 1)), 
              keyboardType: TextInputType.text, 
              cursorColor: Colors.black, 
            ),

            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text('Add Transaction'),
              onPressed: _addTransaction,
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(195, 177, 225, 1), 
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              'Total Expenditure: ₹${_totalExpenditure.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(195, 177, 225, 1)), 
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.attach_money),
                      title: Text(_transactions[index]['description']),
                      trailing: Text('₹${_transactions[index]['amount'].toStringAsFixed(2)}', style: TextStyle(color: Color.fromRGBO(195, 177, 225, 1))), 
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  List<Goal> _goals = [];

  void addNewGoal(String title, double amount, double savedAmount) {
    setState(() {
      _goals.add(Goal(title: title, amount: amount, savedAmount: savedAmount, targetDate: null));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goal Tracker'),
        backgroundColor: Color.fromRGBO(195, 177, 225, 1),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Add Goal Button
            ElevatedButton(
              onPressed: () {
                _showAddGoalDialog();
              },
              child: Text('Add Goal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(195, 177, 225, 1), // Background color
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  final goal = _goals[index];
                  final progress = calculateGoalProgress(goal);
                  return GoalCard(
                    goal: goal,
                    progress: progress,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddGoalDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _titleController = TextEditingController();
        TextEditingController _amountController = TextEditingController();
        TextEditingController _savedAmountController = TextEditingController();
        return AlertDialog(
          title: Text('Add Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Enter Goal Name'),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Enter Goal Amount'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _savedAmountController,
                decoration: InputDecoration(labelText: 'Enter Saved Amount'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _amountController.text.isNotEmpty &&
                    _savedAmountController.text.isNotEmpty) {
                  addNewGoal(
                    _titleController.text,
                    double.parse(_amountController.text),
                    double.parse(_savedAmountController.text),
                  );
                  _titleController.clear();
                  _amountController.clear();
                  _savedAmountController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  double calculateGoalProgress(Goal goal) {
    if (goal.amount == 0.0) return 0.0;
    return (goal.savedAmount / goal.amount) * 100;
  }
}

class GoalCard extends StatelessWidget {
  final Goal goal;
  final double progress;

  GoalCard({required this.goal, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: progress >= 100.0 ? Colors.green[100] : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              goal.title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 8.0),
            Text('${progress.toStringAsFixed(2)}% Progress'),
          ],
        ),
      ),
    );
  }
}

class Goal {
  final String title;
  final double amount;
  final double savedAmount;
  final DateTime? targetDate;

  Goal({required this.title, required this.amount, required this.savedAmount, this.targetDate});
}
